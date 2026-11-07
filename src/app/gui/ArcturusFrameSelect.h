#pragma once

#include <algorithm>
#include <iomanip>
#include <sstream>
#include <vector>

namespace gui::detail {

inline size_t arcturus_chunk_end(const std::vector<double> &times, size_t first, bool keyframes) {
    if (keyframes || first >= times.size())
        return times.size();
    size_t last = first + 1;
    while (last < times.size() && times[last] - times[last - 1] <= 6.)
        ++last;
    return last;
}

// Balanced decisions avoid FFmpeg's expression-depth limit on long recordings.
inline void arcturus_select(std::ostream &out, const std::vector<double> &times,
                            size_t first, size_t last, bool keyframes, double half_frame) {
    if (last - first > 1) {
        const size_t middle = first + (last - first) / 2;
        out << "if(lt(t," << times[middle] - (keyframes ? .002 : half_frame) << "),";
        arcturus_select(out, times, first, middle, keyframes, half_frame);
        out << ',';
        arcturus_select(out, times, middle, last, keyframes, half_frame);
        out << ')';
    } else if (keyframes) {
        out << "between(t," << times[first] - .002 << ',' << times[first] + .002 << ')';
    } else {
        const double begin = times[first] - half_frame;
        const double end = first + 1 < times.size()
            ? std::min(times[first] + .075, times[first + 1] - half_frame)
            : times[first] + .075;
        out << "gte(t," << begin << ")*lt(t," << end
            << ")*(isnan(prev_selected_t)+lt(prev_selected_t," << begin << "))";
    }
}

inline std::string arcturus_frame_filter(const std::vector<double> &times, size_t first,
                                         size_t last, bool keyframes, double half_frame) {
    std::ostringstream out;
    out << std::setprecision(17) << "select='";
    if (keyframes)
        out << "eq(key,1)*(";
    if (first < last)
        arcturus_select(out, times, first, last, keyframes, half_frame);
    else out << '0';
    if (keyframes) out << ')';
    out << "',showinfo=checksum=0,format=rgb24";
    return out.str();
}
}
