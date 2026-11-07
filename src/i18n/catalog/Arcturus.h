#pragma once
#include "i18n/BeginCatalog.h"
namespace spirula {
namespace i18n {
namespace msg {
namespace arcturus {
SS_MSG(radial_mask,
    EN("Mask above radius (degrees)"), JA("半径を超える範囲をマスク（度）"),
    ZH_HANS("遮罩半径以外区域（度）"), ZH_HANT("遮罩半徑以外區域（度）"),
    KO("반경 밖 마스크 (도)"), DE("Außerhalb des Radius maskieren (Grad)"),
    FR("Masquer au-delà du rayon (degrés)"), ES("Enmascarar fuera del radio (grados)"),
    PT("Mascarar além do raio (graus)"), IT("Maschera oltre il raggio (gradi)"),
    NL("Buiten straal maskeren (graden)"), RU("Маска за радиусом (градусы)"),
    TR("Yarıçap dışını maskele (derece)"));
SS_MSG(radial_mask_help,
    EN("Full field of view retained around the calibrated optical axis, in degrees (1–360). Applies to feature matching and 3DGS training for all Arcturus videos. Default: 130 degrees."),
    JA("校正された光軸の周りに保持する全画角（1～360度）。すべての Arcturus 動画の特徴点マッチングと 3DGS 学習に適用します。既定値：130度。"),
    ZH_HANS("围绕标定光轴保留的完整视场角，单位为度（1–360）。应用于所有 Arcturus 视频的特征匹配和 3DGS 训练。默认值：130度。"),
    ZH_HANT("圍繞校正光軸保留的完整視場角，單位為度（1–360）。套用於所有 Arcturus 影片的特徵比對和 3DGS 訓練。預設值：130度。"),
    KO("보정된 광축 주위에 유지할 전체 시야각(1–360도)입니다. 모든 Arcturus 동영상의 특징 매칭과 3DGS 학습에 적용됩니다. 기본값: 130도."),
    DE("Vollständiges Sichtfeld um die kalibrierte optische Achse in Grad (1–360). Gilt für Feature-Matching und 3DGS-Training aller Arcturus-Videos. Standard: 130 Grad."),
    FR("Champ de vision total conservé autour de l’axe optique calibré, en degrés (1–360). S’applique à l’appariement et à l’entraînement 3DGS de toutes les vidéos Arcturus. Par défaut : 130 degrés."),
    ES("Campo de visión completo conservado alrededor del eje óptico calibrado, en grados (1–360). Se aplica al emparejamiento y entrenamiento 3DGS de todos los vídeos Arcturus. Predeterminado: 130 grados."),
    PT("Campo de visão completo mantido ao redor do eixo óptico calibrado, em graus (1–360). Aplica-se à correspondência e ao treino 3DGS de todos os vídeos Arcturus. Padrão: 130 graus."),
    IT("Campo visivo completo mantenuto attorno all’asse ottico calibrato, in gradi (1–360). Si applica alla corrispondenza e all’addestramento 3DGS di tutti i video Arcturus. Predefinito: 130 gradi."),
    NL("Volledig behouden beeldveld rond de gekalibreerde optische as, in graden (1–360). Geldt voor kenmerkkoppeling en 3DGS-training van alle Arcturus-video’s. Standaard: 130 graden."),
    RU("Полное поле зрения вокруг калиброванной оптической оси в градусах (1–360). Применяется к сопоставлению признаков и обучению 3DGS для всех видео Arcturus. По умолчанию: 130 градусов."),
    TR("Kalibre edilmiş optik eksen çevresinde korunan tam görüş alanı, derece olarak (1–360). Tüm Arcturus videolarının özellik eşleştirmesine ve 3DGS eğitimine uygulanır. Varsayılan: 130 derece."));
SS_MSG(mask_applied,
    EN("Applied the calibrated Arcturus Vision Camera radial mask: {0} degrees."),
    JA("校正された Arcturus Vision Camera の放射状マスクを適用しました：{0}度。"),
    ZH_HANS("已应用标定的 Arcturus Vision Camera 径向遮罩：{0}度。"),
    ZH_HANT("已套用校正的 Arcturus Vision Camera 徑向遮罩：{0}度。"),
    KO("보정된 Arcturus Vision Camera 방사형 마스크 적용: {0}도."),
    DE("Kalibrierte radiale Arcturus Vision Camera-Maske angewendet: {0} Grad."),
    FR("Masque radial calibré Arcturus Vision Camera appliqué : {0} degrés."),
    ES("Máscara radial calibrada de Arcturus Vision Camera aplicada: {0} grados."),
    PT("Máscara radial calibrada da Arcturus Vision Camera aplicada: {0} graus."),
    IT("Maschera radiale calibrata Arcturus Vision Camera applicata: {0} gradi."),
    NL("Gekalibreerd radiaal Arcturus Vision Camera-masker toegepast: {0} graden."),
    RU("Применена калиброванная радиальная маска Arcturus Vision Camera: {0} градусов."),
    TR("Kalibre edilmiş Arcturus Vision Camera radyal maskesi uygulandı: {0} derece."));
SS_MSG_EN(mask_failed, "Could not create or combine the calibrated Arcturus Vision Camera mask.");
SS_MSG(use_dataset_poses,
    EN("Use dataset poses to speed up image-pair selection"),
    JA("データセットの姿勢で画像ペア選択を高速化"),
    ZH_HANS("使用数据集位姿加速像对选择"),
    ZH_HANT("使用資料集姿態加速影像對選擇"),
    KO("데이터셋 포즈로 이미지 쌍 선택 가속"),
    DE("Bildpaarauswahl mit Datensatzposen beschleunigen"),
    FR("Accélérer la sélection des paires avec les poses du jeu de données"),
    ES("Acelerar la selección de pares con las poses del conjunto de datos"),
    PT("Acelerar a seleção de pares com as poses do conjunto de dados"),
    IT("Accelera la selezione delle coppie con le pose del dataset"),
    NL("Beeldpaarselectie versnellen met datasetposities"),
    RU("Ускорить отбор пар изображений с помощью поз набора данных"),
    TR("Veri kümesi pozlarıyla görüntü çifti seçimini hızlandır"));
SS_MSG(use_dataset_poses_help,
    EN("Use recorded Arcturus camera positions and directions to shortlist image pairs before matching. Visual search is used when poses are unavailable or validation fails. Applies to pair-selection mode."),
    JA("記録された Arcturus カメラの位置と方向で、マッチング前に画像ペアを絞り込みます。姿勢がない場合や検証に失敗した場合は画像検索を使用します。ペア選択モードに適用されます。"),
    ZH_HANS("根据记录的 Arcturus 相机位置和方向，在匹配前筛选像对。位姿不可用或验证失败时使用视觉搜索。适用于像对选择模式。"),
    ZH_HANT("根據記錄的 Arcturus 相機位置和方向，在比對前篩選影像對。姿態不可用或驗證失敗時使用視覺搜尋。適用於影像對選擇模式。"),
    KO("기록된 Arcturus 카메라 위치와 방향으로 매칭 전에 이미지 쌍을 선별합니다. 포즈가 없거나 검증에 실패하면 시각 검색을 사용합니다. 쌍 선택 모드에 적용됩니다."),
    DE("Bildpaare vor dem Matching anhand aufgezeichneter Arcturus-Kamerapositionen und -richtungen auswählen. Ohne Posen oder bei fehlgeschlagener Prüfung wird visuell gesucht. Gilt im Paarauswahlmodus."),
    FR("Présélectionner les paires avant appariement avec les positions et directions Arcturus enregistrées. Recherche visuelle si les poses manquent ou si la validation échoue. En mode sélection de paires."),
    ES("Preselecciona pares antes del emparejamiento con las posiciones y direcciones Arcturus grabadas. Usa búsqueda visual si faltan poses o falla la validación. Se aplica al modo de selección de pares."),
    PT("Pré-seleciona pares antes da correspondência com posições e direções Arcturus gravadas. Usa busca visual se faltarem poses ou a validação falhar. Aplica-se ao modo de seleção de pares."),
    IT("Preseleziona le coppie prima dell’abbinamento usando posizioni e direzioni Arcturus registrate. Usa la ricerca visiva se mancano le pose o la verifica fallisce. Si applica alla modalità di selezione delle coppie."),
    NL("Selecteer beeldparen vóór matching met opgenomen Arcturus-cameraposities en -richtingen. Gebruik visueel zoeken als posities ontbreken of validatie mislukt. Geldt in paarselectiemodus."),
    RU("Отбирать пары перед сопоставлением по записанным положениям и направлениям камер Arcturus. При отсутствии поз или ошибке проверки используется визуальный поиск. Для режима отбора пар."),
    TR("Eşleştirmeden önce kayıtlı Arcturus kamera konumları ve yönleriyle çiftleri seçer. Pozlar yoksa veya doğrulama başarısızsa görsel arama kullanılır. Çift seçimi modunda geçerlidir."));

SS_MSG(both_eyes,
    EN("Both"),
    JA("両眼"),
    ZH_HANS("双目"),
    ZH_HANT("雙目"),
    KO("양쪽"),
    DE("Beide"),
    FR("Les deux"),
    ES("Ambos"),
    PT("Ambos"),
    IT("Entrambi"),
    NL("Beide"),
    RU("Оба"),
    TR("İkisi"));
SS_MSG(left_eye,
    EN("Left"),
    JA("左眼"),
    ZH_HANS("左目"),
    ZH_HANT("左目"),
    KO("왼쪽"),
    DE("Links"),
    FR("Gauche"),
    ES("Izquierdo"),
    PT("Esquerdo"),
    IT("Sinistro"),
    NL("Links"),
    RU("Левый"),
    TR("Sol"));
SS_MSG(right_eye,
    EN("Right"),
    JA("右眼"),
    ZH_HANS("右目"),
    ZH_HANT("右目"),
    KO("오른쪽"),
    DE("Rechts"),
    FR("Droit"),
    ES("Derecho"),
    PT("Direito"),
    IT("Destro"),
    NL("Rechts"),
    RU("Правый"),
    TR("Sağ"));

SS_MSG(reconstruction_eyes,
    EN("Eyes to include"),
    JA("含める眼"),
    ZH_HANS("包含的眼睛"),
    ZH_HANT("包含的眼睛"),
    KO("포함할 눈"),
    DE("Einzuschließende Augen"),
    FR("Yeux à inclure"),
    ES("Ojos a incluir"),
    PT("Olhos a incluir"),
    IT("Occhi da includere"),
    NL("Op te nemen ogen"),
    RU("Включаемые ракурсы"),
    TR("Dahil edilecek gözler"));
SS_MSG(reconstruction_eyes_help,
    EN("Choose which camera images to import, match, reconstruct and train. Both retains stereo coverage; Left or Right uses only that eye. Pair selection always uses one eye, even when reconstructing both."),
    JA("取り込み、マッチング、再構成、学習に使うカメラ画像を選びます。両眼はステレオ範囲を維持し、左または右は片眼のみを使います。両眼を再構成する場合も、ペア選択は常に片眼で行います。"),
    ZH_HANS("选择用于导入、匹配、重建和训练的相机图像。双目保留立体覆盖；左目或右目仅使用该眼。即使重建双目，像对选择也始终只使用单目。"),
    ZH_HANT("選擇用於匯入、比對、重建和訓練的相機影像。雙目保留立體覆蓋；左目或右目僅使用該眼。即使重建雙目，影像對選擇也始終只使用單目。"),
    KO("가져오기, 매칭, 재구성, 학습에 사용할 카메라 이미지를 선택합니다. 양쪽은 스테레오 범위를 유지하고 왼쪽 또는 오른쪽은 해당 눈만 사용합니다. 양쪽을 재구성해도 쌍 선택에는 항상 한쪽 눈만 사용합니다."),
    DE("Kamerabilder für Import, Matching, Rekonstruktion und Training wählen. Beide erhält die Stereoabdeckung; Links oder Rechts nutzt nur dieses Auge. Die Paarauswahl verwendet immer ein Auge, auch bei Rekonstruktion beider."),
    FR("Choisir les images à importer, apparier, reconstruire et entraîner. Les deux conserve la couverture stéréo ; Gauche ou Droit utilise un seul œil. La sélection des paires utilise toujours un seul œil, même en reconstruisant les deux."),
    ES("Elija las imágenes para importar, emparejar, reconstruir y entrenar. Ambos conserva la cobertura estéreo; Izquierdo o Derecho usa solo ese ojo. La selección de pares siempre usa un solo ojo, incluso al reconstruir ambos."),
    PT("Escolha as imagens para importar, corresponder, reconstruir e treinar. Ambos mantém a cobertura estéreo; Esquerdo ou Direito usa só esse olho. A seleção de pares sempre usa um olho, mesmo reconstruindo ambos."),
    IT("Scegli le immagini da importare, abbinare, ricostruire e usare per l’addestramento. Entrambi mantiene la copertura stereo; Sinistro o Destro usa solo quell’occhio. La selezione delle coppie usa sempre un solo occhio, anche ricostruendoli entrambi."),
    NL("Kies camerabeelden voor import, matching, reconstructie en training. Beide behoudt stereodekking; Links of Rechts gebruikt alleen dat oog. Paarselectie gebruikt altijd één oog, ook bij reconstructie van beide."),
    RU("Выберите изображения для импорта, сопоставления, реконструкции и обучения. Оба сохраняет стереопокрытие; Левый или Правый использует только выбранную камеру. Отбор пар всегда использует один ракурс, даже при реконструкции обоих."),
    TR("İçe aktarma, eşleştirme, yeniden oluşturma ve eğitim için kamera görüntülerini seçin. İkisi stereo kapsamını korur; Sol veya Sağ yalnızca o gözü kullanır. İkisi yeniden oluşturulurken bile çift seçimi daima tek göz kullanır."));
SS_MSG(extracting_single,
    EN("Arcturus images: {0} / {1}"),
    JA("Arcturus 画像: {0} / {1}"),
    ZH_HANS("Arcturus 图像：{0} / {1}"),
    ZH_HANT("Arcturus 影像：{0} / {1}"),
    KO("Arcturus 이미지: {0} / {1}"),
    DE("Arcturus-Bilder: {0} / {1}"),
    FR("Images Arcturus : {0} / {1}"),
    ES("Imágenes Arcturus: {0} / {1}"),
    PT("Imagens Arcturus: {0} / {1}"),
    IT("Immagini Arcturus: {0} / {1}"),
    NL("Arcturus-beelden: {0} / {1}"),
    RU("Изображения Arcturus: {0} / {1}"),
    TR("Arcturus görüntüleri: {0} / {1}"));
SS_MSG(keyframe_selected_single,
    EN("Selected I-frame images: {1}"),
    JA("選択した I フレーム画像: {1}"),
    ZH_HANS("已选择 I 帧图像：{1}"),
    ZH_HANT("已選擇 I 影格影像：{1}"),
    KO("선택한 I 프레임 이미지: {1}"),
    DE("Ausgewählte I-Frame-Bilder: {1}"),
    FR("Images I sélectionnées : {1}"),
    ES("Imágenes I seleccionadas: {1}"),
    PT("Imagens I selecionadas: {1}"),
    IT("Immagini I selezionate: {1}"),
    NL("Geselecteerde I-framebeelden: {1}"),
    RU("Выбрано I-кадров: {1}"),
    TR("Seçilen I-kare görüntüleri: {1}"));
SS_MSG(images_estimate_key,
    EN("Up to {0} images (I-frames only)"),
    JA("最大 {0} 画像（I フレームのみ）"),
    ZH_HANS("最多 {0} 张图像（仅 I 帧）"),
    ZH_HANT("最多 {0} 張影像（僅 I 影格）"),
    KO("최대 {0}개 이미지(I 프레임만)"),
    DE("Bis zu {0} Bilder (nur I-Frames)"),
    FR("Jusqu’à {0} images (images I uniquement)"),
    ES("Hasta {0} imágenes (solo fotogramas I)"),
    PT("Até {0} imagens (somente quadros I)"),
    IT("Fino a {0} immagini (solo fotogrammi I)"),
    NL("Maximaal {0} beelden (alleen I-frames)"),
    RU("До {0} изображений (только I-кадры)"),
    TR("En fazla {0} görüntü (yalnızca I-kareler)"));
SS_MSG(tracking_selected,
    EN("Tracking shortlist: {0} image pairs, including {1} independent audit pairs"),
    JA("追跡候補: {0} 画像ペア（独立監査 {1} ペアを含む）"),
    ZH_HANS("跟踪候选：{0} 个像对，包括 {1} 个独立检查像对"),
    ZH_HANT("追蹤候選：{0} 個影像對，包含 {1} 個獨立檢查影像對"),
    KO("추적 후보: 이미지 쌍 {0}개, 독립 검사 쌍 {1}개 포함"),
    DE("Tracking-Auswahl: {0} Bildpaare, darunter {1} unabhängige Prüfpaare"),
    FR("Présélection du suivi : {0} paires, dont {1} paires de contrôle indépendantes"),
    ES("Preselección por seguimiento: {0} pares, incluidos {1} pares de control independientes"),
    PT("Pré-seleção por rastreamento: {0} pares, incluindo {1} pares de verificação independentes"),
    IT("Preselezione da tracking: {0} coppie, incluse {1} coppie di verifica indipendenti"),
    NL("Trackingselectie: {0} beeldparen, inclusief {1} onafhankelijke controleparen"),
    RU("Отбор по трекингу: {0} пар, включая {1} независимых проверочных пар"),
    TR("Takip seçimi: {1} bağımsız denetim çifti dahil {0} görüntü çifti"));
SS_MSG(tracking_expand,
    EN("Tracking selection did not pass quality checks; expanding to full visual search"),
    JA("追跡選択が品質検査を通過しませんでした。画像の全探索に拡張します"),
    ZH_HANS("跟踪选择未通过质量检查；扩展到完整视觉搜索"),
    ZH_HANT("追蹤選擇未通過品質檢查；擴展至完整視覺搜尋"),
    KO("추적 선택이 품질 검사를 통과하지 못해 전체 시각 검색으로 확장합니다"),
    DE("Tracking-Auswahl besteht die Qualitätsprüfung nicht; vollständige Bildsuche wird gestartet"),
    FR("La sélection du suivi échoue aux contrôles qualité ; extension à la recherche visuelle complète"),
    ES("La selección por seguimiento no superó los controles de calidad; se amplía a la búsqueda visual completa"),
    PT("A seleção por rastreamento não passou nas verificações de qualidade; ampliando para busca visual completa"),
    IT("La selezione da tracking non supera i controlli qualità; avvio della ricerca visiva completa"),
    NL("Trackingselectie voldoet niet aan kwaliteitscontroles; uitbreiding naar volledige visuele zoekactie"),
    RU("Отбор по трекингу не прошёл проверку качества; выполняется полный визуальный поиск"),
    TR("Takip seçimi kalite denetimini geçemedi; tam görsel aramaya genişletiliyor"));
SS_MSG(pairs_estimate,
    EN("About {0} stereo pairs → {1} images"),
    JA("約 {0} ステレオペア → {1} 画像"),
    ZH_HANS("约 {0} 个立体对 → {1} 张图像"),
    ZH_HANT("約 {0} 個立體對 → {1} 張影像"),
    KO("약 {0}개 스테레오 쌍 → 이미지 {1}개"),
    DE("Etwa {0} Stereopaare → {1} Bilder"),
    FR("Environ {0} paires stéréo → {1} images"),
    ES("Unos {0} pares estéreo → {1} imágenes"),
    PT("Cerca de {0} pares estéreo → {1} imagens"),
    IT("Circa {0} coppie stereo → {1} immagini"),
    NL("Ongeveer {0} stereoparen → {1} beelden"),
    RU("Около {0} стереопар → {1} изображений"),
    TR("Yaklaşık {0} stereo çift → {1} görüntü"));
SS_MSG(pairs_estimate_key,
    EN("Up to {0} stereo pairs → {1} images; limited by I-frames"),
    JA("最大 {0} ステレオペア → {1} 画像（I フレーム数で制限）"),
    ZH_HANS("最多 {0} 个立体对 → {1} 张图像；受 I 帧数量限制"),
    ZH_HANT("最多 {0} 個立體對 → {1} 張影像；受 I 影格數量限制"),
    KO("최대 {0}개 스테레오 쌍 → 이미지 {1}개; I 프레임 수로 제한"),
    DE("Bis zu {0} Stereopaare → {1} Bilder; durch I-Frames begrenzt"),
    FR("Jusqu’à {0} paires stéréo → {1} images ; selon les images I"),
    ES("Hasta {0} pares estéreo → {1} imágenes; limitado por fotogramas I"),
    PT("Até {0} pares estéreo → {1} imagens; limitado por quadros I"),
    IT("Fino a {0} coppie stereo → {1} immagini; limitato dai fotogrammi I"),
    NL("Tot {0} stereoparen → {1} beelden; beperkt door I-frames"),
    RU("До {0} стереопар → {1} изображений; ограничено I-кадрами"),
    TR("En fazla {0} stereo çift → {1} görüntü; I karelerle sınırlı"));
SS_MSG(preset,
    EN("Arcturus Vision"),
    JA("Arcturus Vision"),
    ZH_HANS("Arcturus Vision"),
    ZH_HANT("Arcturus Vision"),
    KO("Arcturus Vision"),
    DE("Arcturus Vision"),
    FR("Arcturus Vision"),
    ES("Arcturus Vision"),
    PT("Arcturus Vision"),
    IT("Arcturus Vision"),
    NL("Arcturus Vision"),
    RU("Arcturus Vision"),
    TR("Arcturus Vision"));
SS_MSG(preset_dataset_help,
    EN("Both eyes, I-frames only, a 130-degree mask, pose-assisted selection, and distortion locked to MP4 metadata."),
    JA("両眼、I フレームのみ、130 度のマスク、姿勢による選択、歪みをMP4メタデータに固定。"),
    ZH_HANS("双眼、仅 I 帧、130 度遮罩、位姿辅助选择，畸变锁定为MP4元数据中的值。"),
    ZH_HANT("雙眼、僅 I 影格、130 度遮罩、姿態輔助選擇，畸變鎖定為MP4中繼資料中的值。"),
    KO("양쪽 눈, I 프레임만, 130도 마스크, 포즈 기반 선택 및 MP4 메타데이터 값으로 왜곡 고정."),
    DE("Beide Augen, nur I-Frames, 130-Grad-Maske, posengestützte Auswahl und auf die MP4-Metadaten fixierte Verzerrung."),
    FR("Les deux yeux, images I uniquement, masque de 130 degrés, sélection assistée par les poses et distorsion verrouillée sur les métadonnées MP4."),
    ES("Ambos ojos, solo fotogramas I, máscara de 130 grados, selección asistida por poses y distorsión fijada a los metadatos MP4."),
    PT("Ambos os olhos, apenas quadros I, máscara de 130 graus, seleção assistida por poses e distorção fixada nos metadados MP4."),
    IT("Entrambi gli occhi, solo fotogrammi I, maschera di 130 gradi, selezione assistita dalle pose e distorsione bloccata sui metadati MP4."),
    NL("Beide ogen, alleen I-frames, masker van 130 graden, posegestuurde selectie en vervorming vastgezet op de MP4-metadata."),
    RU("Оба глаза, только I-кадры, маска 130 градусов, выбор с учётом поз и искажение, зафиксированное по метаданным MP4."),
    TR("Her iki göz, yalnızca I kareleri, 130 derecelik maske, poz destekli seçim ve MP4 meta verilerine sabitlenmiş distorsiyon."));
SS_MSG(preset_train_help,
    EN("Sets SH0 (color does not vary with viewing direction), a 1.5 million Gaussian limit, and half image width and height."),
    JA("SH0（視線方向によって色を変えない）、ガウス数上限150万、画像の幅と高さを半分に設定します。"),
    ZH_HANS("设置为SH0（颜色不随观察方向变化）、150万个高斯上限及图像宽高减半。"),
    ZH_HANT("設定為SH0（顏色不隨觀察方向改變）、150萬個高斯上限及影像寬高減半。"),
    KO("SH0(시선 방향에 따라 색상이 변하지 않음), 가우시안 한도 150만, 이미지 너비와 높이를 절반으로 설정합니다."),
    DE("Setzt SH0 (Farbe unabhängig von der Blickrichtung), maximal 1,5 Millionen Gauß-Punkte und halbe Bildbreite und -höhe."),
    FR("Définit SH0 (couleur indépendante de la direction de vue), une limite de 1,5 million de gaussiennes et une largeur et une hauteur divisées par deux."),
    ES("Establece SH0 (color independiente de la dirección de vista), un límite de 1,5 millones de gaussianas y ancho y alto a la mitad."),
    PT("Define SH0 (cor independente da direção de visualização), limite de 1,5 milhão de gaussianas e largura e altura pela metade."),
    IT("Imposta SH0 (colore indipendente dalla direzione di vista), un limite di 1,5 milioni di gaussiane e larghezza e altezza dimezzate."),
    NL("Stelt SH0 in (kleur onafhankelijk van de kijkrichting), maximaal 1,5 miljoen Gaussianen en halve beeldbreedte en -hoogte."),
    RU("Задаёт SH0 (цвет не зависит от направления взгляда), лимит 1,5 миллиона гауссиан и половину ширины и высоты изображений."),
    TR("SH0 (renk bakış yönüne göre değişmez), 1,5 milyon Gaussian sınırı ve yarı görüntü genişliği ve yüksekliği ayarlar."));
SS_MSG(keyframes,
    EN("Only use I-frames"),
    JA("I フレームのみ使用"),
    ZH_HANS("仅使用 I 帧"),
    ZH_HANT("僅使用 I 影格"),
    KO("I 프레임만 사용"),
    DE("Nur I-Frames verwenden"),
    FR("Utiliser uniquement les images I"),
    ES("Usar solo fotogramas I"),
    PT("Usar apenas quadros I"),
    IT("Usa solo fotogrammi I"),
    NL("Alleen I-frames gebruiken"),
    RU("Использовать только I-кадры"),
    TR("Yalnızca I karelerini kullan"));
SS_MSG(keyframes_help,
    EN("For Arcturus recordings, select paired codec-marked I-keyframes with tracking poses. FPS limits their sampling rate; the maximum count applies to stereo pairs. Both eyes are kept. Adaptive spacing and sharpness do not override this sampling. Ordinary videos keep their usual sampling."),
    JA("Arcturus 録画では、追跡姿勢付きの同期 I キーフレームを選びます。FPS は抽出頻度、最大数はステレオペア数を制限します。両眼を保持します。適応間隔と鮮明度は適用しません。通常の動画は従来どおりです。"),
    ZH_HANS("Arcturus 录像选择带跟踪位姿的成对编码 I 关键帧。FPS 限制采样率，最大数量限制立体对数。保留双目，不使用自适应间隔或清晰度覆盖采样。普通视频保持原有采样。"),
    ZH_HANT("Arcturus 錄影選取帶追蹤姿態的成對編碼 I 關鍵影格。FPS 限制取樣率，最大數量限制立體對數。保留雙目，不使用自適應間隔或清晰度覆寫取樣。一般影片維持原有取樣。"),
    KO("Arcturus 녹화에서 추적 포즈가 있는 동기화된 코덱 I 키프레임을 선택합니다. FPS는 샘플링 속도, 최대 개수는 스테레오 쌍을 제한합니다. 양쪽 눈을 유지하며 적응 간격과 선명도는 적용하지 않습니다. 일반 영상은 기존 샘플링을 유지합니다."),
    DE("Für Arcturus-Aufnahmen gepaarte Codec-I-Keyframes mit Tracking-Posen wählen. FPS begrenzt die Abtastrate, die Höchstzahl zählt Stereopaare. Beide Augen bleiben erhalten. Adaptiver Abstand und Schärfe ändern dies nicht. Normale Videos behalten ihre Abtastung."),
    FR("Pour Arcturus, sélectionner les images clés I appariées du codec avec poses de suivi. FPS limite leur fréquence ; le maximum compte les paires stéréo. Les deux yeux sont conservés. Espacement adaptatif et netteté ne modifient pas cet échantillonnage. Les vidéos ordinaires restent inchangées."),
    ES("En grabaciones Arcturus, seleccionar fotogramas clave I del códec emparejados con poses de seguimiento. FPS limita la frecuencia; el máximo cuenta pares estéreo. Se conservan ambos ojos. El espaciado adaptativo y la nitidez no alteran este muestreo. Los vídeos normales mantienen su muestreo."),
    PT("Em gravações Arcturus, selecionar quadros-chave I do codec emparelhados com poses de rastreamento. FPS limita a frequência; o máximo conta pares estéreo. Ambos os olhos são mantidos. Espaçamento adaptativo e nitidez não alteram a amostragem. Vídeos comuns mantêm sua amostragem."),
    IT("Per Arcturus, seleziona fotogrammi chiave I del codec abbinati con pose di tracciamento. FPS limita la frequenza; il massimo conta le coppie stereo. Entrambi gli occhi restano. Spaziatura adattiva e nitidezza non cambiano il campionamento. I video normali mantengono il loro campionamento."),
    NL("Kies voor Arcturus gekoppelde I-sleutelframes van de codec met trackingposes. FPS begrenst de snelheid; het maximum telt stereoparen. Beide ogen blijven behouden. Adaptieve afstand en scherpte veranderen deze selectie niet. Gewone video behoudt de normale selectie."),
    RU("Для записей Arcturus выбираются парные ключевые I-кадры кодека с позами трекинга. FPS ограничивает частоту, максимум задаёт число стереопар. Оба ракурса сохраняются. Адаптивный интервал и резкость не меняют выборку. Для обычного видео выборка прежняя."),
    TR("Arcturus kayıtlarında izleme pozları bulunan eşlenmiş kodek I anahtar kareleri seçilir. FPS örnekleme hızını, üst sınır stereo çift sayısını belirler. İki göz korunur. Uyarlamalı aralık ve keskinlik bu seçimi değiştirmez. Normal videolar olağan örneklemeyi kullanır."));
SS_MSG_EN(keyframe_scan, "Finding recorded stereo keyframes...");
SS_MSG(keyframe_selected,
    EN("Stereo pairs: {0} → images: {1} (available keyframes: {2} / {3})"),
    JA("ステレオペア: {0} → 画像: {1}（利用可能なキーフレーム: {2} / {3}）"),
    ZH_HANS("立体对：{0} → 图像：{1}（可用关键帧：{2} / {3}）"),
    ZH_HANT("立體對：{0} → 影像：{1}（可用關鍵影格：{2} / {3}）"),
    KO("스테레오 쌍: {0} → 이미지: {1} (사용 가능한 키프레임: {2} / {3})"),
    DE("Stereopaare: {0} → Bilder: {1} (verfügbare Keyframes: {2} / {3})"),
    FR("Paires stéréo : {0} → images : {1} (images clés disponibles : {2} / {3})"),
    ES("Pares estéreo: {0} → imágenes: {1} (fotogramas clave disponibles: {2} / {3})"),
    PT("Pares estéreo: {0} → imagens: {1} (quadros-chave disponíveis: {2} / {3})"),
    IT("Coppie stereo: {0} → immagini: {1} (fotogrammi chiave disponibili: {2} / {3})"),
    NL("Stereoparen: {0} → beelden: {1} (beschikbare sleutelframes: {2} / {3})"),
    RU("Стереопары: {0} → изображения: {1} (доступные ключевые кадры: {2} / {3})"),
    TR("Stereo çift: {0} → görüntü: {1} (mevcut anahtar kareler: {2} / {3})"));
SS_MSG_EN(keyframe_scan_failed, "Could not read video keyframes with FFmpeg");
SS_MSG(keyframe_rate,
    EN("Invalid keyframe sampling rate"),
    JA("キーフレームの抽出頻度が無効です"),
    ZH_HANS("关键帧采样率无效"),
    ZH_HANT("關鍵影格取樣率無效"),
    KO("잘못된 키프레임 샘플링 속도"),
    DE("Ungültige Keyframe-Abtastrate"),
    FR("Fréquence des images clés invalide"),
    ES("Frecuencia de muestreo de fotogramas clave no válida"),
    PT("Taxa de amostragem de quadros-chave inválida"),
    IT("Frequenza dei fotogrammi chiave non valida"),
    NL("Ongeldige bemonsteringsfrequentie voor sleutelframes"),
    RU("Недопустимая частота ключевых кадров"),
    TR("Geçersiz anahtar kare örnekleme hızı"));
SS_MSG_EN(keyframe_times, "Keyframe timestamps are invalid or not increasing");
SS_MSG_EN(keyframe_pose, "A stereo keyframe has no matching tracking pose");
SS_MSG(keyframe_count,
    EN("At least three stereo keyframe pairs are required; increase FPS or the maximum count"),
    JA("ステレオキーフレームが 3 ペア以上必要です。FPS または最大数を増やしてください"),
    ZH_HANS("至少需要三个立体关键帧对；请提高 FPS 或最大数量"),
    ZH_HANT("至少需要三個立體關鍵影格對；請提高 FPS 或最大數量"),
    KO("스테레오 키프레임 쌍이 3개 이상 필요합니다. FPS 또는 최대 개수를 높이세요"),
    DE("Mindestens drei Stereo-Keyframe-Paare nötig; FPS oder Höchstzahl erhöhen"),
    FR("Au moins trois paires clés stéréo sont requises ; augmentez FPS ou le maximum"),
    ES("Se requieren al menos tres pares clave estéreo; aumente FPS o el máximo"),
    PT("São necessários pelo menos três pares-chave estéreo; aumente FPS ou o máximo"),
    IT("Servono almeno tre coppie chiave stereo; aumenta FPS o il massimo"),
    NL("Minstens drie stereo-sleutelframeparen nodig; verhoog FPS of het maximum"),
    RU("Нужно не менее трёх стереопар ключевых кадров; увеличьте FPS или максимум"),
    TR("En az üç stereo anahtar kare çifti gerekir; FPS veya üst sınırı artırın"));
SS_MSG_EN(keyframe_decode, "Decoded image is not the requested keyframe");
SS_MSG_EN(polar_grid, "Unsupported KBPolarSpline grid; expected 5 by 5");
SS_MSG_EN(polar_scale, "Invalid KBPolarSpline scale");
SS_MSG_EN(polar_coefficients, "Invalid KBPolarSpline coefficient count");
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
          "Arcturus camera has no supported KB4 or KBPolarSpline calibration");
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
          "Uses embedded KBPolarSpline or KB4 calibration, synchronized timestamps and metric "
          "tracking. Frame rate controls sampling; lens and sharpness settings are ignored. Select Built-in "
          "reconstruction and import one recording per dataset.");
SS_MSG(recorded_lens, EN("{0} - From ArcVisCam"), JA("{0} - ArcVisCamから"),
       ZH_HANS("{0} - 来自 ArcVisCam"), ZH_HANT("{0} - 來自 ArcVisCam"),
       KO("{0} - ArcVisCam에서"), DE("{0} - Von ArcVisCam"), FR("{0} - Depuis ArcVisCam"),
       ES("{0} - De ArcVisCam"), PT("{0} - Da ArcVisCam"), IT("{0} - Da ArcVisCam"),
       NL("{0} - Uit ArcVisCam"), RU("{0} - Из ArcVisCam"), TR("{0} - ArcVisCam’den"));
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
SS_MSG(extracting,
    EN("Stereo pairs: {0} / {1}; images: {2} / {3}"),
    JA("ステレオペア: {0} / {1}；画像: {2} / {3}"),
    ZH_HANS("立体对：{0} / {1}；图像：{2} / {3}"),
    ZH_HANT("立體對：{0} / {1}；影像：{2} / {3}"),
    KO("스테레오 쌍: {0} / {1}; 이미지: {2} / {3}"),
    DE("Stereopaare: {0} / {1}; Bilder: {2} / {3}"),
    FR("Paires stéréo : {0} / {1} ; images : {2} / {3}"),
    ES("Pares estéreo: {0} / {1}; imágenes: {2} / {3}"),
    PT("Pares estéreo: {0} / {1}; imagens: {2} / {3}"),
    IT("Coppie stereo: {0} / {1}; immagini: {2} / {3}"),
    NL("Stereoparen: {0} / {1}; beelden: {2} / {3}"),
    RU("Стереопары: {0} / {1}; изображения: {2} / {3}"),
    TR("Stereo çift: {0} / {1}; görüntü: {2} / {3}"));
} // namespace arcturus
} // namespace msg
} // namespace i18n
} // namespace spirula
#include "i18n/EndCatalog.h"
