#include "app/gui/ArcturusImport.h"
#include "app/FfmpegVideo.h"
#include "app/gui/Subprocess.h"
#include "core/Env.h"
#include "app/gui/ArcturusFrameSelect.h"
#include "app/gui/ArcturusMask.h"
#include "sfm/core/Manifest.h"
#include "external/stb_image.h"
#include "external/stb_image_write.h"
#include <chrono>
#include <cmath>
#include <cstdlib>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <thread>
#include <utility>
#ifdef _WIN32
#include <process.h>
#else
#include <unistd.h>
#endif

namespace {
int ffmpeg_proxy(int argc, char **argv, const char *exe) {
    std::vector<char *> args{const_cast<char *>(exe)};
    const char *fail_after = spirula::env("TEST_FFMPEG_FAIL_AFTER");
    bool hardware = false;
    for (int i = 1; i < argc; ++i) {
        if (std::string(argv[i]) == "-hwaccel") {
            hardware = true;
            if (!fail_after) {
                std::cerr << "Injected hardware decoder failure\n";
                return 42;
            }
            ++i;
            continue;
        }
        args.push_back(argv[i]);
    }
    if (hardware)
        args.insert(args.end() - 1, {const_cast<char *>("-frames:v"), const_cast<char *>(fail_after)});
    args.push_back(nullptr);
#ifdef _WIN32
    return (int)_spawnvp(_P_WAIT, exe, args.data());
#else
    execvp(exe, args.data());
    return 127;
#endif
}

struct CancelTimer {
    std::atomic<bool> done{false};
    std::thread worker;
    CancelTimer(std::atomic<bool> &cancel, int ms) {
        if (ms > 0) worker = std::thread([&, ms] {
            const auto until = std::chrono::steady_clock::now() + std::chrono::milliseconds(ms);
            while (!done && std::chrono::steady_clock::now() < until)
                std::this_thread::sleep_for(std::chrono::milliseconds(10));
            if (!done) cancel = true;
        });
    }
    ~CancelTimer() { done = true; if (worker.joinable()) worker.join(); }
};

int mask_test() {
    auto require = [](bool ok, const char *why) {
        if (!ok) throw std::runtime_error(why);
    };
    const std::vector<double> kb{31., 33., 37., 29., .01, -.002, .0001, 0.};
    auto mask = gui::detail::arcturus_boundary_mask("opencv-fisheye", kb, 80, 64);
    sfm::Camera camera;
    camera.model = sfm::CamModel::OpenCVFisheye;
    sfm::unpackColmap(camera, kb.data());
    const double theta = 65. * std::acos(-1.) / 180.;
    const double radius = theta * (1 + kb[4]*theta*theta + kb[5]*std::pow(theta,4) +
                                   kb[6]*std::pow(theta,6));
    for (int y = 0; y < 64; ++y)
        for (int x = 0; x < 80; ++x) {
            double u = (x+.5-kb[2])/(kb[0]*radius);
            double v = (y+.5-kb[3])/(kb[1]*radius);
            require((mask[y*80+x] != 0) == (u*u+v*v <= 1), "KB4 ellipse mismatch");
        }
    const auto narrow = gui::detail::arcturus_boundary_mask("opencv-fisheye", kb, 80, 64, 100);
    const auto wide = gui::detail::arcturus_boundary_mask("opencv-fisheye", kb, 80, 64, 160);
    auto kept = [](const auto &pixels) {
        return std::count(pixels.begin(), pixels.end(), 255);
    };
    require(kept(narrow) < kept(mask) && kept(mask) < kept(wide),
            "radial angle did not change mask coverage");
    for (size_t i = 0; i < mask.size(); ++i)
        require(narrow[i] <= mask[i] && mask[i] <= wide[i], "radial masks are not nested");
    for (int degrees : {0, 361}) {
        bool invalid = false;
        try { gui::detail::arcturus_boundary_mask("opencv-fisheye", kb, 80, 64, degrees); }
        catch (const std::runtime_error &) { invalid = true; }
        require(invalid, "invalid radial angle accepted");
    }
    auto polar = kb;
    polar.insert(polar.end(), {1., 31., 33.});
    polar.resize(61, 0.);
    require(gui::detail::arcturus_boundary_mask("kb-polar-spline", polar, 80, 64) == mask,
            "zero spline changed boundary");
    polar[11+12] = .02;
    polar[36+12] = -.01;
    camera.model = sfm::CamModel::KBPolarSpline;
    sfm::unpackColmap(camera, polar.data());
    auto shifted = gui::detail::arcturus_boundary_mask("kb-polar-spline", polar, 80, 64);
    for (double degrees : {60., 70.}) {
        const double angle = degrees * std::acos(-1.) / 180.;
        const auto pixel = camera.project({std::sin(angle), 0, std::cos(angle)});
        const int x = (int)pixel.x, y = (int)pixel.y;
        require(x >= 0 && x < 80 && y >= 0 && y < 64, "polar probe outside test image");
        require((shifted[y*80+x] != 0) == (degrees < 65.), "polar angular cutoff mismatch");
    }
    bool rejected = false;
    try { gui::detail::arcturus_boundary_mask("pinhole", kb, 80, 64); }
    catch (...) { rejected = true; }
    require(rejected, "unsupported calibration accepted");
    namespace fs = std::filesystem;
    struct Temp {
        fs::path root = fs::temp_directory_path() /
            ("spirula-mask-test-" + std::to_string(std::chrono::steady_clock::now().time_since_epoch().count()));
        ~Temp() { std::error_code ec; fs::remove_all(root, ec); }
    } temp;
    fs::create_directories(temp.root / "images");
    std::atomic<bool> cancel{false};
    require(!gui::apply_arcturus_masks((temp.root/"images").string(),
                                      (temp.root/"masks").string(), cancel), "ordinary input masked");
    sfm::Manifest manifest;
    for (int eye = 0; eye < 2; ++eye) {
        const auto folder = "cam" + std::to_string(eye);
        fs::create_directories(temp.root / "images" / folder);
        std::vector<unsigned char> rgb(80*64*3, 128);
        require(stbi_write_jpg((temp.root/"images"/folder/"frame.jpg").string().c_str(),
                               80, 64, 3, rgb.data(), 95), "test image write");
        sfm::ManifestCamera c;
        c.prefix = "clip/" + folder;
        c.model = "opencv-fisheye";
        c.params = kb;
        manifest.cameras.push_back(c);
    }
    std::ofstream(temp.root/"images/.arcturus-manifest.json") << sfm::manifest_write(manifest, true);
    fs::create_directories(temp.root/"masks/cam0");
    auto segmented = std::vector<unsigned char>(80*64, 255);
    segmented[29*80+37] = 0;
    require(stbi_write_png((temp.root/"masks/cam0/frame.png").string().c_str(),
                           80,64,1,segmented.data(),80), "test segment write");
    fs::file_time_type prior_time;
    for (int pass = 0; pass < 2; ++pass) {
        require(gui::apply_arcturus_masks((temp.root/"images").string(),
                                          (temp.root/"masks").string(),cancel), "mask pass failed");
        const auto time = fs::last_write_time(temp.root/"masks/cam0/frame.png");
        if (pass) require(time == prior_time, "resume rewrote an unchanged mask");
        prior_time = time;
        for (int eye = 0; eye < 2; ++eye) {
            int w,h,n;
            auto path = temp.root/"masks"/("cam"+std::to_string(eye))/"frame.png";
            auto *pixels = stbi_load(path.string().c_str(),&w,&h,&n,1);
            require(pixels && w==80 && h==64, "output mask missing");
            for (size_t i=0; i<mask.size(); ++i)
                require(pixels[i] == (eye==0 && i==29*80+37 ? 0 : mask[i]),
                        "mask intersection or resume changed pixels");
            stbi_image_free(pixels);
        }
    }
    require(gui::apply_arcturus_masks((temp.root/"images").string(),
                                      (temp.root/"masks").string(),cancel,false),
            "replacing disabled segmentation failed");
    int w,h,n;
    auto *restored = stbi_load((temp.root/"masks/cam0/frame.png").string().c_str(),&w,&h,&n,1);
    require(restored && restored[29*80+37] == 255, "disabled segmentation was retained");
    stbi_image_free(restored);
    for (int degrees : {100, 160}) {
        require(gui::apply_arcturus_masks((temp.root/"images").string(),
                                          (temp.root/"masks").string(),cancel,false,degrees),
                "changing radial angle failed");
        const auto expected = gui::detail::arcturus_boundary_mask("opencv-fisheye", kb, 80, 64, degrees);
        auto *pixels = stbi_load((temp.root/"masks/cam0/frame.png").string().c_str(),&w,&h,&n,1);
        require(pixels && std::equal(expected.begin(), expected.end(), pixels),
                "new radial angle retained an old boundary");
        stbi_image_free(pixels);
    }
    manifest.cameras.erase(manifest.cameras.begin());
    std::ofstream(temp.root/"images/.arcturus-manifest.json") << sfm::manifest_write(manifest, true);
    fs::remove_all(temp.root/"images/cam0");
    require(gui::apply_arcturus_masks((temp.root/"images").string(),
                                      (temp.root/"mono-masks").string(),cancel), "single-eye mask failed");
    require(fs::exists(temp.root/"mono-masks/cam1/frame.png") &&
            !fs::exists(temp.root/"mono-masks/cam0"), "single-eye mask included wrong camera");
    cancel = true;
    rejected = false;
    try { gui::apply_arcturus_masks((temp.root/"images").string(),
                                   (temp.root/"masks").string(),cancel); }
    catch (...) { rejected = true; }
    require(rejected, "cancelled masking succeeded");
    std::cout << "Calibrated boundary, spline, intersection, resume and cancellation passed\n";
    return 0;
}

int stream_test() {
    std::atomic<bool> cancel{false};
    std::vector<double> times;
    app::FfmpegFrames frames;
    std::string error;
    if (!frames.open({"ffmpeg", "-nostdin", "-hide_banner", "-f", "lavfi", "-i",
                       "testsrc=size=16x16:rate=10:duration=1", "-vf",
                       "select='not(mod(n,2))',showinfo=checksum=0", "-fps_mode", "passthrough"},
                      app::FfmpegFrameFormat::Rgb8, error, [&](const std::string &line) {
                          auto at = line.find("pts_time:");
                          if (at != std::string::npos)
                              times.push_back(std::strtod(line.c_str() + at + 9, nullptr));
                      })) throw std::runtime_error(error);
    std::vector<uint8_t> pixels;
    int w = 0, h = 0, count = 0;
    while (frames.next(pixels, w, h, error)) {
        if (w != 16 || h != 16 || pixels.size() != 768)
            throw std::runtime_error("wrong streamed frame dimensions");
        ++count;
    }
    if (!error.empty() || count != 5 || times.size() != 5)
        throw std::runtime_error("missing streamed frames or timestamps: " + error);
    for (size_t i = 0; i < times.size(); ++i)
        if (std::abs(times[i] - i * .2) > 1e-6)
            throw std::runtime_error("streamed timestamps out of order");
    struct Script {
        std::filesystem::path path = std::filesystem::temp_directory_path() /
            ("spirula-filter-test-" + std::to_string(
                std::chrono::steady_clock::now().time_since_epoch().count()) + ".txt");
        ~Script() { std::error_code ec; std::filesystem::remove(path, ec); }
    } script;
    std::vector<double> selected;
    for (int i = 0; i < 500; ++i) selected.push_back(i + .1);
    const std::vector<double> clustered{0., 1., 2., 100., 101., 200.};
    if (gui::detail::arcturus_chunk_end(clustered, 0, false) != 3 ||
        gui::detail::arcturus_chunk_end(clustered, 1, false) != 3 ||
        gui::detail::arcturus_chunk_end(clustered, 3, false) != 5 ||
        gui::detail::arcturus_chunk_end(clustered, 5, false) != 6 ||
        gui::detail::arcturus_chunk_end(clustered, 6, false) != 6 ||
        gui::detail::arcturus_chunk_end(clustered, 0, true) != 6 ||
        gui::detail::arcturus_chunk_end({0., 6., 12.001}, 0, false) != 2 ||
        gui::detail::arcturus_chunk_end({}, 0, false) != 0)
        throw std::runtime_error("wrong sparse/dense selection chunks");
    bool legacy_filter_script = false;
    if (gui::run_process({"ffmpeg", "-hide_banner", "-h", "full"}, "",
                         [&](const std::string &line) {
                             if (line.find("-filter_script") != std::string::npos)
                                 legacy_filter_script = true;
                         }, cancel) != 0)
        throw std::runtime_error("could not probe FFmpeg filter-script support");
    for (bool keyframes : {false, true}) {
        for (const auto &range : std::vector<std::pair<size_t, size_t>>{
                 {3, selected.size()}, {3, 8}, {499, 500}, {500, 500}}) {
            const auto [first, last] = range;
            std::ofstream(script.path)
                << gui::detail::arcturus_frame_filter(selected, first, last, keyframes, .05);
            times.clear();
            if (!frames.open({"ffmpeg", "-nostdin", "-hide_banner", "-f", "lavfi", "-i",
                              "testsrc=size=16x16:rate=10:duration=500",
                              legacy_filter_script ? "-filter_script:v" : "-/filter:v",
                              script.path.string(), "-fps_mode", "passthrough"},
                             app::FfmpegFrameFormat::Rgb8, error, [&](const std::string &line) {
                                 auto at = line.find("pts_time:");
                                 if (at != std::string::npos)
                                     times.push_back(std::strtod(line.c_str() + at + 9, nullptr));
                             }))
                throw std::runtime_error(error);
            count = 0;
            while (frames.next(pixels, w, h, error))
                ++count;
            if (!error.empty() || count != int(last - first) || times.size() != last - first)
                throw std::runtime_error("long selection or restart lost frames: " + error);
            for (size_t i = 0; i < times.size(); ++i)
                if (std::abs(times[i] - selected[i + first]) > 1e-6)
                    throw std::runtime_error("long selection chose the wrong timestamp");
        }
    }
    const auto begin = std::chrono::steady_clock::now();
    CancelTimer timer(cancel, 300);
    if (!frames.open({"ffmpeg", "-nostdin", "-hide_banner", "-re", "-f", "lavfi", "-i",
                       "testsrc=size=16x16:rate=1:duration=60"}, app::FfmpegFrameFormat::Rgb8, error, {}, &cancel))
        throw std::runtime_error(error);
    while (frames.next(pixels, w, h, error)) {}
    if (!cancel || error.empty() || std::chrono::steady_clock::now() - begin > std::chrono::seconds(3))
        throw std::runtime_error("blocked decoder did not cancel promptly");
    std::cout << "Streaming, timestamps, bounded chunks, 500-frame selection/restart and "
                 "cancellation passed\n";
    return 0;
}
}

