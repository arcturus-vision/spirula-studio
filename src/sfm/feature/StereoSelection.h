#pragma once

#include "sfm/core/Sequence.h"
#include "sfm/feature/PairSelection.h"

namespace sfm {

struct StereoSelection {
    std::vector<std::vector<uint32_t>> members;
    std::vector<uint32_t> representatives;

    std::vector<std::pair<uint32_t, uint32_t>> expand(
        const std::vector<std::pair<uint32_t, uint32_t>>& selected) const {
        std::vector<std::pair<uint32_t, uint32_t>> out;
        auto add = [&](uint32_t a, uint32_t b) {
            if (a != b) out.emplace_back(std::min(a, b), std::max(a, b));
        };
        for (const auto& group : members)
            for (size_t a = 0; a < group.size(); ++a)
                for (size_t b = a + 1; b < group.size(); ++b) add(group[a], group[b]);
        for (const auto& p : selected)
            for (uint32_t a : members.at(p.first))
                for (uint32_t b : members.at(p.second)) add(a, b);
        std::sort(out.begin(), out.end());
        out.erase(std::unique(out.begin(), out.end()), out.end());
        return out;
    }
};

inline StereoSelection stereoSelection(const std::vector<std::string>& names,
                                        const std::vector<SequenceDef>& groups) {
    for (const auto& group : groups)
        if (group.members.size() != 2 || group.members[0] == group.members[1])
            throw std::runtime_error("stereo_groups: expected two distinct camera prefixes");
    const auto table = buildSequenceTable(names, groups);
    StereoSelection out;
    std::map<std::pair<int32_t, int32_t>, size_t> frame;
    for (uint32_t i = 0; i < names.size(); ++i) {
        size_t slot = out.members.size();
        if (table.has(i)) {
            const auto key = std::make_pair(table.seq[i], table.pos[i]);
            slot = frame.emplace(key, slot).first->second;
        }
        if (slot == out.members.size()) {
            out.members.push_back({});
            out.representatives.push_back(i);
        }
        out.members[slot].push_back(i);
        if (table.has(i) && table.member[i] == 0) out.representatives[slot] = i;
    }
    return out;
}

inline std::vector<std::pair<uint32_t, uint32_t>> stereoPrefilterPairs(
    const std::vector<FeatureSet>& feats, const StereoSelection& stereo,
    PairSelectionOptions opt, const std::function<void(size_t, size_t)>& progress = nullptr) {
    if (stereo.representatives.size() == feats.size()) return prefilterPairs(feats, opt, progress);
    std::vector<FeatureSet> representatives;
    representatives.reserve(stereo.representatives.size());
    for (uint32_t i : stereo.representatives) representatives.push_back(feats.at(i));
    // Each timestamp partner expands to both eyes; preserve the image-neighbour budget.
    opt.num_neighbors = std::max(1u, (uint32_t)((opt.num_neighbors * representatives.size() +
                                               feats.size() - 1) / feats.size()));
    return stereo.expand(prefilterPairs(representatives, opt, progress));
}

}  // namespace sfm
