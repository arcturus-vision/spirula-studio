#pragma once
#include "sfm/core/Camera.h"
#include "i18n/catalog/Arcturus.h"

namespace gui::detail {
inline std::vector<unsigned char> arcturus_boundary_mask(
    const std::string &model, const std::vector<double> &params, int width, int height, int degrees = 130) {
    sfm::Camera camera;
    if (model == "opencv-fisheye" && params.size() == 8)
        camera.model = sfm::CamModel::OpenCVFisheye;
    else if (model == "kb-polar-spline" && params.size() == 61)
        camera.model = sfm::CamModel::KBPolarSpline;
    else
        throw std::runtime_error(spirula::i18n::msg::arcturus::mask_failed.get());
    if (width <= 0 || height <= 0 || params[0] <= 0 || params[1] <= 0)
        throw std::runtime_error(spirula::i18n::msg::arcturus::mask_failed.get());
    for (double value : params)
        if (!std::isfinite(value))
            throw std::runtime_error(spirula::i18n::msg::arcturus::mask_failed.get());
    if (model == "kb-polar-spline" && (params[8] <= 0 || params[9] <= 0 || params[10] <= 0))
        throw std::runtime_error(spirula::i18n::msg::arcturus::mask_failed.get());
    sfm::unpackColmap(camera, params.data());
    if (degrees < 1 || degrees > 360)
        throw std::runtime_error(spirula::i18n::msg::arcturus::mask_failed.get());
    const double limit = std::cos(degrees * std::acos(-1.0) / 360.0);
    std::vector<unsigned char> mask(size_t(width) * height);
    for (int y = 0; y < height; ++y)
        for (int x = 0; x < width; ++x) {
            const sfm::Vec2 pixel{x + .5, y + .5};
            const auto ray = camera.bearing(pixel);
            const auto projected = camera.project(ray);
            const double error = std::hypot(projected.x - pixel.x, projected.y - pixel.y);
            mask[size_t(y) * width + x] =
                std::isfinite(ray.z) && ray.z >= limit && error < .05 ? 255 : 0;
        }
    return mask;
}
}
