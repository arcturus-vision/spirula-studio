#include "app/gui/ArcturusImport.h"
#ifdef SS_TOOL_SFM
#include "app/FfmpegVideo.h"
#include "app/gui/ArcturusFrameSelect.h"
#include "app/gui/Subprocess.h"
#include "data/Json.h"
#include "external/stb_image_write.h"
#include "external/stb_image.h"
#include "i18n/catalog/Arcturus.h"
#include "sfm/core/ArcturusCapture.h"
#include "app/gui/ArcturusMask.h"
#include "sfm/core/Telemetry.h"
#include <chrono>
#include <cmath>
#include <condition_variable>
#include <cstdio>
#include <cstdlib>
#include <deque>
#include <filesystem>
#include <fstream>
#include <iomanip>
#include <limits>
#include <map>
#include <mutex>
#include <regex>
#include <sstream>

namespace gui {
namespace amsg = spirula::i18n::msg::arcturus;
namespace fs = std::filesystem;
namespace {
void tone_map(unsigned char *pixels, int count, bool bt2020) {
    static const auto hlg = [] {
        std::array<double, 256> lut{};
        for (size_t i = 0; i < lut.size(); ++i) {
            double e = i / 255.;
            lut[i] = e <= .5 ? e * e / 3 : (std::exp((e - .55991073) / .17883277) + .28466892) / 12;
        }
        return lut;
    }();
    static const auto srgb = [] {
        std::array<unsigned char, 65536> lut{};
        for (size_t i = 0; i < lut.size(); ++i) {
            double c = i / 65535.;
            c = c <= .0031308 ? 12.92 * c : 1.055 * std::pow(c, 1 / 2.4) - .055;
            lut[i] = (unsigned char)std::round(c * 255);
        }
        return lut;
    }();
    for (int i = 0; i < count; ++i) {
        double v[3];
        for (int j = 0; j < 3; ++j) {
            v[j] = hlg[pixels[3 * i + j]];
        }
        if (bt2020) {
            double r = 1.660491 * v[0] - .587641 * v[1] - .072850 * v[2];
            double g = -.124550 * v[0] + 1.132900 * v[1] - .008349 * v[2];
            double b = -.018151 * v[0] - .100579 * v[1] + 1.118730 * v[2];
            v[0] = r;
            v[1] = g;
            v[2] = b;
        }
        double l = std::max(0., .2126 * v[0] + .7152 * v[1] + .0722 * v[2]);
        double gain = std::pow(l, .2), display = l * gain;
        gain *= (5 + display) / (1 + 5 * display);
        for (int j = 0; j < 3; ++j) {
            pixels[3 * i + j] = srgb[(size_t)std::round(std::clamp(v[j] * gain, 0., 1.) * 65535)];
        }
    }
}
std::string frame_name(size_t i, double time) {
    char b[80];
    std::snprintf(b, sizeof b, "%04zu-%.6f.jpg", i, time);
    return b;
}

struct FrameStamp {
    double time = std::numeric_limits<double>::quiet_NaN();
    bool key = false;
    bool intra = false;
};

bool probe_keyframes(const PrepJob &job, const PrepInput &input,
                     std::array<std::vector<double>, 2> &times,
                     const std::atomic<bool> &cancel) {
    fs::path probe = fs::path(job.ffmpeg_exe).parent_path() /
#ifdef _WIN32
        "ffprobe.exe";
#else
        "ffprobe";
#endif
    if (!command_exists(probe.string())) return false;
    std::map<int, std::vector<double>> tracks;
    bool valid = true;
    const int rc = run_process(
        {probe.string(), "-v", "error", "-select_streams", "v", "-show_entries",
         "packet=stream_index,pts_time,flags", "-of", "compact=p=0:nk=0", input.path}, "",
        [&](const std::string &line) {
            if (line.find("stream_index=") != 0) return;
            int stream = -1;
            double time = 0;
            char flags[16]{};
            if (std::sscanf(line.c_str(), "stream_index=%d|pts_time=%lf|flags=%15s",
                            &stream, &time, flags) != 3 || !std::isfinite(time)) {
                valid = false;
                return;
            }
            auto &track = tracks[stream];
            if (flags[0] == 'K') track.push_back(time);
        }, cancel);
    if (rc != 0 || !valid || tracks.size() != 2) return false;
    int eye = 0;
    for (auto &[stream, track] : tracks) {
        if (track.empty()) return false;
        times[eye++] = std::move(track);
    }
    return true;
}

class ArcturusDecoder {
public:
    ArcturusDecoder(const PrepJob &job, const PrepInput &input, int eye,
                    const std::vector<sfm::ArcturusFrame> &selected, double half_frame,
                    bool legacy_filter_script, const std::atomic<bool> &cancel,
                    const std::function<void(const std::string &)> &log)
        : job(job), input(input), eye(eye), selected(selected), half_frame(half_frame),
          cancel(cancel), log(log), legacy_filter_script(legacy_filter_script) {
        for (const auto &frame : selected) times.push_back(frame.time);
        filter_path = fs::temp_directory_path() /
            ("spirula-select-" + std::to_string(
                std::chrono::steady_clock::now().time_since_epoch().count()) +
             "-" + std::to_string(eye) + ".txt");
    }
    ~ArcturusDecoder() {
        frames.close();
        std::error_code ec;
        fs::remove(filter_path, ec);
    }

