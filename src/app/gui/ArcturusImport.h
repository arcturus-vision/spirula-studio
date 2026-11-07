#pragma once
#include "app/gui/DatasetPrep.h"
namespace gui {
bool extract_arcturus(const PrepJob &job, const PrepInput &input, const std::string &images,
                      PrepResult &result, const std::atomic<bool> &cancel,
                      const std::function<void(const std::string &)> &log, RunProgress *progress);
bool apply_arcturus_masks(const std::string &images, const std::string &masks,
                          const std::atomic<bool> &cancel, bool combine_existing = true, int degrees = 130);
void align_arcturus_dataset(const std::string &workspace, const std::string &images);
} // namespace gui
