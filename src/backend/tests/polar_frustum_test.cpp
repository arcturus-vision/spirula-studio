// Host-only regression for polar frustums whose inverse lens solve diverges.

#include "core/CameraModel.h"
#include "data/FrustumTemplate.h"
#include "data/PolarSpline.h"

#include <cmath>
#include <cstdio>
#include <limits>
#include <stdexcept>

namespace {
void require(bool ok, const char *why) {
    if (!ok)
        throw std::runtime_error(why);
}

void clamped_spline() {
    double coeff[50], out[2];
    for (int i = 0; i < 25; ++i) {
        coeff[i] = 2;
        coeff[25 + i] = .5;
    }
    for (double radius : {7., 1e3, 1e14, 1e100}) {
        polar_spline::shift(radius, 0., coeff, out);
        require(std::abs(out[0] - 2) < 1e-12 && std::abs(out[1] - .5) < 1e-12,
                "spline radius must clamp without integer overflow");
        polar_spline::shift(0., -radius, coeff, out);
        require(std::abs(out[0] - .5) < 1e-12 && std::abs(out[1] + 2) < 1e-12,
                "clamping must preserve radial and tangential directions");
    }
    for (double x :
         {std::numeric_limits<double>::infinity(), std::numeric_limits<double>::quiet_NaN(),
          std::numeric_limits<double>::max()}) {
        polar_spline::shift(x, 1., coeff, out);
        require(!std::isfinite(out[0]) && !std::isfinite(out[1]),
                "nonfinite spline coordinates must stay invalid");
    }
}

void divergent_frustum() {
    float d[kCameraDistortionParams] = {-.04f,          -.16f,          .11f,         -.023f,
                                        1480.f / 249.f, 1484.f / 249.f, 1.f / 1480.f, 1.f / 1484.f};
    for (int k = 0; k < 50; ++k)
        d[8 + k] = .2f * ((k * 7) % 13 - 6);
    auto shape = camhost::frustum_template(1, 3, 2464, 2464, 1480, 1484, 1390, 1222, d);
    require(shape.lines.size() == 7 && shape.anchors.size() == 4,
            "polar frustum must retain its border and grid");
    for (const auto &line : shape.lines)
        for (const auto &p : line.pts)
            require(std::isfinite(p.x) && std::isfinite(p.y) && std::isfinite(p.z),
                    "divergent border rays must fall back to finite frustum points");
    double ray[3];
    require(!camhost::generate_ray(1e100, 1e100, 1, 3, d, ray),
            "divergent inverse distortion must reject invalid rays");
    require(camhost::generate_ray(.2, -.1, 1, 3, d, ray), "interior ray must remain valid");
    double projected[2];
    require(camhost::project_ray(ray, 1, 3, d, projected), "interior ray must project");
    require(std::hypot(projected[0] - .2, projected[1] + .1) < 1e-6,
            "interior ray must preserve the calibrated projection");
}
} // namespace

int main() {
    try {
        clamped_spline();
        divergent_frustum();
        std::puts("polar_frustum_test: all checks passed");
        return 0;
    } catch (const std::exception &e) {
        std::fprintf(stderr, "polar_frustum_test: %s\n", e.what());
        return 1;
    }
}
