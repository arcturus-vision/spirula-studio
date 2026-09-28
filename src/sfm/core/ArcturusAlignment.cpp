#include "i18n/catalog/Arcturus.h"
#include "sfm/core/ArcturusCapture.h"
#include "sfm/core/Model.h"
#include "sfm/map/Merge.h"
#include <filesystem>
#include <fstream>
#include <iomanip>
#include <map>

namespace sfm {
namespace amsg = spirula::i18n::msg::arcturus;
namespace fs = std::filesystem;
Pose arcturus_xr_starting_pose(const Pose &world_from_camera, double display_degrees) {
    if (!std::isfinite(display_degrees) ||
        std::abs(display_degrees / 90. - std::round(display_degrees / 90.)) > 1e-5)
        throw std::runtime_error(amsg::err_unsupported_arcturus_display_rotation.get());
    const double angle = display_degrees * 3.141592653589793 / 180;
    const Mat3 display{
        std::cos(angle), -std::sin(angle), 0, std::sin(angle), std::cos(angle), 0, 0, 0, 1};
    const auto R = mul(world_from_camera.R, display);
    Vec3 forward{R[2], 0, R[8]}, down{0, 1, 0};
    if (forward.norm() < 1e-6)
        forward = Vec3{R[0], 0, R[6]}.cross(down);
    if (forward.norm() < 1e-6)
        throw std::runtime_error(amsg::err_cannot_determine_arcturus_xr_starting_heading.get());
    forward = forward.normalized();
    const auto right = down.cross(forward);
    return {{right.x, 0, forward.x, 0, 1, 0, right.z, 0, forward.z}, world_from_camera.t};
}

void align_arcturus_dataset(const std::string &workspace, const std::string &images) {
    std::map<std::string, std::pair<sfm::Pose, double>> targets;
    for (const auto &e : fs::recursive_directory_iterator(images)) {
        if (e.path().filename() != ".arcturus-poses.txt")
            continue;
        std::ifstream in(e.path());
        std::string line;
        std::getline(in, line);
        const auto prefix = fs::relative(e.path().parent_path(), images);
        std::string name;
        double rotation;
        sfm::Pose pose;
        while (in >> name >> rotation) {
            for (double &v : pose.R)
                in >> v;
            in >> pose.t.x >> pose.t.y >> pose.t.z;
            if (!in)
                throw std::runtime_error(amsg::err_incomplete_arcturus_pose_file.get());
            targets[(prefix == "." ? fs::path(name) : prefix / name).generic_string()] = {pose,
                                                                                          rotation};
        }
    }
    if (targets.empty())
        return;
    const auto completion = fs::path(workspace) / ".arcturus-aligned";
    fs::remove(completion);
    sfm::Reconstruction model;
    fs::path best;
    for (const auto &e : fs::directory_iterator(fs::path(workspace) / "sparse")) {
        if (!fs::exists(e.path() / "images.bin"))
            continue;
        auto m = sfm::Reconstruction::readBinary(e.path().string());
        if (m.numRegistered() > model.numRegistered()) {
            model = std::move(m);
            best = e.path();
        }
    }
    if (model.numRegistered() * 2 < targets.size() || model.points3D.empty())
        throw std::runtime_error(
            amsg::err_arcturus_reconstruction_registered_fewer_than_half_the.get());
    Manifest calibration;
    for (const auto &entry : fs::recursive_directory_iterator(images)) {
        if (entry.path().filename() == ".arcturus-manifest.json") {
            auto source = manifest_read(entry.path().string());
            calibration.cameras.insert(calibration.cameras.end(), source.cameras.begin(),
                                       source.cameras.end());
        }
    }
    if (!calibration.cameras.empty()) {
        for (const auto &[id, image] : model.images) {
            if (!image.registered)
                continue;
            for (const auto &expected : calibration.cameras) {
                if (image.name.rfind(expected.prefix + "/", 0) != 0)
                    continue;
                const auto &camera = model.cameras.at(image.camera_id);
                if (camera.model != sfm::CamModel::OpenCVFisheye || expected.params.size() != 8)
                    throw std::runtime_error(
                        amsg::err_arcturus_reconstruction_did_not_preserve_the_fisheye.get());
                double actual[8];
                sfm::packColmap(camera, actual);
                for (int k = 2; k < 8; ++k)
                    if (std::abs(actual[k] - expected.params[k]) > 1e-7)
                        throw std::runtime_error(
                            amsg::err_arcturus_reconstruction_changed_fixed_principal_point_or
                                .get());
            }
        }
    }
    std::vector<sfm::Vec3> src, dst;
    std::vector<sfm::Image *> registered;
    for (auto &[id, image] : model.images) {
        if (!image.registered)
            continue;
        if (!targets.count(image.name))
            throw std::runtime_error(spirula::i18n::format(amsg::unexpected_image, {image.name}));
        registered.push_back(&image);
    }
    std::sort(registered.begin(), registered.end(), [](const auto *a, const auto *b) {
        auto af = fs::path(a->name).filename(), bf = fs::path(b->name).filename();
        return af == bf ? a->name < b->name : af < bf;
    });
    for (const auto *image : registered) {
        src.push_back(sfm::cameraCenter(image->pose));
        dst.push_back(targets.at(image->name).first.t);
    }
    auto noncollinear = [](const std::vector<sfm::Vec3> &points) {
        if (points.size() < 3)
            return false;
        sfm::Vec3 axis;
        for (const auto &p : points)
            if ((p - points.front()).norm() > axis.norm())
                axis = p - points.front();
        if (axis.norm() < 1e-8)
            return false;
        axis = axis.normalized();
        for (const auto &p : points)
            if (axis.cross(p - points.front()).norm() > 1e-8)
                return true;
        return false;
    };
    if (!noncollinear(src) || !noncollinear(dst))
        throw std::runtime_error(
            amsg::err_arcturus_tracking_alignment_requires_noncollinear_camera_positions.get());
    sfm::Sim3 transform;
    if (!sfm::estimateSim3(src, dst, transform))
        throw std::runtime_error(amsg::err_arcturus_tracking_alignment_is_degenerate.get());
    const auto &anchor = targets.at(registered.front()->name).first;
    transform.R = sfm::mul(anchor.R, registered.front()->pose.R);
    transform.t = anchor.t - sfm::mul(transform.R, src.front()) * transform.scale;
    double squared = 0;
    std::vector<double> errors;
    for (size_t i = 0; i < src.size(); ++i) {
        auto d = sfm::transformPoint(transform, src[i]) - dst[i];
        squared += d.dot(d);
        errors.push_back(d.norm());
    }
    for (auto &[id, image] : model.images)
        if (image.registered)
            image.pose = sfm::transformPose(transform, image.pose);
    for (auto &[id, point] : model.points3D)
        point.xyz = sfm::transformPoint(transform, point.xyz);
    const fs::path raw = fs::path(workspace) / ".arcturus-raw-sparse";
    fs::create_directories(raw);
    for (const char *name : {"cameras.bin", "images.bin", "points3D.bin"})
        fs::copy_file(best / name, raw / name, fs::copy_options::overwrite_existing);
    const fs::path output = fs::path(workspace) / "sparse" / "0";
    fs::create_directories(output);
    model.writeBinary(output.string());
    std::ofstream(output / "gauge.txt") << "oriented 1\nmetric 1\n";
    std::sort(errors.begin(), errors.end());
    std::ofstream report(fs::path(workspace) / "alignment.json");
    report << std::setprecision(17) << "{\"scale\":" << transform.scale << ",\"rotation\":[";
    for (int row = 0; row < 3; ++row) {
        if (row)
            report << ',';
        report << '[' << transform.R[row * 3] << ',' << transform.R[row * 3 + 1] << ','
               << transform.R[row * 3 + 2] << ']';
    }
    report << "],\"translation\":[" << transform.t.x << ',' << transform.t.y << ',' << transform.t.z
           << "],\"rmsError\":" << std::sqrt(squared / src.size())
           << ",\"correspondenceCount\":" << src.size() << ",\"medianError\":"
           << (errors[(errors.size() - 1) / 2] + errors[errors.size() / 2]) * .5
           << ",\"orientationAnchor\":\"" << registered.front()->name << "\"}\n";
    std::array<std::vector<double>, 3> coordinates;
    for (auto *image : registered) {
        auto p = sfm::cameraCenter(image->pose);
        coordinates[0].push_back(p.x);
        coordinates[1].push_back(p.y);
        coordinates[2].push_back(p.z);
    }
    sfm::Vec3 median;
    double *axes[] = {&median.x, &median.y, &median.z};
    for (int a = 0; a < 3; ++a) {
        auto &v = coordinates[a];
        std::sort(v.begin(), v.end());
        *axes[a] = (v[(v.size() - 1) / 2] + v[v.size() / 2]) * .5;
    }
    auto *start = *std::min_element(registered.begin(), registered.end(), [&](auto *a, auto *b) {
        double da = (sfm::cameraCenter(a->pose) - median).norm(),
               db = (sfm::cameraCenter(b->pose) - median).norm();
        return da == db ? a->name < b->name : da < db;
    });
    auto initial =
        arcturus_xr_starting_pose({sfm::transpose(start->pose.R), sfm::cameraCenter(start->pose)},
                                  targets.at(start->name).second);
    sfm::Vec3 right{initial.R[0], initial.R[3], initial.R[6]};
    sfm::Vec3 forward{initial.R[2], initial.R[5], initial.R[8]};
    auto position = initial.t;
    std::ofstream sidecar(fs::path(workspace) / "scene.xrSceneTransform.json");
    sidecar << std::setprecision(17) << "{\"transform\":[[" << right.x << ",0," << forward.x << ','
            << position.x << "],[0,1,0," << position.y << "],[" << right.z << ",0," << forward.z
            << ',' << position.z << "],[0,0,0,1]],\"worldScale\":1,\"worldScaleOffset\":[0,0,0]}\n";
    report.close();
    sidecar.close();
    if (!report || !sidecar)
        throw std::runtime_error(amsg::err_cannot_write_arcturus_alignment_or_xr_starting.get());
    std::ofstream complete(completion);
    complete << "AV1-native-v2\n";
    complete.close();
    if (!complete)
        throw std::runtime_error(amsg::err_cannot_write_arcturus_completion_marker.get());
}
} // namespace sfm