int main(int argc, char **argv) {
    try {
        const char *proxy = spirula::env("TEST_FFMPEG");
        if (proxy && argc > 1 && std::string(argv[1]) == "-nostdin")
            return ffmpeg_proxy(argc, argv, proxy);
        if (argc == 2 && std::string(argv[1]) == "--stream-test") return stream_test();
        if (argc == 2 && std::string(argv[1]) == "--mask-test") return mask_test();
        if (argc < 3) return 2;
        gui::PrepJob job;
        job.workspace = argv[2];
        job.ffmpeg_exe = "ffmpeg";
        job.max_frames = argc >= 4 ? std::stoi(argv[3]) : 3;
        job.arcturus_keyframes = false;
        int cancel_ms = 0;
        bool with_mask = false;
        for (int i = 4; i < argc; ++i) {
            const std::string flag = argv[i];
            if (flag == "--keyframes") job.arcturus_keyframes = true;
            else if (flag == "--eye" && i + 1 < argc) {
                const std::string eye = argv[++i];
                if (eye != "both" && eye != "left" && eye != "right")
                    throw std::runtime_error("eye must be both, left or right");
                job.arcturus_eye = eye == "right" ? 2 : eye == "left" ? 1 : 0;
            }
            else if (flag == "--with-mask") with_mask = true;
            else if (flag == "--fps" && i + 1 < argc) job.video_fps = std::stof(argv[++i]);
            else if (flag == "--ffmpeg" && i + 1 < argc) job.ffmpeg_exe = argv[++i];
            else if (flag == "--cancel-ms" && i + 1 < argc) cancel_ms = std::stoi(argv[++i]);
            else throw std::runtime_error("unknown test option: " + flag);
        }
        gui::PrepInput input;
        input.path = argv[1];
        input.is_video = true;
        job.inputs.push_back(input);
        gui::PrepResult result;
        std::atomic<bool> cancel{false};
        CancelTimer timer(cancel, cancel_ms);
        const auto images = (std::filesystem::path(job.workspace) / "images").string();
        if (!gui::extract_arcturus(
                job, job.inputs.front(), images, result, cancel,
                [](const std::string &s) { std::cout << s << std::endl; }, nullptr))
            return 3;
        if (with_mask && !gui::apply_arcturus_masks(
                images, (std::filesystem::path(job.workspace)/"masks").string(), cancel))
            return 4;
        std::cout << "Native import complete\n";
        return 0;
    } catch (const std::exception &e) {
        std::cerr << e.what() << '\n';
        return 1;
    }
}
