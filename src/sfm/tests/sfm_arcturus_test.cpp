#include "data/Json.h"
#include "sfm/core/ArcturusCapture.h"
#include "sfm/core/Model.h"
#include "sfm/core/Telemetry.h"
#include <chrono>
#include <cmath>
#include <filesystem>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <stdexcept>

void require(bool ok, const char *why) {
    if (!ok)
        throw std::runtime_error(why);
}
std::vector<uint8_t> packet(const std::string &format, const std::string &payload) {
    std::vector<uint8_t> out;
    auto add = [&](const std::string &key, const std::string &value) {
        out.insert(out.end(), key.begin(), key.end());
        out.insert(out.end(), {'c', 1, (uint8_t)(value.size() >> 8), (uint8_t)value.size()});
        out.insert(out.end(), value.begin(), value.end());
        while (out.size() % 4)
            out.push_back(0);
    };
    add("AVmf", format);
    add("AVmd", payload);
    return out;
}
void alignment_test() {
    namespace fs = std::filesystem;
    const auto root = fs::temp_directory_path() /
                      ("spirula-arcturus-test-" +
                       std::to_string(std::chrono::steady_clock::now().time_since_epoch().count()));
    fs::create_directories(root / "images");
    fs::create_directories(root / "sparse/0");
    sfm::Reconstruction m;
    sfm::Camera c;
    c.id = 1;
    c.width = 100;
    c.height = 100;
    c.model = sfm::CamModel::OpenCVFisheye;
    c.fx = 60;
    c.fy = 61;
    c.cx = 48;
    c.cy = 49;
    m.cameras[1] = c;
    sfm::Sim3 truth{2.5, sfm::angleAxisToRotation({.2, .3, -.4}), {4, -2, 8}};
    const sfm::Vec3 centers[] = {{0, 0, 0}, {1, 0, 0}, {0, 0, 1}, {1, .2, 1}};
    std::ofstream poses(root / "images/.arcturus-poses.txt");
    poses << "fixture\n" << std::setprecision(17);
    for (uint32_t i = 0; i < 4; ++i) {
        sfm::Image image;
        image.id = i + 1;
        image.camera_id = 1;
        image.registered = true;
        image.name = "cam0/" + std::to_string(i) + ".jpg";
        image.pose = {sfm::mat3Identity(), centers[i] * -1};
        m.images[image.id] = image;
        auto target = sfm::transformPoint(truth, centers[i]);
        poses << image.name << " -90";
        for (double v : truth.R)
            poses << ' ' << v;
        poses << ' ' << target.x << ' ' << target.y << ' ' << target.z << '\n';
    }
    poses.close();
    sfm::Point3D point;
    point.xyz = {.5, 1, 2};
    m.points3D[1] = point;
    m.writeBinary((root / "sparse/0").string());
    sfm::align_arcturus_dataset(root.string(), (root / "images").string());
    auto aligned = sfm::Reconstruction::readBinary((root / "sparse/0").string());
    require((aligned.points3D.at(1).xyz - sfm::transformPoint(truth, point.xyz)).norm() < 1e-7,
            "metric points");
    for (uint32_t i = 0; i < 4; ++i)
        require((sfm::cameraCenter(aligned.images.at(i + 1).pose) -
                 sfm::transformPoint(truth, centers[i]))
                        .norm() < 1e-7,
                "metric cameras");
    auto json = json_parse_file((root / "scene.xrSceneTransform.json").string());
    const auto &matrix = json.find("transform")->arr;
    require(matrix[1].arr[0].num == 0 && matrix[1].arr[1].num == 1 && matrix[1].arr[2].num == 0,
            "level XR pose");
    require(fs::exists(root / ".arcturus-raw-sparse/images.bin"), "raw reconstruction retained");
    require(fs::exists(root / ".arcturus-aligned"), "successful alignment marked");
    m.points3D.clear();
    m.writeBinary((root / "sparse/0").string());
    bool rejected = false;
    try {
        sfm::align_arcturus_dataset(root.string(), (root / "images").string());
    } catch (const std::exception &) {
        rejected = true;
    }
    require(rejected && !fs::exists(root / ".arcturus-aligned"),
            "failed retry invalidates prior completion");
    fs::remove_all(root);
}
int main(int argc, char **argv) {
    try {
        if (argc == 4 && std::string(argv[1]) == "--align") {
            sfm::align_arcturus_dataset(argv[2], argv[3]);
            std::cout << "Native Arcturus alignment complete\n";
            return 0;
        }
        const std::string pose = R"({"plusX":[1,0,0],"plusZ":[0,0,1],"position":[1,2,3]})";
        const std::string stereo = R"({"plus_x":[1,0,0],"plus_z":[0,0,1],"position":[0.06,0,0]})";
        auto f =
            sfm::parse_arcturus_frame("{\"pts\":0.5,\"extrinsics\":{\"avcam0InWorld\":" + pose +
                                      ",\"avcam1InAvcam0\":" + stereo + "}}");
        require(f.time == .5, "legacy timestamp");
        require((f.world_from_camera[0].t - sfm::Vec3{1, -2, -3}).norm() < 1e-10, "world axes");
        require((f.world_from_camera[1].t - sfm::Vec3{1.06, -2, -3}).norm() < 1e-10,
                "stereo baseline");
        require(f.world_from_camera[0].R[4] == -1 && f.world_from_camera[0].R[8] == -1,
                "orientation");
        bool rejected = false;
        try {
            sfm::parse_arcturus_frame(R"({"pts":null})");
        } catch (...) {
            rejected = true;
        }
        require(rejected, "missing metadata rejection");
        sfm::ArcturusCapture synthetic;
        for (int i = 0; i < 10; ++i) {
            f.time = i * .1;
            synthetic.frames.push_back(f);
        }
        auto picked = sfm::select_arcturus_frames(synthetic, 3);
        require(picked.size() == 3 && picked.front().time == 0 && picked.back().time == .9,
                "full duration sampling");
        rejected = false;
        try {
            sfm::select_arcturus_frames(synthetic, 11);
        } catch (...) {
            rejected = true;
        }
        require(rejected, "oversampling rejection");
        for (double pitch : {0., .4, 1.5707963267948966, -1.5707963267948966}) {
            for (double display : {0., 90., 180., -90.}) {
                sfm::Pose camera{sfm::angleAxisToRotation({pitch, 0, 0}), {1, 2, 3}};
                auto initial = sfm::arcturus_xr_starting_pose(camera, display);
                require((initial.t - camera.t).norm() < 1e-10, "starting position");
                require(initial.R[3] == 0 && initial.R[4] == 1 && initial.R[5] == 0,
                        "level starting rotation");
                require(std::abs(sfm::det3(initial.R) - 1) < 1e-10, "proper starting rotation");
            }
        }
        rejected = false;
        try {
            sfm::arcturus_xr_starting_pose({sfm::mat3Identity(), {}}, 45);
        } catch (...) {
            rejected = true;
        }
        require(rejected, "non-quarter display rotation rejection");
        const std::string intrinsics =
            R"({"cameraModel":"kb4","width":2464,"height":2464,"fx":1482,"fy":1485,"cx":1389,"cy":1221,"k1":-0.04,"k2":-0.1,"k3":0.02,"k4":0.01})";
        const std::string raw = "{\"pts\":0,\"cameras\":[{\"track\":0,\"intrinsics\":[" +
                                intrinsics + "]},{\"track\":1,\"intrinsics\":[" + intrinsics +
                                "]}],\"extrinsics\":{\"avcam0InWorld\":" + pose +
                                ",\"avcam1InAvcam0\":" + stereo + "}}";
        sfm::ArcturusCapture parsed;
        require(sfm::append_arcturus_packet(packet("json/v1", raw), parsed), "GPMF envelope");
        require(parsed.frames.size() == 1 && parsed.cameras[0].params.size() == 8,
                "complete metadata");
        require(parsed.cameras[0].params[0] == 1482 && parsed.cameras[0].params[1] == 1485 &&
                    parsed.cameras[0].params[2] == 1389 && parsed.cameras[0].params[7] == .01,
                "asymmetric KB4 calibration");
        rejected = false;
        try {
            sfm::append_arcturus_packet(packet("json/v2", raw), parsed);
        } catch (...) {
            rejected = true;
        }
        require(rejected, "unsupported metadata version");
        auto truncated = packet("json/v1", raw);
        truncated.resize(truncated.size() - 8);
        rejected = false;
        try {
            sfm::append_arcturus_packet(truncated, parsed);
        } catch (...) {
            rejected = true;
        }
        require(rejected, "truncated metadata rejection");
        alignment_test();
        std::cout << "Arcturus metadata and alignment unit checks passed\n";
        if (argc == 2) {
            sfm::ArcturusCapture c;
            require(sfm::read_arcturus_capture(argv[1], c), "not an Arcturus recording");
            auto frames = sfm::select_arcturus_frames(c, std::min(100, (int)c.frames.size()));
            std::cout << "metadata=" << c.frames.size() << " selected=" << frames.size()
                      << " span=" << frames.front().time << ":" << frames.back().time << '\n';
            for (double r : sfm::video_display_rotations(argv[1]))
                std::cout << "rotation=" << r << '\n';
            std::cout << sfm::manifest_write(sfm::arcturus_manifest(c), true) << '\n';
        }
        return 0;
    } catch (const std::exception &e) {
        std::cerr << e.what() << '\n';
        return 1;
    }
}
