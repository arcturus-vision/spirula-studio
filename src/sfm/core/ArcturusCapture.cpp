#include "sfm/core/ArcturusCapture.h"
#include "data/Json.h"
#include "i18n/catalog/Arcturus.h"
#include "sfm/core/Telemetry.h"
#include <algorithm>
#include <cmath>
#include <stdexcept>

namespace sfm {
namespace amsg = spirula::i18n::msg::arcturus;
namespace {
const JsonValue &field(const JsonValue &value, const char *name) {
    const auto *p = value.find(name);
    if (!p)
        throw std::runtime_error(spirula::i18n::format(amsg::missing_metadata, {name}));
    return *p;
}
double number(const JsonValue &value) {
    if (value.type != JsonValue::Type::Number || !std::isfinite(value.num))
        throw std::runtime_error(amsg::err_arcturus_metadata_contains_an_invalid_number.get());
    return value.num;
}
Vec3 vector(const JsonValue &value) {
    if (!value.is_array() || value.arr.size() != 3)
        throw std::runtime_error(amsg::err_arcturus_metadata_has_an_invalid_pose_vector.get());
    return {number(value.arr[0]), number(value.arr[1]), number(value.arr[2])};
}
Pose pose(const JsonValue &value) {
    if (value.is_array()) {
        std::vector<double> a;
        for (const auto &row : value.arr) {
            if (row.is_array())
                for (const auto &v : row.arr)
                    a.push_back(number(v));
            else
                a.push_back(number(row));
        }
        if (a.size() != 16 ||
            std::abs(a[12]) + std::abs(a[13]) + std::abs(a[14]) + std::abs(a[15] - 1) > 1e-6)
            throw std::runtime_error(amsg::err_arcturus_metadata_has_an_invalid_pose_matrix.get());
        return {{a[0], a[1], a[2], a[4], a[5], a[6], a[8], a[9], a[10]}, {a[3], a[7], a[11]}};
    }
    Vec3 x = vector(field(value, value.has("plus_x") ? "plus_x" : "plusX"));
    Vec3 z = vector(field(value, value.has("plus_z") ? "plus_z" : "plusZ"));
    if (x.norm() < 1e-8)
        throw std::runtime_error(amsg::err_arcturus_pose_has_a_zero_axis.get());
    x = x * (1.0 / x.norm());
    z = z - x * x.dot(z);
    if (z.norm() < 1e-8)
        throw std::runtime_error(amsg::err_arcturus_pose_axes_are_parallel.get());
    z = z * (1.0 / z.norm());
    const Vec3 y = z.cross(x);
    return {{x.x, y.x, z.x, x.y, y.y, z.y, x.z, y.z, z.z}, vector(field(value, "position"))};
}
ArcturusFrame frame(const JsonValue &raw) {
    ArcturusFrame f;
    f.time = number(field(raw, raw.has("playbackTimestampSec") ? "playbackTimestampSec" : "pts"));
    const auto &ex = field(raw, "extrinsics");
    const Pose world_conversion{{1, 0, 0, 0, -1, 0, 0, 0, -1}, {0, 0, 0}};
    f.world_from_camera[0] = composePose(world_conversion, pose(field(ex, "avcam0InWorld")));
    f.world_from_camera[1] = composePose(f.world_from_camera[0], pose(field(ex, "avcam1InAvcam0")));
    return f;
}
void calibration(const JsonValue &raw, ArcturusCapture &capture) {
    auto cameras = field(raw, "cameras").arr;
    if (cameras.size() != 2)
        throw std::runtime_error(amsg::err_arcturus_capture_requires_two_calibrated_cameras.get());
    std::sort(cameras.begin(), cameras.end(), [](const auto &a, const auto &b) {
        return a.get_double("track", 0) < b.get_double("track", 0);
    });
    for (size_t i = 0; i < 2; ++i) {
        const auto &camera = cameras[i];
        const auto &intr = camera.has("intrinsics") ? field(camera, "intrinsics") : camera;
        const auto candidates = intr.is_array() ? intr.arr : std::vector<JsonValue>{intr};
        bool found = false;
        for (const auto &c : candidates) {
            const std::string model =
                c.has("cameraModel") ? field(c, "cameraModel").as_string() : "";
            if (model != "kb" && model != "kb4")
                continue;
            auto &dst = capture.cameras[i];
            dst.width = (int)number(field(c, c.has("width") ? "width" : "w"));
            dst.height = (int)number(field(c, c.has("height") ? "height" : "h"));
            for (const char *key : {"fx", "fy", "cx", "cy", "k1", "k2", "k3", "k4"})
                dst.params.push_back(number(field(c, key)));
            if (dst.width <= 0 || dst.height <= 0 || dst.params[0] <= 0 || dst.params[1] <= 0)
                throw std::runtime_error(
                    amsg::err_arcturus_camera_calibration_has_invalid_dimensions_or.get());
            found = true;
            break;
        }
        if (!found)
            throw std::runtime_error(amsg::err_arcturus_camera_has_no_public_kb4_calibration.get());
    }
}
} // namespace
ArcturusFrame parse_arcturus_frame(const std::string &json) { return frame(json_parse(json)); }

bool append_arcturus_packet(const std::vector<uint8_t> &bytes, ArcturusCapture &capture) {
    bool identified = false;
    std::string format, payload;
    for (size_t off = 0; off + 8 <= bytes.size();) {
        const size_t n = (size_t)bytes[off + 5] * ((bytes[off + 6] << 8) | bytes[off + 7]);
        const std::string key((const char *)bytes.data() + off, 4);
        if (key == "AVmf" || key == "AVmd")
            identified = true;
        if (n > bytes.size() - off - 8) {
            if (identified)
                throw std::runtime_error(amsg::err_truncated_arcturus_metadata_packet.get());
            return false;
        }
        if (key == "AVmf" || key == "AVmd") {
            identified = true;
            std::string s((const char *)bytes.data() + off + 8, n);
            while (!s.empty() && s.back() == 0)
                s.pop_back();
            (key == "AVmf" ? format : payload) = std::move(s);
        }
        off += 8 + ((n + 3) & ~size_t(3));
    }
    if (!identified)
        return false;
    if (format != "json/v1" || payload.empty())
        throw std::runtime_error(
            amsg::err_unsupported_or_incomplete_arcturus_metadata_envelope.get());
    auto raw = json_parse(payload);
    if (capture.frames.empty())
        calibration(raw, capture);
    capture.frames.push_back(frame(raw));
    return true;
}

bool read_arcturus_capture(const std::string &path, ArcturusCapture &capture) {
    capture = {};
    bool identified = false;
    std::string error;
    const bool ok = video_metadata_packets(
        path, "gpmd",
        [&](const std::vector<uint8_t> &bytes) {
            const bool recognized = append_arcturus_packet(bytes, capture);
            if (identified && !recognized)
                throw std::runtime_error(amsg::err_missing_arcturus_metadata_envelope.get());
            identified = identified || recognized;
            return recognized;
        },
        error);
    if (!ok && identified)
        throw std::runtime_error(error);
    if (!identified)
        return false;
    std::sort(capture.frames.begin(), capture.frames.end(),
              [](const auto &a, const auto &b) { return a.time < b.time; });
    if (capture.frames.size() < 3 || capture.frames.back().time <= capture.frames.front().time)
        throw std::runtime_error(amsg::err_arcturus_capture_has_insufficient_tracked_frames.get());
    return true;
}
std::vector<ArcturusFrame> select_arcturus_frames(const ArcturusCapture &capture, int count) {
    const auto &frames = capture.frames;
    if (count < 3 || count > (int)frames.size())
        throw std::runtime_error(amsg::err_invalid_arcturus_frame_count.get());
    std::vector<ArcturusFrame> selected;
    for (int i = 0; i < count; ++i) {
        double t =
            frames.front().time + (frames.back().time - frames.front().time) * i / (count - 1);
        auto it = std::lower_bound(frames.begin(), frames.end(), t,
                                   [](const auto &f, double v) { return f.time < v; });
        if (it == frames.end())
            --it;
        if (it != frames.begin() && t - (it - 1)->time <= it->time - t)
            --it;
        if (!selected.empty() && it->time <= selected.back().time)
            throw std::runtime_error(
                amsg::err_arcturus_sampling_selected_duplicate_timestamps.get());
        selected.push_back(*it);
    }
    return selected;
}
Manifest arcturus_manifest(const ArcturusCapture &capture, const std::string &prefix) {
    Manifest m;
    m.camera_mode = "folder";
    for (int i = 0; i < 2; ++i) {
        ManifestCamera c;
        c.prefix = prefix + (prefix.empty() ? "" : "/") + "cam" + std::to_string(i);
        c.model = "opencv-fisheye";
        c.params = capture.cameras[i].params;
        m.cameras.push_back(c);
    }
    return m;
}
} // namespace sfm
