#pragma once
#include "app/gui/DatasetPrep.h"
namespace gui {
bool extract_arcturus(const PrepJob &job, const PrepInput &input, const std::string &images,
                      PrepResult &result, const std::atomic<bool> &cancel,
                      const std::function<void(const std::string &)> &log, RunProgress *progress);
void align_arcturus_dataset(const std::string &workspace, const std::string &images);
} // namespace gui
