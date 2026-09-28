#pragma once
#include "i18n/BeginCatalog.h"
namespace spirula {
namespace i18n {
namespace msg {
namespace arcturus {
SS_MSG_EN(err_import_one_arcturus_recording_per_dataset_tracking,
          "Import one Arcturus recording per dataset; tracking worlds from separate clips cannot "
          "be combined");
SS_MSG_EN(err_arcturus_import_requires_ffmpeg_set_its_location,
          "Arcturus import requires FFmpeg; set its location in Tools");
SS_MSG_EN(err_arcturus_recording_must_have_exactly_two_video,
          "Arcturus recording must have exactly two video tracks");
SS_MSG_EN(err_arcturus_output_contains_images_from_another_import,
          "Arcturus output contains images from another import; choose a new dataset folder");
SS_MSG_EN(err_arcturus_import_cancelled, "Arcturus import cancelled");
SS_MSG_EN(err_arcturus_video_frame_is_missing_near_its,
          "Arcturus video frame is missing near its tracking timestamp");
SS_MSG_EN(err_invalid_decoded_arcturus_image_size, "Invalid decoded Arcturus image size");
SS_MSG_EN(err_cannot_read_decoded_arcturus_image, "Cannot read decoded Arcturus image");
SS_MSG_EN(err_cannot_read_decoded_arcturus_frame, "Cannot read decoded Arcturus frame");
SS_MSG_EN(err_cannot_save_arcturus_image, "Cannot save Arcturus image");
SS_MSG_EN(err_arcturus_stereo_video_tracks_are_not_synchronized,
          "Arcturus stereo video tracks are not synchronized");
SS_MSG_EN(err_cannot_save_arcturus_calibration_and_poses,
          "Cannot save Arcturus calibration and poses");
SS_MSG_EN(err_arcturus_metadata_contains_an_invalid_number,
          "Arcturus metadata contains an invalid number");
SS_MSG_EN(err_arcturus_metadata_has_an_invalid_pose_vector,
          "Arcturus metadata has an invalid pose vector");
SS_MSG_EN(err_arcturus_metadata_has_an_invalid_pose_matrix,
          "Arcturus metadata has an invalid pose matrix");
SS_MSG_EN(err_arcturus_pose_has_a_zero_axis, "Arcturus pose has a zero axis");
SS_MSG_EN(err_arcturus_pose_axes_are_parallel, "Arcturus pose axes are parallel");
SS_MSG_EN(err_arcturus_capture_requires_two_calibrated_cameras,
          "Arcturus capture requires two calibrated cameras");
SS_MSG_EN(err_arcturus_camera_calibration_has_invalid_dimensions_or,
          "Arcturus camera calibration has invalid dimensions or focal lengths");
SS_MSG_EN(err_arcturus_camera_has_no_public_kb4_calibration,
          "Arcturus camera has no public KB4 calibration");
SS_MSG_EN(err_truncated_arcturus_metadata_packet, "Truncated Arcturus metadata packet");
SS_MSG_EN(err_unsupported_or_incomplete_arcturus_metadata_envelope,
          "Unsupported or incomplete Arcturus metadata envelope");
SS_MSG_EN(err_missing_arcturus_metadata_envelope, "Missing Arcturus metadata envelope");
SS_MSG_EN(err_arcturus_capture_has_insufficient_tracked_frames,
          "Arcturus capture has insufficient tracked frames");
SS_MSG_EN(err_invalid_arcturus_frame_count, "Invalid Arcturus frame count");
SS_MSG_EN(err_arcturus_sampling_selected_duplicate_timestamps,
          "Arcturus sampling selected duplicate timestamps");
SS_MSG_EN(err_unsupported_arcturus_display_rotation, "Unsupported Arcturus display rotation");
SS_MSG_EN(err_cannot_determine_arcturus_xr_starting_heading,
          "Cannot determine Arcturus XR starting heading");
SS_MSG_EN(err_incomplete_arcturus_pose_file, "Incomplete Arcturus pose file");
SS_MSG_EN(err_arcturus_reconstruction_registered_fewer_than_half_the,
          "Arcturus reconstruction registered fewer than half the views or has no sparse points");
SS_MSG_EN(err_arcturus_reconstruction_did_not_preserve_the_fisheye,
          "Arcturus reconstruction did not preserve the fisheye camera model");
SS_MSG_EN(err_arcturus_reconstruction_changed_fixed_principal_point_or,
          "Arcturus reconstruction changed fixed principal point or distortion calibration");
SS_MSG_EN(err_arcturus_tracking_alignment_requires_noncollinear_camera_positions,
          "Arcturus tracking alignment requires noncollinear camera positions");
SS_MSG_EN(err_arcturus_tracking_alignment_is_degenerate,
          "Arcturus tracking alignment is degenerate");
SS_MSG_EN(err_cannot_write_arcturus_alignment_or_xr_starting,
          "Cannot write Arcturus alignment or XR starting view");
SS_MSG_EN(err_cannot_write_arcturus_completion_marker, "Cannot write Arcturus completion marker");
SS_MSG_EN(missing_metadata, "Arcturus metadata missing {0}");
SS_MSG_EN(unexpected_image, "Arcturus reconstruction contains an unexpected image: {0}");
SS_MSG_EN(decode_failed, "Arcturus frame decoding failed at {0}");
SS_MSG_EN(require_builtin,
          "Select Built-in reconstruction to preserve Arcturus calibration and tracking");
SS_MSG_EN(cpu_fallback, "Hardware video decoding failed; retrying on CPU.");
SS_MSG_EN(import_help,
          "Uses embedded KB4 calibration, synchronized timestamps and metric tracking. Frame rate "
          "controls sampling; lens and sharpness settings are ignored. Select Built-in "
          "reconstruction and import one recording per dataset.");
SS_MSG(calibrated, EN("Arcturus Vision Camera: calibrated stereo + tracking"),
       JA("Arcturus Vision Camera: 校正済みステレオ + トラッキング"),
       ZH_HANS("Arcturus Vision Camera：已标定立体图像 + 跟踪"),
       ZH_HANT("Arcturus Vision Camera：已校正立體影像 + 追蹤"),
       KO("Arcturus Vision Camera: 보정된 스테레오 + 추적"),
       DE("Arcturus Vision Camera: kalibriertes Stereo + Tracking"),
       FR("Arcturus Vision Camera : stéréo calibrée + suivi"),
       ES("Arcturus Vision Camera: estéreo calibrado + seguimiento"),
       PT("Arcturus Vision Camera: estéreo calibrado + rastreamento"),
       IT("Arcturus Vision Camera: stereo calibrato + tracciamento"),
       NL("Arcturus Vision Camera: gekalibreerde stereo + tracking"),
       RU("Arcturus Vision Camera: калиброванное стерео + отслеживание"),
       TR("Arcturus Vision Camera: kalibre stereo + takip"));
SS_MSG(extracting, EN("Extracting synchronized stereo: {0} / {1}"),
       JA("同期ステレオを抽出中: {0} / {1}"), ZH_HANS("正在提取同步立体图像：{0} / {1}"),
       ZH_HANT("正在擷取同步立體影像：{0} / {1}"), KO("동기화된 스테레오 추출 중: {0} / {1}"),
       DE("Synchrones Stereo extrahieren: {0} / {1}"),
       FR("Extraction stéréo synchronisée : {0} / {1}"),
       ES("Extrayendo estéreo sincronizado: {0} / {1}"),
       PT("Extraindo estéreo sincronizado: {0} / {1}"),
       IT("Estrazione stereo sincronizzato: {0} / {1}"),
       NL("Gesynchroniseerde stereo extraheren: {0} / {1}"),
       RU("Извлечение синхронного стерео: {0} / {1}"),
       TR("Senkronize stereo çıkarılıyor: {0} / {1}"));
} // namespace arcturus
} // namespace msg
} // namespace i18n
} // namespace spirula
#include "i18n/EndCatalog.h"
