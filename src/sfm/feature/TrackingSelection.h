#pragma once

#include "sfm/core/ArcturusCapture.h"
#include "sfm/core/Cancel.h"
#include "sfm/core/Matches.h"
#include "sfm/feature/StereoSelection.h"
#include <set>
#include <numeric>

namespace sfm {

struct TrackingSelection {
    std::vector<std::pair<uint32_t, uint32_t>> pairs;
    std::set<std::pair<uint32_t, uint32_t>> audit;
    bool usable = false;
};

inline TrackingSelection trackingSelection(const std::vector<std::string>& names,
                                           const StereoSelection& stereo,
                                           const ArcturusPoseMap& targets) {
    TrackingSelection out;
    const size_t n = stereo.representatives.size();
    if (n < 8) return out;
    std::vector<Pose> poses;
    for (uint32_t id : stereo.representatives) {
        const auto it = targets.find(names.at(id));
        if (it == targets.end()) return out;
        poses.push_back(it->second.first);
    }
    std::set<std::pair<uint32_t, uint32_t>> edges;
    auto edge = [](uint32_t a, uint32_t b) { return std::make_pair(std::min(a, b), std::max(a, b)); };
    for (uint32_t i = 0; i < n; ++i) {
        cancel::check();
        std::vector<std::pair<double, uint32_t>> ranked;
        const Vec3 forward{poses[i].R[2], poses[i].R[5], poses[i].R[8]};
        for (uint32_t j = 0; j < n; ++j) {
            if (i == j) continue;
            const Vec3 other{poses[j].R[2], poses[j].R[5], poses[j].R[8]};
            const Vec3 delta = poses[i].t - poses[j].t;
            const double angle = 1. - std::clamp(forward.dot(other), -1., 1.);
            ranked.emplace_back(delta.dot(delta) + .25 * angle * angle, j);
        }
        const size_t k = std::min<size_t>(12, ranked.size());
        std::partial_sort(ranked.begin(), ranked.begin() + k, ranked.end());
        for (size_t j = 0; j < k; ++j) edges.insert(edge(i, ranked[j].second));
        for (uint32_t j = i + 1; j < std::min<size_t>(n, i + 4); ++j) edges.insert(edge(i, j));
    }
    std::vector<std::pair<uint32_t, uint32_t>> probes;
    uint32_t stride = 37;
    while (std::gcd(stride, (uint32_t)n) != 1) ++stride;
    for (uint32_t i = 0; i < n; ++i) {
        unsigned count = 0;
        // Stable, dispersed probes do not share the tracking prior's blind spots.
        for (uint32_t step = 1; step < n && count < 2; ++step) {
            const uint32_t j = (i + (step * stride) % n) % n;
            if (i == j || edges.count(edge(i, j))) continue;
            probes.push_back(edge(i, j));
            ++count;
        }
    }
    out.pairs = stereo.expand({edges.begin(), edges.end()});
    const auto expanded_probes = stereo.expand(probes);
    for (const auto& p : expanded_probes)
        if (!std::binary_search(out.pairs.begin(), out.pairs.end(), p)) out.audit.insert(p);
    out.pairs.insert(out.pairs.end(), out.audit.begin(), out.audit.end());
    std::sort(out.pairs.begin(), out.pairs.end());
    out.usable = true;
    return out;
}

inline bool trackingGraphHealthy(const MatchesDatabase& db, const TrackingSelection& selection) {
    const size_t n = db.images.size();
    if (!n) return false;
    std::vector<std::vector<size_t>> support(n);
    std::vector<std::vector<uint32_t>> neighbors(n);
    std::vector<size_t> audit_best(n);
    for (const auto& p : db.pairs) {
        if (p.matches.size() < 30) continue;
        neighbors[p.image1].push_back(p.image2);
        neighbors[p.image2].push_back(p.image1);
        if (selection.audit.count({p.image1, p.image2})) {
            audit_best[p.image1] = std::max(audit_best[p.image1], p.matches.size());
            audit_best[p.image2] = std::max(audit_best[p.image2], p.matches.size());
        } else {
            support[p.image1].push_back(p.matches.size());
            support[p.image2].push_back(p.matches.size());
        }
    }
    size_t weak = 0, missed = 0, largest = 0;
    std::vector<bool> seen(n);
    for (uint32_t i = 0; i < n; ++i) {
        weak += support[i].size() < 3;
        if (!support[i].empty()) {
            std::sort(support[i].begin(), support[i].end());
            missed += audit_best[i] > std::max<size_t>(80, 2 * support[i][support[i].size() / 2]);
        }
        if (seen[i]) continue;
        std::vector<uint32_t> queue{i};
        seen[i] = true;
        for (size_t k = 0; k < queue.size(); ++k)
            for (uint32_t j : neighbors[queue[k]])
                if (!seen[j]) { seen[j] = true; queue.push_back(j); }
        largest = std::max(largest, queue.size());
    }
    return weak * 100 <= n * 2 && missed * 100 <= n * 5 && largest * 100 >= n * 99;
}

} // namespace sfm
