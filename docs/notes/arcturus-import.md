# Arcturus Vision Camera recordings

Open or drop an original Arcturus Vision Camera `.mp4` in Spirula Studio,
choose an output dataset folder, select **Built-in (GPU)** reconstruction,
and click **Create Dataset**. The camera badge identifies recordings with
supported calibration and tracking. When reconstruction succeeds, use
**Open in Trainer** and start training. Checkpoints contain `splat.ply` and
`splat.xrSceneTransform.json`; copy both to Gaussian XR.

The importer reads the recording's `gpmd` AVmf/AVmd `json/v1` metadata in C++.
It retains both video tracks, separate KB4 intrinsics, each timestamp's stereo
extrinsics, and tracking poses. The frame-rate field controls uniform sampling
across the complete recording (at most 500 stereo instants). Lens guesses,
sharpness selection and adaptive frame selection do not override that sampling.
One recording is supported per dataset; separate recordings may have unrelated
tracking origins. Proprietary polar-spline calibration without public KB4 is
rejected.

FFmpeg is required for video decoding and can be selected in Tool locations.
No Python, COLMAP executable, or external reconstruction pipeline is used.
Pixels remain in their calibrated, unrotated sensor layout. HLG uses the
camera player's gamma-1.2 / extended-Reinhard presentation and BT.2020-to-BT.709
conversion when tagged. RGB output is sRGB. Display rotation is reserved for
the XR starting view.

Spirula's native SfM estimates poses and points with calibrated fisheye cameras.
Focal lengths may refine; principal point and distortion remain fixed. CPU
bundle adjustment is used on the validated macOS path. The largest component
must register at least half the sampled views and contain sparse points.
A similarity fit establishes metric scale; the first registered camera anchors
orientation to tracking. A failed coverage or alignment check leaves the
intermediate files for diagnosis and does not report a completed import.

The dataset retains `.arcturus-poses.txt` and `.arcturus-manifest.json` in its
image directory, `.arcturus-raw-sparse/`, `alignment.json`, and the XR sidecar.
Training opened from this dataset keeps its metric coordinate frame and native
fisheye projection. The XR starting view uses a registered camera nearest the
median camera position, its MP4 display rotation, and a level horizontal heading.
It does not translate the scene to the origin or alter its scale. Changing the
training scene center or relative scale prevents copying the unchanged sidecar.

Frame reuse requires a completed native import marker matching source size,
modification time, import version and sampling count. Interrupted extraction is
retained; restarting replaces its generated frames. Use a fresh dataset folder
for independent experiments. Reconstruction reuse also requires a successful
`.arcturus-aligned` marker and matching reconstruction settings. A new attempt
invalidates that marker until alignment succeeds. The original MP4 is never changed.

Native checks: `sfm_arcturus_test`, `sfm_telemetry_test`, and
`arcturus_import_test RECORDING OUTPUT [MAX_STEREO_INSTANTS]`.
The last executable drives the same extraction code as the GUI, with real FFmpeg
decoding. It is a developer validation tool, not required by the application.
