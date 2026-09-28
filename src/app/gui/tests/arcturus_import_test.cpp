#include "app/gui/ArcturusImport.h"
#include <filesystem>
#include <iostream>
int main(int argc, char **argv) {
    if (argc < 3 || argc > 4)
        return 2;
    try {
        gui::PrepJob job;
        job.workspace = argv[2];
        job.ffmpeg_exe = "ffmpeg";
        job.max_frames = argc == 4 ? std::stoi(argv[3]) : 3;
        gui::PrepInput input;
        input.path = argv[1];
        input.is_video = true;
        job.inputs.push_back(input);
        gui::PrepResult result;
        std::atomic<bool> cancel{false};
        const auto images = (std::filesystem::path(job.workspace) / "images").string();
        if (!gui::extract_arcturus(
                job, job.inputs.front(), images, result, cancel,
                [](const std::string &s) { std::cout << s << std::endl; }, nullptr))
            return 3;
        std::cout << "Native import complete\n";
        return 0;
    } catch (const std::exception &e) {
        std::cerr << e.what() << '\n';
        return 1;
    }
}
