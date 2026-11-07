#include "app/gui/NavCamera.h"
#include "app/gui/SfmProgress.h"
#include "data/DatasetParser.h"

#include <algorithm>
#include <chrono>
#include <cmath>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <stdexcept>

namespace fs = std::filesystem;

namespace {
void require(bool ok, const char *message) {
    if (!ok) throw std::runtime_error(message);
}

void direction(const float *actual, const std::array<float, 3> &expected) {
    for (int k = 0; k < 3; ++k)
        require(std::abs(actual[k] - expected[k]) < 1e-5f, "wrong navigation direction");
}

void yaw(const std::array<float, 3> &up) {
    gui::NavCamera camera;
    const float eye[3] = {0, 0, 3}, target[3] = {0, 0, 0};
    camera.look_at(eye, target, up.data());
    std::copy(up.begin(), up.end(), camera.world_up);
    camera.orbit(100, 0);
    float actual[3];
    camera.axis_up(actual);
    direction(actual, up);
    require(std::abs(camera.pos[0]) > 1, "horizontal drag failed to yaw");
    require(std::abs(camera.pos[1]) < 1e-5f, "horizontal drag changed camera height");
    camera.look(80, 0);
    camera.axis_up(actual);
    direction(actual, up);
    camera.mode = gui::NavCamera::Fps;
    camera.look(80, 0);
    camera.axis_up(actual);
    direction(actual, up);
}
}

int main() {
    const auto root = fs::temp_directory_path() /
        ("spirula-navigation-test-" + std::to_string(
            std::chrono::steady_clock::now().time_since_epoch().count()));
    try {
        const auto model = root / "sparse/0";
        fs::create_directories(model);
        ParsedDataset ds;
        std::ofstream(model / "gauge.txt") << "oriented 1\nmetric 1\n";
        dsparse::read_gauge(model.string(), ds);
        require(ds.navigation_up.has_value(), "standard measured up missing");
        direction(ds.navigation_up->data(), {0, 0, 1});
        std::ofstream(root / ".arcturus-aligned") << "AV1-native-v2\n";
        dsparse::read_gauge(model.string(), ds);
        direction(ds.navigation_up->data(), {0, -1, 0});
        yaw(dsparse::normalized_up(ds));

        std::ofstream(model / "gauge.txt") << "oriented 1\nmetric 1\nup_axis 0 -2 0\n";
        dsparse::read_gauge(model.string(), ds);
        direction(ds.navigation_up->data(), {0, -1, 0});
        ds.train_to_normalized = {2,0,0,10, 0,0,-2,20, 0,2,0,30, 0,0,0,1};
        const auto up = dsparse::normalized_up(ds);
        direction(up.data(), {0, 0, 1});
        std::ofstream(model / "gauge.txt") << "oriented 1\nup_axis 1 0 0\n";
        dsparse::read_gauge(model.string(), ds);
        direction(ds.navigation_up->data(), {1, 0, 0});

        gui::LiveModel live;
        live.ds.num_cameras = 1;
        live.ds.c2w = {0,1,0,0, 1,0,0,0, 0,0,-1,3};
        const auto unchanged = live.ds.c2w;
        float sensor_up[3], display_up[3];
        require(gui::snapshot_up(live, sensor_up) &&
                gui::snapshot_up(live, display_up, {-90}), "live camera up unavailable");
        direction(sensor_up, {1, 0, 0});
        direction(display_up, {0, -1, 0});
        require(live.ds.c2w == unchanged, "navigation changed calibrated poses");
        yaw({display_up[0], display_up[1], display_up[2]});
        live.ds.num_cameras = 2;
        live.ds.c2w.insert(live.ds.c2w.end(), {0,-1,0,1, -1,0,0,0, 0,0,-1,3});
        require(gui::snapshot_up(live, display_up, {-90, 90}), "stereo display up unavailable");
        direction(display_up, {0, -1, 0});
        yaw({display_up[0], display_up[1], display_up[2]});

        fs::remove_all(root);
        std::cout << "Navigation axes, legacy Arcturus metadata, normalization and yaw passed\n";
        return 0;
    } catch (const std::exception &e) {
        fs::remove_all(root);
        std::cerr << e.what() << '\n';
        return 1;
    }
}
