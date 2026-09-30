# Arcturus Vision Camera recordings

Open or drop an original Arcturus Vision Camera `.mp4` in Spirula Studio,
choose an output dataset folder, select **Built-in (GPU)** reconstruction,
and click **Create Dataset**. The camera badge identifies recordings with
supported calibration and tracking. When reconstruction succeeds, use
**Open in Trainer** and start training. Checkpoints contain `splat.ply` and
`splat.xrSceneTransform.json`; copy both to Gaussian XR.

The importer reads the recording's `gpmd` AVmf/AVmd `json/v1` metadata in C++.
It retains both video tracks, separate calibrated intrinsics, each timestamp's stereo
extrinsics, and tracking poses. The frame-rate field controls uniform sampling
across the complete recording (at most 500 stereo instants). Lens guesses,
sharpness selection and adaptive frame selection do not override that sampling.
One recording is supported per dataset; separate recordings may have unrelated
tracking origins. The importer prefers `kb_polar_spline` when present and falls
back to `kb` / `kb4`. A malformed polar calibration is rejected rather than
silently replaced with an approximate model.

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

## Paired validation

A single 200-view stereo recording supplied both KB4 (`OPENCV_FISHEYE`) and
KBPolarSpline calibrations. This is not the separate Cartesian KBSpline model.
Both reconstructions used identical images and fixed distortion; only focal
lengths could refine. The spline registered 196 views versus 193, reduced mean
reprojection error from 0.712 to 0.617 px, and reduced tracking-alignment RMS
from 4.530 to 4.115 cm. Tracking agreement is not independent ground truth.

With 167 common training views, 26 timestamp-held-out views, 7,000 iterations,
1232-square images and a one-million-splat cap, KBPolarSpline improved held-out
PSNR from 16.31 to 17.31 dB and SSIM from 0.6496 to 0.6690. Each model used its
own reconstruction and sparse seed cloud; held-out images participated in SfM
but not splat training. These single-recording results measure the end-to-end
pipeline, not the spline in isolation or a universal quality improvement.

Evaluation fetches each view by index so disk prefetch cannot repeat views
across epoch boundaries. Resume excludes the separately stored DC term from
the SH layout count, preserving saved renders without unnecessary adaptation.
