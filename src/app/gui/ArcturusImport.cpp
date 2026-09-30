#include "app/gui/ArcturusImport.h"
#ifdef SS_TOOL_SFM
#include "app/gui/Subprocess.h"
#include "data/Json.h"
#include "external/stb_image.h"
#include "external/stb_image_write.h"
#include "i18n/catalog/Arcturus.h"
#include "sfm/core/ArcturusCapture.h"
#include "sfm/core/Telemetry.h"
#include <chrono>
#include <filesystem>
#include <fstream>
#include <iomanip>
#include <limits>
#include <map>
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
} // namespace

bool extract_arcturus(const PrepJob &job, const PrepInput &input, const std::string &images,
                      PrepResult &result, const std::atomic<bool> &cancel,
                      const std::function<void(const std::string &)> &log, RunProgress *progress) {
    sfm::ArcturusCapture capture;
    if (!sfm::read_arcturus_capture(input.path, capture))
        return false;
    if (job.inputs.size() != 1)
        throw std::runtime_error(
            amsg::err_import_one_arcturus_recording_per_dataset_tracking.get());
    if (!command_exists(job.ffmpeg_exe))
        throw std::runtime_error(amsg::err_arcturus_import_requires_ffmpeg_set_its_location.get());
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
        for (int eye = 0; eye < 2; ++eye) {
            int rc = run_process(
                {job.ffmpeg_exe, "-nostdin", "-hide_banner", "-copyts", "-skip_frame", "nokey",
                 "-noautorotate", "-i", input.path, "-map", "0:v:" + std::to_string(eye), "-vf",
                 "showinfo", "-fps_mode", "passthrough", "-an", "-f", "null", "-"},
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
        selected = sfm::select_arcturus_keyframes(capture, times, job.max_frames, half_frame);
        count = (int)selected.size();
        log(spirula::i18n::format(amsg::keyframe_selected,
                                  {count, (int)times[0].size(), (int)times[1].size()}));
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
    identity << "AV1-native-v4 " << fs::file_size(input.path) << ' '
             << (long long)fs::last_write_time(input.path).time_since_epoch().count() << ' '
             << count << ' ' << (job.arcturus_keyframes ? "keyframes" : "uniform");
    std::ifstream prior(marker);
    std::string old;
    std::getline(prior, old);
    bool complete = job.resume && !job.redo_frames && old == identity.str() &&
                    fs::exists(fs::path(images) / ".arcturus-manifest.json");
    for (size_t i = 0; complete && i < selected.size(); ++i)
        for (int eye = 0; eye < 2; ++eye)
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
    for (int eye = 0; eye < 2; ++eye)
        fs::create_directories(fs::path(images) / ("cam" + std::to_string(eye)));
    std::ofstream poses(marker.string() + ".tmp");
    poses << identity.str() << '\n' << std::setprecision(17);
#ifdef __APPLE__
    bool hardware_decode = true;
#else
    bool hardware_decode = false;
#endif
    for (size_t i = 0; i < selected.size(); ++i) {
        if (cancel.load())
            throw std::runtime_error(amsg::err_arcturus_import_cancelled.get());
        std::array<double, 2> decoded_times{};
        for (int eye = 0; eye < 2; ++eye) {
            const auto &f = selected[i];
            const std::string rel = "cam" + std::to_string(eye) + "/" + frame_name(i, f.time);
            struct TemporaryFrame {
                fs::path path;
                ~TemporaryFrame() {
                    std::error_code ec;
                    fs::remove(path, ec);
                }
            } temporary{
                fs::temp_directory_path() /
                ("spirula-av1-" +
                 std::to_string(std::chrono::steady_clock::now().time_since_epoch().count()) +
                 ".png")};
            const fs::path &tmp = temporary.path;
            std::ostringstream time;
            time << std::setprecision(17) << std::max(0., f.time - half_frame);
            std::vector<std::string> args = {job.ffmpeg_exe,
                                             "-nostdin",
                                             "-hide_banner",
                                             "-loglevel",
                                             "info",
                                             "-y",
                                             "-copyts",
                                             "-noautorotate",
                                             "-ss",
                                             time.str(),
                                             "-i",
                                             input.path,
                                             "-map",
                                             "0:v:" + std::to_string(eye),
                                             "-frames:v",
                                             "1",
                                             "-vf",
                                             job.arcturus_keyframes ? "select=eq(key\\,1),showinfo"
                                                                    : "showinfo",
                                             "-pix_fmt",
                                             "rgb24",
                                             "-compression_level",
                                             "0",
                                             tmp.string()};
            if (hardware_decode)
                args.insert(args.begin() + 1, {"-hwaccel", "videotoolbox"});
            decoded_times[eye] = std::numeric_limits<double>::quiet_NaN();
            std::string decoder_output;
            bool decoded_keyframe = false;
            auto decode = [&]() {
                decoded_times[eye] = std::numeric_limits<double>::quiet_NaN();
                decoded_keyframe = false;
                return run_process(
                    args, "",
                    [&](const std::string &line) {
                        decoder_output += line + "\n";
                        if (decoder_output.size() > 8192)
                            decoder_output.erase(0, decoder_output.size() - 8192);
                        auto at = line.find("pts_time:");
                        if (at != std::string::npos && !std::isfinite(decoded_times[eye])) {
                            decoded_times[eye] = std::strtod(line.c_str() + at + 9, nullptr);
                            decoded_keyframe = line.find("iskey:1") != std::string::npos;
                        }
                    },
                    cancel);
            };
            int rc = decode();
            if (rc != 0 && !cancel.load() && hardware_decode) {
                hardware_decode = false;
                args.erase(args.begin() + 1, args.begin() + 3);
                log(amsg::cpu_fallback.get());
                rc = decode();
            }
            if (rc != 0 || !fs::exists(tmp)) {
                log(decoder_output);
                throw std::runtime_error(spirula::i18n::format(amsg::decode_failed, {time.str()}));
            }
            if (!std::isfinite(decoded_times[eye]) || std::abs(decoded_times[eye] - f.time) > .075)
                throw std::runtime_error(amsg::err_arcturus_video_frame_is_missing_near_its.get());
            if (job.arcturus_keyframes &&
                (!decoded_keyframe || std::abs(decoded_times[eye] - f.time) > .002))
                throw std::runtime_error(amsg::keyframe_decode.get());
            int w = 0, h = 0, n = 0;
            std::ifstream png(tmp, std::ios::binary | std::ios::ate);
            const auto size = png.tellg();
            if (size <= 0 || size > 256 * 1024 * 1024)
                throw std::runtime_error(amsg::err_invalid_decoded_arcturus_image_size.get());
            std::vector<unsigned char> bytes((size_t)size);
            png.seekg(0);
            png.read((char *)bytes.data(), size);
            if (!png)
                throw std::runtime_error(amsg::err_cannot_read_decoded_arcturus_image.get());
            png.close();
            unsigned char *rgb =
                stbi_load_from_memory(bytes.data(), (int)bytes.size(), &w, &h, &n, 3);
            if (!rgb)
                throw std::runtime_error(amsg::err_cannot_read_decoded_arcturus_frame.get());
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
            stbi_image_free(rgb);
            fs::remove(tmp);
            if (!saved)
                throw std::runtime_error(amsg::err_cannot_save_arcturus_image.get());
            poses << rel << ' ' << rotations[eye];
            for (double v : f.world_from_camera[eye].R)
                poses << ' ' << v;
            auto p = f.world_from_camera[eye].t;
            poses << ' ' << p.x << ' ' << p.y << ' ' << p.z << '\n';
        }
        if (std::abs(decoded_times[0] - decoded_times[1]) > std::max(.002, half_frame))
            throw std::runtime_error(
                amsg::err_arcturus_stereo_video_tracks_are_not_synchronized.get());
        const auto message =
            spirula::i18n::format(amsg::extracting, {(long long)(i + 1), (long long)count});
        log(message);
        if (progress) {
            progress->count(Stage::Frames, i + 1, count);
            progress->detail(Stage::Frames, message);
        }
    }
    std::ofstream manifest(fs::path(images) / ".arcturus-manifest.json");
    manifest << sfm::manifest_write(sfm::arcturus_manifest(capture, input.subdir), true);
    manifest.close();
    poses.close();
    if (!manifest || !poses)
        throw std::runtime_error(amsg::err_cannot_save_arcturus_calibration_and_poses.get());
    fs::rename(marker.string() + ".tmp", marker);
    result.frames_rebuilt = true;
    result.per_folder_cameras = true;
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
void align_arcturus_dataset(const std::string &, const std::string &) {}
} // namespace gui
#endif
