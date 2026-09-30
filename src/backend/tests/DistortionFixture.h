#pragma once

// Camera-distortion inputs shared by the backend parity tools: the compiled
// (camera model, tier) set and one coefficient row per (tier, camera).

#include <core/Common.cuh>

#include <cstdint>
#include <vector>

namespace dist_fixture {

inline const char *const kTierNames[4] = {"NONE", "OPENCV", "THIN_PRISM", "KB_POLAR_SPLINE"};

// Tiers compiled for each camera model, in CameraModelType order; see
// camera_distortion_is_compiled in core/CameraModel.h. Rows are padded with
// tier 0 so a fixed-width table indexes cleanly -- read only kNumTiers[m].
inline constexpr int kNumTiers[4] = {4, 4, 4, 1};
inline constexpr int kTiers[4][4] = {
    {0, 1, 2, 3}, // PINHOLE
    {0, 1, 2, 3}, // FISHEYE
    {0, 1, 2, 3}, // EQUISOLID
    {0, 0, 0, 0}, // EQUIRECTANGULAR
};

// [tier][camera][kCameraDistortionParams], each row in ITS OWN tier's slot
// order and filling the terms the cheaper tiers cannot express. Magnitudes stay
// mild: a strong lens flips borderline culls and rewrites whole comparison rows.
inline std::vector<float> distortion_rows(int64_t C) {
    static const float row[4][kCameraDistortionParams] = {
        {},
        {0.05f, -0.01f, 0.0012f, -0.0020f},
        {0.05f, -0.01f, 0.0020f, -0.0005f, 0.0012f, -0.0020f, 0.0015f, -0.0008f},
        {0.05f, -0.01f, 0.002f, -0.0005f, 6.0f, 6.1f, 1.0f / 600, 1.0f / 610},
    };
    std::vector<float> out((size_t)4 * C * kCameraDistortionParams, 0.0f);
    for (int t = 0; t < 4; t++)
        for (int64_t c = 0; c < C; c++) {
            const float s = 1.0f - 0.3f * (float)(c % 3);
            for (int k = 0; k < kCameraDistortionParams; k++)
                out[((size_t)t * C + c) * kCameraDistortionParams + k] =
                    s * row[t][k];
        }
    for (int64_t c = 0; c < C; ++c)
        for (int k = 0; k < 50; ++k)
            out[((size_t)3 * C + c) * kCameraDistortionParams + 8 + k] =
                0.15f * (float)((k * 7 + c * 3) % 13 - 6);
    return out;
}

// Offset in floats of camera `c`'s row under `tier`, into distortion_rows(C).
inline int64_t row_offset(int tier, int64_t C, int64_t c = 0) {
    return ((int64_t)tier * C + c) * kCameraDistortionParams;
}

}  // namespace dist_fixture