    void next(size_t index, std::vector<uint8_t> &rgb, int &w, int &h, FrameStamp &stamp) {
        if (started && index >= chunk_end) {
            frames.close();
            started = false;
        }
        std::string error;
        for (;;) {
            if (cancel.load())
                throw std::runtime_error(amsg::err_arcturus_import_cancelled.get());
            bool ok = started || start(index, error);
            if (ok) ok = frames.next(rgb, w, h, error);
            if (ok) {
                std::unique_lock<std::mutex> lock(mutex);
                const auto deadline = std::chrono::steady_clock::now() + std::chrono::seconds(5);
                while (stamps.empty() && !cancel.load() &&
                       std::chrono::steady_clock::now() < deadline)
                    ready.wait_for(lock, std::chrono::milliseconds(20));
                ok = !stamps.empty();
                if (ok) { stamp = stamps.front(); stamps.pop_front(); }
            }
            if (cancel.load())
                throw std::runtime_error(amsg::err_arcturus_import_cancelled.get());
            if (ok) {
                if (stamp.time < selected[index].time - half_frame) continue;
                return;
            }
            if (!error.empty()) log(error);
            frames.close();
            started = false;
            if (!hardware)
                throw std::runtime_error(spirula::i18n::format(
                    amsg::decode_failed, {std::to_string(selected[index].time)}));
            hardware = false;
            log(amsg::cpu_fallback.get());
        }
    }

private:
    bool start(size_t index, std::string &error) {
        {
            std::lock_guard<std::mutex> lock(mutex);
            stamps.clear();
        }
        chunk_end = detail::arcturus_chunk_end(times, index, job.arcturus_keyframes);
        std::ofstream script(filter_path);
        script << detail::arcturus_frame_filter(times, index, chunk_end, job.arcturus_keyframes,
                                               half_frame);
        script.close();
        if (!script) {
            error = amsg::err_cannot_save_arcturus_image.get();
            return false;
        }
        std::vector<std::string> args{job.ffmpeg_exe, "-nostdin", "-hide_banner",
                                      "-loglevel", "info", "-copyts"};
        if (hardware) {
#ifdef __APPLE__
            args.insert(args.end(), {"-hwaccel", "videotoolbox"});
#elif defined(_WIN32)
            args.insert(args.end(), {"-hwaccel", "d3d11va"});
#else
            args.insert(args.end(), {"-hwaccel", "auto"});
#endif
        }
        if (job.arcturus_keyframes)
            args.insert(args.end(), {"-skip_frame", "nokey"});
        std::ostringstream begin;
        begin << std::setprecision(17) << std::max(0., selected[index].time - half_frame);
        args.insert(args.end(), {"-noautorotate", "-ss", begin.str(), "-i", input.path,
                                 "-map", "0:v:" + std::to_string(eye),
                                 legacy_filter_script ? "-filter_script:v" : "-/filter:v", filter_path.string(),
                                 "-frames:v", std::to_string(chunk_end - index),
                                 "-fps_mode", "passthrough", "-an", "-sn", "-dn"});
        started = frames.open(args, app::FfmpegFrameFormat::Rgb8, error, [&](const std::string &line) {
            const auto at = line.find("pts_time:");
            if (line.find("Parsed_showinfo") == std::string::npos || at == std::string::npos)
                return;
            FrameStamp stamp{std::strtod(line.c_str() + at + 9, nullptr),
                             line.find("iskey:1") != std::string::npos,
                             line.find("type:I") != std::string::npos};
            std::lock_guard<std::mutex> lock(mutex);
            stamps.push_back(stamp);
            ready.notify_one();
        }, &cancel);
        return started;
    }

