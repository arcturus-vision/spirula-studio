#pragma once

#include <algorithm>
#include <cmath>

namespace polar_spline {
inline double value(double x) { return x; }
template <class T> inline double value(const T &x) { return x.a; }

template <class T> inline T cubic(T a, T b, T c, T d, T t) {
    return b +
           T(0.5) * t *
               (c - a + t * (T(2) * a - T(5) * b + T(4) * c - d + t * (T(3) * (b - c) + d - a)));
}

// Five free radial rows follow two zero rows; theta is periodic, radius clamped.
template <class T, class C> void shift(T x, T y, const C *coeff, T out[2]) {
    using std::atan2;
    using std::sqrt;
    if (value(x * x + y * y) < 1e-20) {
        out[0] = out[1] = T(0);
        return;
    }
    T radius = sqrt(x * x + y * y);
    T theta = atan2(y, x) * T(0.7957747154594767);
    if (value(theta) < 0)
        theta = theta + T(5);
    int r = (int)std::floor(value(radius)), c = (int)std::floor(value(theta));
    T rt[2];
    for (int axis = 0; axis < 2; ++axis) {
        T rows[4];
        for (int i = 0; i < 4; ++i) {
            int row = std::clamp(r + i - 1, 0, 6);
            T nodes[4];
            for (int j = 0; j < 4; ++j) {
                int col = ((c + j - 1) % 5 + 5) % 5;
                nodes[j] = row < 2 ? T(0) : T(coeff[axis * 25 + (row - 2) * 5 + col]);
            }
            rows[i] = cubic(nodes[0], nodes[1], nodes[2], nodes[3], theta - T(c));
        }
        rt[axis] = cubic(rows[0], rows[1], rows[2], rows[3], radius - T(r));
    }
    out[0] = (rt[0] * x - rt[1] * y) / radius;
    out[1] = (rt[0] * y + rt[1] * x) / radius;
}
} // namespace polar_spline
