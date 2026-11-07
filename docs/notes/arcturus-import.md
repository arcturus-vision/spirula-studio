# Arcturus Vision Camera recordings

Open or drop an original Arcturus Vision Camera `.mp4` in Spirula Studio,
choose an output dataset folder, select **Built-in (GPU)** reconstruction,
and click **Create Dataset**. The camera badge identifies recordings with
supported calibration and tracking. When reconstruction succeeds, use
**Open in Trainer** and start training. Checkpoints contain `splat.ply` and
`splat.xrSceneTransform.json`; copy both to Gaussian XR.

The importer reads the recording's `gpmd` AVmf/AVmd `json/v1` metadata in C++.
It retains both video tracks, separate calibrated intrinsics, each timestamp's stereo
extrinsics, and tracking poses. With I-frame selection disabled, the frame-rate field controls uniform sampling
across the complete recording (at most 500 stereo instants). Lens guesses,
sharpness selection and adaptive frame selection do not override that sampling.
One recording is supported per dataset; separate recordings may have unrelated
tracking origins. The importer prefers `kb_polar_spline` when present and falls
back to `kb` / `kb4`. A malformed polar calibration is rejected rather than
silently replaced with an approximate model.

**Only use I-frames** is enabled by default. FPS limits the sampling rate over
paired codec keyframes; zero retains all eligible pairs. The maximum frame count
then selects a distributed subset. Sharpness and adaptive spacing do not affect
this mode. At least three paired instants with matching tracking poses are required.
Decoding verifies an I-frame marked as a keyframe at the requested timestamp.
Ordinary videos keep their usual sampling behavior.

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
modification time, import version, sampling mode and sampling count. Interrupted extraction is
retained; restarting replaces its generated frames. Use a fresh dataset folder
for independent experiments. Reconstruction reuse also requires a successful
`.arcturus-aligned` marker and matching reconstruction settings. A new attempt
invalidates that marker until alignment succeeds. The original MP4 is never changed.

Native checks: `sfm_arcturus_test`, `sfm_telemetry_test`, and
`arcturus_import_test RECORDING OUTPUT [MAX_STEREO_INSTANTS] [--keyframes]`.
Use `0 --keyframes --fps 0` to validate every paired keyframe.
The last executable drives the same extraction code as the GUI, with real FFmpeg
decoding. It is a developer validation tool, not required by the application.

## KBPolarSpline

KBPolarSpline applies the recorded periodic bicubic radial/tangential correction
to KB4-projected pixels. The supported grid has five angular columns and five
stored radial rows, preceded by two fixed zero rows. Radius clamps at the grid
boundary and angle wraps. Projection evaluates the spline directly, without the
tracking runtime's approximate LUT. The inverse solves for the original ray.
Images are not remapped; normal training resolution reduction is unchanged.

The manifest model is `kb-polar-spline`. Its 61 parameters are `fx fy cx cy
k1 k2 k3 k4 nodeSpacingR scaledU scaledV`, then 25 `sR` and 25 `sT` values in
radial-major order. The sparse camera record uses Spirula's extension ID 1001,
`KB_POLAR_SPLINE`; unmodified external COLMAP readers do not support that ID.
PLY exports contain splats and remain compatible with ordinary splat viewers.

Focal lengths may refine. Principal point, radial polynomial, spline coefficients,
and grid scales remain fixed. This model routes bundle adjustment to the CPU;
training and rendering evaluate its projection and derivatives on the GPU through
the shared Slang implementation for Vulkan and CUDA. The normalized training
coefficient layout preserves the original unscaled-pixel spline domain when the
image resolution changes.

`polar_camera_test` checks GPU projected means and covariances against host
projection and numerical derivatives. The shared backend parity fixtures include
nonzero polar splines. `sfm_arcturus_test` checks metadata selection, projection,
inversion, BA Jacobians, and parameter serialization.

## Import and training settings

The Arcturus Vision import preset is selected when supported recordings are
detected. Explicit preset choices and restored settings take precedence.
It uses both eyes, I-frames, pose-assisted pair selection, fixed distortion, and
a 130-degree full-angle mask. Left-only and right-only imports retain the selected
eye's calibration and tracking. FPS remains editable when selecting the preset.

Each mask is computed from the recorded KB4 or KBPolarSpline calibration and
intersected with segmentation or editor masks. It applies to feature matching and
training without requiring segmentation weights. Changing eyes rebuilds frames;
changing the mask angle rebuilds masks and masked reconstruction.

The separate training preset uses SH0, 30,000 iterations, a 1.5 million Gaussian
cap, and half-width/half-height images. It ignores masked pixels and preserves
native camera projection and the metric tracking frame. Opening a supported dataset
selects it only when no explicit training preset or edited settings take precedence.
Checkpoint resumes retain their saved settings.

## Pair selection and navigation

Native stereo manifests include `stereo_groups`. Selection scores one eye per
instant and expands selected links to both eyes. `--no-stereo-selection` disables
this grouping. `--tracking-selection` uses recorded poses to shortlist candidates,
with independent visual audit pairs and normal matching and geometric verification.
Missing poses use visual selection. Weak or disconnected matches, inadequate image
coverage, or poor reconstruction agreement trigger a full visual search.
The GUI exposes this as **Use dataset poses to speed up image-pair selection**.

Aligned models record `up_axis 0 -1 0` in `sparse/0/gauge.txt`. Legacy imports use
the `.arcturus-aligned` marker to recover this navigation direction. Viewers carry
it through normalization and placement; display rotation adjusts live-preview
navigation without rotating calibrated images or reconstructed geometry.

Additional checks: `navigation_frame_test`, `polar_frustum_test`,
`dataset_plan_test`, `preset_roundtrip_test`, and
`arcturus_import_test --mask-test`. Real-recording tests also accept
`--eye both|left|right` and `--with-mask`.
