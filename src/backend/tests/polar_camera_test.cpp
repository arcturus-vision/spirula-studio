#include "backend/tests/DistortionFixture.h"
#include "backend/tests/ScreenRows.h"
#include "data/CameraMath.h"
#include "kernels/projection/ProjectionFwd.cuh"
#include <cmath>
#include <cstdio>
#include <stdexcept>

namespace {
TorchTensorView view(const void *p, std::vector<int64_t> shape) {
    return {(uint64_t)p, 4, std::move(shape)};
}
float *upload(const std::vector<float> &v) {
    auto *p = (float *)backend::device_malloc(v.size() * sizeof(float));
    backend::memcpy_sync(p, v.data(), v.size() * sizeof(float), backend::MemcpyKind::HostToDevice);
    return p;
}
} // namespace
int main() {
    const int n = 35, cameras = 2;
    std::vector<float> means, quats(n * 4, 0), scales(n * 3, std::log(.01f)), opacity(n, 3),
        colors(n * 3, .5f), sh(n * 45, 0);
    for (int i = 0; i < n; ++i) {
        means.insert(means.end(), {float(i % 7 - 3) * .3f, float(i / 7 - 2) * .3f, 1.f});
        quats[i * 4] = 1;
    }
    std::vector<float> vm = {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1};
    auto second = vm;
    vm.insert(vm.end(), second.begin(), second.end());
    std::vector<float> intr = {1480, 1484, 1232, 1232, 1470, 1490, 1220, 1240};
    auto all = dist_fixture::distortion_rows(cameras);
    std::vector<float> dist(all.begin() + dist_fixture::row_offset(3, cameras), all.end());
    std::vector<float *> owned;
    auto put = [&](const std::vector<float> &v) {
        auto *p = upload(v);
        owned.push_back(p);
        return p;
    };
    std::vector<DeviceTensorFloatND> splats = {DeviceTensorFloatND(view(put(means), {n, 3, 1})),
                                               DeviceTensorFloatND(view(put(quats), {n, 4, 1})),
                                               DeviceTensorFloatND(view(put(scales), {n, 3, 1})),
                                               DeviceTensorFloatND(view(put(opacity), {n, 1, 1})),
                                               DeviceTensorFloatND(view(put(colors), {n, 3, 1})),
                                               DeviceTensorFloatND(view(put(sh), {n, 45, 1}))};
    auto result = projection_3dgs_forward(
        n, 0, splats, view(put(vm), {cameras, 16}), view(put(intr), {cameras, 4}), 2464, 2464,
        "FISHEYE", "KB_POLAR_SPLINE", view(put(dist), {cameras, kCameraDistortionParams}),
        DeviceVector<float>(view(put(std::vector<float>(n, 0)), {n, 1})), std::nullopt,
        std::nullopt, 0, 32, 0);
    backend::device_synchronize();
    auto &screen = std::get<2>(result)[0];
    std::vector<float> rows(screen.numel());
    backend::memcpy_sync(rows.data(), screen.data_ptr(), rows.size() * sizeof(float),
                         backend::MemcpyKind::DeviceToHost);
    double max_pixel_error = 0, max_conic_error = 0;
    for (int c = 0; c < cameras; ++c)
        for (int i = 0; i < n; ++i) {
            auto project = [&](const double ray[3], double out[2]) {
                if (!camhost::project_ray(ray, 1, 3, dist.data() + c * kCameraDistortionParams,
                                          out))
                    throw std::runtime_error("invalid host projection");
                out[0] = out[0] * intr[c * 4] + intr[c * 4 + 2];
                out[1] = out[1] * intr[c * 4 + 1] + intr[c * 4 + 3];
            };
            double ray[3] = {means[i * 3], means[i * 3 + 1], means[i * 3 + 2]}, expected[2],
                   jac[2][3];
            project(ray, expected);
            const float *row = rows.data() + (c * n + i) * SCR2_STRIDE;
            max_pixel_error = std::max(max_pixel_error, std::hypot(row[SCR2_XY] - expected[0],
                                                                   row[SCR2_XY + 1] - expected[1]));
            for (int k = 0; k < 3; ++k) {
                double a[3] = {ray[0], ray[1], ray[2]}, b[3] = {ray[0], ray[1], ray[2]}, pa[2],
                       pb[2];
                a[k] += 1e-5;
                b[k] -= 1e-5;
                project(a, pa);
                project(b, pb);
                for (int r = 0; r < 2; ++r)
                    jac[r][k] = (pa[r] - pb[r]) / 2e-5;
            }
            double xx = .3, yy = .3, xy = 0;
            for (int k = 0; k < 3; ++k) {
                xx += 1e-4 * jac[0][k] * jac[0][k];
                yy += 1e-4 * jac[1][k] * jac[1][k];
                xy += 1e-4 * jac[0][k] * jac[1][k];
            }
            double det = xx * yy - xy * xy, conic[3] = {yy / det, -xy / det, xx / det};
            for (int k = 0; k < 3; ++k)
                max_conic_error =
                    std::max(max_conic_error, std::abs(row[SCR2_CONIC + k] - conic[k]));
        }
    for (auto *p : owned)
        backend::device_free(p);
    std::printf("KBPolarSpline GPU vs host: pixel %.8g, conic %.8g\n", max_pixel_error,
                max_conic_error);
    return max_pixel_error < .002 && max_conic_error < 1e-5 ? 0 : 1;
}
