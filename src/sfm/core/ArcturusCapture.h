#pragma once

#include "sfm/core/Manifest.h"
#include "sfm/core/Pose.h"
#include <array>
#include <functional>
#include <map>

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
bool read_arcturus_capture(const std::string &path, ArcturusCapture &capture,
                           const std::function<void()> &checkpoint = {});
bool append_arcturus_packet(const std::vector<uint8_t> &bytes, ArcturusCapture &capture);
ArcturusFrame parse_arcturus_frame(const std::string &json);
std::vector<ArcturusFrame> select_arcturus_frames(const ArcturusCapture &capture, int count);
std::vector<ArcturusFrame>
select_arcturus_keyframes(const ArcturusCapture &capture,
                          const std::array<std::vector<double>, 2> &times, int max_count,
                          double pose_tolerance, double fps = 0);
Pose arcturus_xr_starting_pose(const Pose &world_from_camera, double display_degrees);
using ArcturusPoseMap = std::map<std::string, std::pair<Pose, double>>;
ArcturusPoseMap read_arcturus_poses(const std::string &images);
void align_arcturus_dataset(const std::string &workspace, const std::string &images);
Manifest arcturus_manifest(const ArcturusCapture &capture, const std::string &prefix = "", int eye = 0);

} // namespace sfm
