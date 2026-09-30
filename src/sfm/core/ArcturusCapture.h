#pragma once

#include "sfm/core/Manifest.h"
#include "sfm/core/Pose.h"
#include <array>
#include <functional>

namespace sfm {

struct ArcturusCamera {
    std::string model = "opencv-fisheye";
    int width = 0, height = 0;
    std::vector<double> params;
};
struct ArcturusFrame {
    double time = 0;
    std::array<Pose, 2> world_from_camera;
};
struct ArcturusCapture {
    std::array<ArcturusCamera, 2> cameras;
    std::vector<ArcturusFrame> frames;
};

// False means an ordinary video; malformed identified Arcturus metadata throws.
bool read_arcturus_capture(const std::string &path, ArcturusCapture &capture);
bool append_arcturus_packet(const std::vector<uint8_t> &bytes, ArcturusCapture &capture);
ArcturusFrame parse_arcturus_frame(const std::string &json);
std::vector<ArcturusFrame> select_arcturus_frames(const ArcturusCapture &capture, int count);
std::vector<ArcturusFrame>
select_arcturus_keyframes(const ArcturusCapture &capture,
                          const std::array<std::vector<double>, 2> &times, int max_count,
                          double pose_tolerance);
Pose arcturus_xr_starting_pose(const Pose &world_from_camera, double display_degrees);
void align_arcturus_dataset(const std::string &workspace, const std::string &images);
Manifest arcturus_manifest(const ArcturusCapture &capture, const std::string &prefix = "");

} // namespace sfm