    const PrepJob &job;
    const PrepInput &input;
    int eye;
    const std::vector<sfm::ArcturusFrame> &selected;
    double half_frame;
    const std::atomic<bool> &cancel;
    const std::function<void(const std::string &)> &log;
    fs::path filter_path;
    std::vector<double> times;
    size_t chunk_end = 0;
    std::mutex mutex;
    std::condition_variable ready;
    std::deque<FrameStamp> stamps;
    app::FfmpegFrames frames;
    bool hardware = true, started = false;
    bool legacy_filter_script;
};
} // namespace

bool extract_arcturus(const PrepJob &job, const PrepInput &input, const std::string &images,
                      PrepResult &result, const std::atomic<bool> &cancel,
                      const std::function<void(const std::string &)> &log, RunProgress *progress) {
    sfm::ArcturusCapture capture;
    if (!sfm::read_arcturus_capture(input.path, capture, [&] {
            if (cancel.load())
                throw std::runtime_error(amsg::err_arcturus_import_cancelled.get());
        }))
        return false;
    if (job.inputs.size() != 1)
        throw std::runtime_error(
            amsg::err_import_one_arcturus_recording_per_dataset_tracking.get());
    if (!command_exists(job.ffmpeg_exe))
        throw std::runtime_error(amsg::err_arcturus_import_requires_ffmpeg_set_its_location.get());
    const int first_eye = job.arcturus_eye == 2 ? 1 : 0;
    const int end_eye = job.arcturus_eye == 1 ? 1 : 2;
    const int eye_count = end_eye - first_eye;
    int count =
        std::clamp((int)std::round((capture.frames.back().time - capture.frames.front().time) *
                                   input_fps(job, input)),
                   3, 500);
    if (job.max_frames > 0)
        count = std::min(count, job.max_frames);
    count = std::min(count, (int)capture.frames.size());
    std::vector<sfm::ArcturusFrame> selected;
    std::vector<double> intervals;
    for (size_t i = 1; i < capture.frames.size(); ++i) {
        double dt = capture.frames[i].time - capture.frames[i - 1].time;
        if (dt > 0)
            intervals.push_back(dt);
    }
    std::sort(intervals.begin(), intervals.end());
    const double half_frame = intervals[intervals.size() / 2] * .5;
    if (job.arcturus_keyframes) {
        log(amsg::keyframe_scan.get());
        std::array<std::vector<double>, 2> times;
        if (!probe_keyframes(job, input, times, cancel)) {
            times = {};
            for (int eye = 0; eye < 2; ++eye) {
                int rc = run_process(
                    {job.ffmpeg_exe, "-nostdin", "-hide_banner", "-copyts", "-skip_frame", "nokey",
                     "-noautorotate", "-i", input.path, "-map", "0:v:" + std::to_string(eye), "-vf",
                     "showinfo=checksum=0", "-fps_mode", "passthrough", "-an", "-f", "null", "-"},
                    "",
                    [&](const std::string &line) {
                        auto at = line.find("pts_time:");
                        if (at != std::string::npos && line.find("iskey:1") != std::string::npos)
                            times[eye].push_back(std::strtod(line.c_str() + at + 9, nullptr));
                    },
                    cancel);
                if (cancel.load())
                    throw std::runtime_error(amsg::err_arcturus_import_cancelled.get());
                if (rc != 0)
                    throw std::runtime_error(amsg::keyframe_scan_failed.get());
            }
        }
        if (cancel.load())
            throw std::runtime_error(amsg::err_arcturus_import_cancelled.get());
        selected = sfm::select_arcturus_keyframes(
            capture, times, job.max_frames, half_frame, input_fps(job, input));
        count = (int)selected.size();
        log(spirula::i18n::format(
            eye_count == 2 ? amsg::keyframe_selected : amsg::keyframe_selected_single,
            {count, eye_count * count, (int)times[0].size(), (int)times[1].size()}));
    } else {
        selected = sfm::select_arcturus_frames(capture, count);
    }
    auto rotations = sfm::video_display_rotations(input.path);
    if (rotations.size() != 2)
        throw std::runtime_error(amsg::err_arcturus_recording_must_have_exactly_two_video.get());
    std::array<bool, 2> hlg{}, bt2020{};
    int track = -1;
    run_process(
        {job.ffmpeg_exe, "-nostdin", "-hide_banner", "-i", input.path}, "",
        [&](const std::string &s) {
            if (s.find("Video:") != std::string::npos) {
                ++track;
                if (track < 2) {
                    hlg[track] = s.find("arib-std-b67") != std::string::npos;
                    bt2020[track] = s.find("bt2020") != std::string::npos;
                }
            }
        },
        cancel);
    log(amsg::calibrated.get());
    const fs::path marker = fs::path(images) / ".arcturus-poses.txt";
    std::ostringstream identity;
    identity << "AV1-native-v5 " << fs::file_size(input.path) << ' '
             << (long long)fs::last_write_time(input.path).time_since_epoch().count() << ' '
             << count << ' ' << (job.arcturus_keyframes ? "keyframes" : "uniform")
             << " eyes=" << job.arcturus_eye;
    std::ifstream prior(marker);
    std::string old;
    std::getline(prior, old);
    bool complete = job.resume && !job.redo_frames && old == identity.str() &&
                    fs::exists(fs::path(images) / ".arcturus-manifest.json");
    for (size_t i = 0; complete && i < selected.size(); ++i)
        for (int eye = first_eye; eye < end_eye; ++eye)
            complete = complete && fs::exists(fs::path(images) / ("cam" + std::to_string(eye)) /
                                              frame_name(i, selected[i].time));
    if (complete) {
        result.per_folder_cameras = true;
        return true;
    }
    if (!fs::exists(marker) && !fs::exists(marker.string() + ".tmp")) {
        for (int eye = 0; eye < 2; ++eye) {
            auto dir = fs::path(images) / ("cam" + std::to_string(eye));
            if (fs::exists(dir) && !fs::is_empty(dir))
                throw std::runtime_error(
                    amsg::err_arcturus_output_contains_images_from_another_import.get());
        }
    } else {
        for (int eye = 0; eye < 2; ++eye) {
            auto dir = fs::path(images) / ("cam" + std::to_string(eye));
            if (!fs::exists(dir))
                continue;
            for (const auto &e : fs::directory_iterator(dir)) {
                if (std::regex_match(e.path().filename().string(),
                                     std::regex("[0-9]+-[0-9]+\\.[0-9]{6}\\.jpg")))
                    fs::remove(e.path());
            }
        }
    }
    if (fs::exists(marker))
        fs::remove(marker);
    for (int eye = first_eye; eye < end_eye; ++eye)
        fs::create_directories(fs::path(images) / ("cam" + std::to_string(eye)));
    std::ofstream poses(marker.string() + ".tmp");
    poses << identity.str() << '\n' << std::setprecision(17);
    bool legacy_filter_script = false;
    if (run_process({job.ffmpeg_exe, "-hide_banner", "-h", "full"}, "",
                    [&](const std::string &line) {
                        if (line.find("-filter_script") != std::string::npos)
                            legacy_filter_script = true;
                    }, cancel) != 0)
        throw std::runtime_error(amsg::err_arcturus_import_requires_ffmpeg_set_its_location.get());
    std::array<std::unique_ptr<ArcturusDecoder>, 2> decoders;
    for (int eye = first_eye; eye < end_eye; ++eye)
        decoders[eye] = std::make_unique<ArcturusDecoder>(
            job, input, eye, selected, half_frame, legacy_filter_script, cancel, log);
    for (size_t i = 0; i < selected.size(); ++i) {
        if (cancel.load())
            throw std::runtime_error(amsg::err_arcturus_import_cancelled.get());
        std::array<double, 2> decoded_times{};
        for (int eye = first_eye; eye < end_eye; ++eye) {
            const auto &f = selected[i];
            const std::string rel = "cam" + std::to_string(eye) + "/" + frame_name(i, f.time);
            std::vector<uint8_t> pixels;
            int w = 0, h = 0;
            FrameStamp stamp;
            decoders[eye]->next(i, pixels, w, h, stamp);
            decoded_times[eye] = stamp.time;
            if (!std::isfinite(stamp.time) || std::abs(stamp.time - f.time) > .075)
                throw std::runtime_error(amsg::err_arcturus_video_frame_is_missing_near_its.get());
            if (job.arcturus_keyframes && (!stamp.key || !stamp.intra || std::abs(stamp.time - f.time) > .002))
                throw std::runtime_error(amsg::keyframe_decode.get());
            auto *rgb = pixels.data();
            if (i == 0) {
                auto &c = capture.cameras[eye];
                c.params[0] *= (double)w / c.width;
                c.params[2] *= (double)w / c.width;
                c.params[1] *= (double)h / c.height;
                c.params[3] *= (double)h / c.height;
                if (c.model == "kb-polar-spline") {
                    c.params[9] *= (double)w / c.width;
                    c.params[10] *= (double)h / c.height;
                }
                c.width = w;
                c.height = h;
            }
            if (hlg[eye])
                tone_map(rgb, w * h, bt2020[eye]);
            std::vector<unsigned char> jpeg;
            bool saved = stbi_write_jpg_to_func(
                             [](void *ctx, void *data, int length) {
                                 auto &encoded = *static_cast<std::vector<unsigned char> *>(ctx);
                                 const auto *first = static_cast<unsigned char *>(data);
                                 encoded.insert(encoded.end(), first, first + length);
                             },
                             &jpeg, w, h, 3, rgb, 95) != 0;
            std::ofstream image(fs::path(images) / rel, std::ios::binary);
            image.write((const char *)jpeg.data(), jpeg.size());
            image.close();
            saved = saved && bool(image);
            if (!saved)
                throw std::runtime_error(amsg::err_cannot_save_arcturus_image.get());
            poses << rel << ' ' << rotations[eye];
            for (double v : f.world_from_camera[eye].R)
                poses << ' ' << v;
            auto p = f.world_from_camera[eye].t;
            poses << ' ' << p.x << ' ' << p.y << ' ' << p.z << '\n';
        }
        if (eye_count == 2 &&
            std::abs(decoded_times[0] - decoded_times[1]) > std::max(.002, half_frame))
            throw std::runtime_error(
                amsg::err_arcturus_stereo_video_tracks_are_not_synchronized.get());
        const auto message =
            spirula::i18n::format(eye_count == 2 ? amsg::extracting : amsg::extracting_single,
                                  {(long long)(i + 1), (long long)count,
                                   (long long)(eye_count * (i + 1)), (long long)(eye_count * count)});
        log(message);
        if (progress) {
            progress->count(Stage::Frames, eye_count * (i + 1), eye_count * count);
            progress->detail(Stage::Frames, message);
        }
    }
    std::ofstream manifest(fs::path(images) / ".arcturus-manifest.json");
    manifest << sfm::manifest_write(sfm::arcturus_manifest(capture, input.subdir, job.arcturus_eye), true);
    manifest.close();
    poses.close();
    if (!manifest || !poses)
        throw std::runtime_error(amsg::err_cannot_save_arcturus_calibration_and_poses.get());
    fs::rename(marker.string() + ".tmp", marker);
    result.frames_rebuilt = true;
    result.per_folder_cameras = true;
    return true;
}

bool apply_arcturus_masks(const std::string &images, const std::string &masks,
                          const std::atomic<bool> &cancel, bool combine_existing, int degrees) {
    const fs::path root(images), marker = root / ".arcturus-manifest.json";
    if (!fs::exists(marker)) return false;
    const auto manifest = sfm::manifest_read(marker.string());
    if (manifest.cameras.empty() || manifest.cameras.size() > 2)
        throw std::runtime_error(amsg::mask_failed.get());
    int cameras_seen = 0;
    for (const auto &camera : manifest.cameras) {
        const auto name = fs::path(camera.prefix).filename();
        const int bit = name == "cam0" ? 1 : name == "cam1" ? 2 : 0;
        if (!bit || (cameras_seen & bit)) throw std::runtime_error(amsg::mask_failed.get());
        cameras_seen |= bit;
        const auto folder = root / name;
        std::vector<unsigned char> boundary;
        int width = 0, height = 0;
        int count = 0;
        for (const auto &entry : fs::directory_iterator(folder)) {
            if (entry.path().extension() != ".jpg") continue;
            if (cancel.load())
                throw std::runtime_error(amsg::err_arcturus_import_cancelled.get());
            int w = 0, h = 0, n = 0;
            if (!stbi_info(entry.path().string().c_str(), &w, &h, &n))
                throw std::runtime_error(amsg::err_cannot_read_decoded_arcturus_frame.get());
            if (boundary.empty()) {
                boundary = detail::arcturus_boundary_mask(camera.model, camera.params, w, h, degrees);
                width = w;
                height = h;
            }
            if (w != width || h != height)
                throw std::runtime_error(amsg::mask_failed.get());
            auto path = fs::path(masks) / folder.filename() / entry.path().filename();
            path.replace_extension(".png");
            auto pixels = boundary;
            bool unchanged = false;
            if (fs::exists(path)) {
                auto *existing = stbi_load(path.string().c_str(), &w, &h, &n, 1);
                if (!existing || w != width || h != height) {
                    stbi_image_free(existing);
                    throw std::runtime_error(amsg::mask_failed.get());
                }
                if (combine_existing)
                    for (size_t i = 0; i < pixels.size(); ++i)
                        if (pixels[i]) pixels[i] = existing[i];
                unchanged = std::equal(pixels.begin(), pixels.end(), existing);
                stbi_image_free(existing);
            }
            ++count;
            if (unchanged) continue;
            fs::create_directories(path.parent_path());
            auto temporary = path;
            temporary += ".tmp";
            if (!stbi_write_png(temporary.string().c_str(), width, height, 1,
                                pixels.data(), width))
                throw std::runtime_error(amsg::mask_failed.get());
            fs::rename(temporary, path);
        }
        if (!count) throw std::runtime_error(amsg::mask_failed.get());
    }
    return true;
}

void align_arcturus_dataset(const std::string &workspace, const std::string &images) {
    sfm::align_arcturus_dataset(workspace, images);
}
} // namespace gui
#else
namespace gui {
bool extract_arcturus(const PrepJob &, const PrepInput &, const std::string &, PrepResult &,
                      const std::atomic<bool> &, const std::function<void(const std::string &)> &,
                      RunProgress *) {
    return false;
}
bool apply_arcturus_masks(const std::string &, const std::string &,
                          const std::atomic<bool> &, bool, int) { return false; }
void align_arcturus_dataset(const std::string &, const std::string &) {}
} // namespace gui
#endif
