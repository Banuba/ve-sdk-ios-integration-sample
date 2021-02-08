import UIKit
import BanubaVideoEditorSDK
import BanubaMusicEditorSDK
import BanubaOverlayEditorSDK
import VideoEditor
import AVFoundation
import AVKit

class ViewController: UIViewController {
  
  private var videoEditorSDK: BanubaVideoEditor?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initVideoEditor()
  }
  
  private func initVideoEditor() {
    let config = createVideoEditorConfiguration()
    
    let viewControllerFactory = ViewControllerFactory()
    let musicEditorViewControllerFactory = MusicEditorViewControllerFactory()
    viewControllerFactory.musicEditorFactory = musicEditorViewControllerFactory
    viewControllerFactory.countdownTimerViewFactory = CountdownTimerViewControllerFactory()
    viewControllerFactory.exposureViewFactory = DefaultExposureViewFactory()
    
    videoEditorSDK = BanubaVideoEditor(
      token: "PUT VIDEO EDITOR TOKEN",
      effectsToken: "u4fwA4rVK2P/nkHS/tKE7SxK7fK+1u0DuoAruXXgIJhuSI0aynki+8gGXUWAC1H3jBDYThexzTBxlPc0eq2x2mdwR/F+iL2gmVpXrC4mAXiEByjb5VpSqsJzbM/K9LGnEDByWZVRTzq8ZuvwKR7BCKU3f4Z7",
      cloudMasksToken: "PUT AR CLOUD ID",
      configuration: config,
      analytics: Analytics(),
      externalViewControllerFactory: viewControllerFactory
    )
    
    musicEditorViewControllerFactory.videoEditorSDK = videoEditorSDK
    videoEditorSDK?.delegate = self
  }
  
  @IBAction func openVideoEditorAction(_ sender: Any) {
    let musicURL = Bundle.main.bundleURL
      .appendingPathComponent("Music/long", isDirectory: true)
      .appendingPathComponent("long_music_2.wav")
    let assset = AVURLAsset(url: musicURL)
    let musicTrackPreset = MediaTrack(
      id: CMPersistentTrackID.random(in: 6..<CMPersistentTrackID.max),
      url: musicURL,
      timeRange: MediaTrackTimeRange(
        startTime: .zero,
        playingTimeRange: CMTimeRange(
          start: .zero,
          duration: assset.duration
        )
      ),
      title: "My awesome track"
    )
    // Paste a music track as a track preset at the camera screen to record video with music
    videoEditorSDK?.presentVideoEditor(
      from: self,
      animated: true,
      musicTrack: nil,
      completion: nil
    )
  }
  
  private func createVideoEditorConfiguration() -> VideoEditorConfig {
    var config = VideoEditorConfig()
    
    var featureConfiguration = config.featureConfiguration
    featureConfiguration.isAudioBrowserEnabled = true
    config.updateFeatureConfiguration(featureConfiguration: featureConfiguration)
    
    config.isHandfreeEnabled = true
    config.recorderConfiguration = updateRecorderConfiguration(config.recorderConfiguration)
    config.editorConfiguration = updateEditorConfiguration(config.editorConfiguration)
    config.galleryConfiguration = updateGalleryConfiguration(config.galleryConfiguration)
    config.combinedGalleryConfiguration = updateCombinedGalleryConfiguration(config.combinedGalleryConfiguration)
    config.videoCoverSelectionConfiguration = updateVideCoverSelectionConfiguration(config.videoCoverSelectionConfiguration)
    config.musicEditorConfiguration = updateMusicEditorConfigurtion(config.musicEditorConfiguration)
    config.overlayEditorConfiguration = updateOverlayEditorConfiguraiton(config.overlayEditorConfiguration)
    config.textEditorConfiguration = updateTextEditorConfiguration(config.textEditorConfiguration)
    config.speedSelectionConfiguration = updateSpeedSelectionConfiguration(config.speedSelectionConfiguration)
    config.trimGalleryVideoConfiguration = updateTrimGalleryVideoConfiguration(config.trimGalleryVideoConfiguration)
    config.multiTrimConfiguration = updateMultiTrimConfiguration(config.multiTrimConfiguration)
    config.singleTrimConfiguration = updateSingleTrimConfiguration(config.singleTrimConfiguration)
    config.filterConfiguration = updateFilterConfiguration(config.filterConfiguration)
    config.alertViewConfiguration = updateAlertConfiguration(config.alertViewConfiguration)
    config.fullScreenActivityConfiguration = updateFullScreenActivityConfiguration(config.fullScreenActivityConfiguration)
    
    return config
  }
  
  private func updateRecorderConfiguration(_ configuration: RecorderConfiguration) -> RecorderConfiguration {
    var configuration = configuration
    
    configuration.backButton = BackButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_nav_close"))
    configuration.removeButtonImageName = "delete_videopart"
    configuration.additionalEffectsButtons = [
      AdditionalEffectsButtonConfiguration(
        identifier: .beauty,
        imageConfiguration: ImageConfiguration(imageName: "ic_beauty_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_beauty_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .sound,
        imageConfiguration: ImageConfiguration(imageName: "ic_audio_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_audio_on"),
        position: .bottom
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .effects,
        imageConfiguration: ImageConfiguration(imageName: "ic_filters_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_filters_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .masks,
        imageConfiguration: ImageConfiguration(imageName: "ic_masks_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_masks_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .toggle,
        imageConfiguration: ImageConfiguration(imageName: "ic_cam_front"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_cam_back_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .flashlight,
        imageConfiguration: ImageConfiguration(imageName: "ic_flash_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_flash_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .timer,
        imageConfiguration: ImageConfiguration(imageName: "ic_timer_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_timer_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .speed,
        imageConfiguration: ImageConfiguration(imageName: "ic_speed_1x"),
        selectedImageConfiguration: nil
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .muteSound,
        imageConfiguration: ImageConfiguration(imageName: "ic_mic_on"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_mic_off")
      ),
    ]
    
    configuration.speedButton = SpeedButtonConfiguration(
      imageNameHalf: "ic_speed_0.5x",
      imageNameNormal: "ic_speed_1x",
      imageNameDouble: "ic_speed_2x",
      imageNameTriple: "ic_speed_3x"
    )
    
    configuration.timerConfiguration.defaultButton = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_timer_off"))
    configuration.timerConfiguration.options = [
      TimerConfiguration.TimerOptionConfiguration(
        button: ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_timer_on")),
        startingTimerSeconds: 3,
        stoppingTimerSeconds: 0
      )
    ]
    configuration.recordButtonConfiguration.normalImageName = "ic_record_normal"
    configuration.recordButtonConfiguration.recordImageName = "ic_record_stop"
    configuration.recordButtonConfiguration.idleStrokeColor = UIColor.white.cgColor
    configuration.recordButtonConfiguration.strokeColor = UIColor(red: 6, green: 188, blue: 193).cgColor
    
    configuration.timeLineConfiguration.progressBarColor = UIColor(red: 6, green: 188, blue: 193)
    configuration.timeLineConfiguration.progressBarSelectColor = UIColor.white

    let nextButtonTextConfiguration = TextConfiguration(
      kern: 1.0,
      font: UIFont.systemFont(ofSize: 12.0),
      color: UIColor.white
    )
    let inactiveNextButtonTextConfiguration = TextConfiguration(
      kern: 1.0,
      font: UIFont.systemFont(ofSize: 12.0),
      color: UIColor.white.withAlphaComponent(0.5)
    )
    configuration.saveButton = SaveButtonConfiguration(
      textConfiguration: nextButtonTextConfiguration,
      inactiveTextConfiguration: inactiveNextButtonTextConfiguration,
      text: "NEXT",
      width: 68.0,
      height: 41.0,
      cornerRadius: 4.0,
      backgroundColor: UIColor(red: 6, green: 188, blue: 193),
      inactiveBackgroundColor: UIColor(red: 6, green: 188, blue: 193).withAlphaComponent(0.5)
    )
    
    return configuration
  }
  
  private func updateEditorConfiguration(_ configuration: EditorConfiguration) -> EditorConfiguration {
    var configuration = configuration
    
    configuration.additionalEffectsButtons = [
      AdditionalEffectsButtonConfiguration(
        identifier: .sticker,
        imageConfiguration: ImageConfiguration(imageName: "ic_stickers_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_stickers_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .text,
        imageConfiguration: ImageConfiguration(imageName: "ic_text_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_text_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .effects,
        imageConfiguration: ImageConfiguration(imageName: "ic_effects_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_effects_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .masks,
        imageConfiguration: ImageConfiguration(imageName: "ic_masks_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_masks_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .sound,
        imageConfiguration: ImageConfiguration(imageName: "ic_audio_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_audio_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .time,
        imageConfiguration: ImageConfiguration(imageName: "ic_speed_effects_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_speed_effects_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .color,
        imageConfiguration: ImageConfiguration(imageName: "ic_filters_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_filters_on")
      )
    ]
    
    configuration.backButton = BackButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_nav_back_arrow"))
    
    configuration.saveButton.background.color = UIColor(red: 6, green: 188, blue: 193)
    configuration.saveButton.background.cornerRadius = 4.0
    configuration.saveButton.width = 68.0
    configuration.saveButton.height = 42.0
    configuration.saveButton.title.style.color = .white
    
    return configuration
  }
  
  private func updateCombinedGalleryConfiguration(_ configuration: CombinedGalleryConfiguration) -> CombinedGalleryConfiguration {
    var configuration = configuration
    
    configuration.clearSelectionButtonConfiguration = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "cancel_cross"))
    configuration.closeButtonConfiguration = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "back_arrow"))
    
    configuration.nextButtonConfiguration.backgroundColor = .clear
    configuration.nextButtonConfiguration.textConfiguration.color = UIColor(red: 6, green: 188, blue: 193)
    
    configuration.galleryItemConfiguration.orderNumberBackgroudColor = UIColor(red: 6, green: 188, blue: 193)
    configuration.galleryItemConfiguration.orderNumberTitleColor = .white
    
    return configuration
  }
  
  private func updateGalleryConfiguration(_ configuration: GalleryConfiguration) -> GalleryConfiguration {
    var configuration = configuration
    
    configuration.multiselectButtonConfiguration = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "multi_choise"))
    configuration.cancelMultiselectButtonConfiguration = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "cancel_cross"))
    configuration.backButtonConfiguration = BackButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "back_arrow"))
    
    configuration.chooseSelectionButtonConfiguration.backgroundColor = .clear
    configuration.chooseSelectionButtonConfiguration.textConfiguration.color = UIColor(red: 6, green: 188, blue: 193)
    
    configuration.galleryItemConfiguration.orderNumberBackgroudColor = UIColor(red: 6, green: 188, blue: 193)
    configuration.galleryItemConfiguration.orderNumberTitleColor = .white
    
    return configuration
  }
  
  private func updateVideCoverSelectionConfiguration(_ configuration: SimpleVideoCoverSelectionConfiguration) -> SimpleVideoCoverSelectionConfiguration {
    var configuration = configuration
    
    configuration.cancelButton = TextButtonConfiguration(
      style: TextConfiguration(
        font: UIFont.boldSystemFont(ofSize: 18.0),
        color: UIColor(red: 6, green: 188, blue: 193)
      ),
      text: "Cancel"
    )
    configuration.doneButton = RoundedButtonConfiguration(
      textConfiguration: TextConfiguration(
        font: UIFont.boldSystemFont(ofSize: 18.0),
        color: UIColor(red: 6, green: 188, blue: 193)
      ),
      cornerRadius: 0.0,
      backgroundColor: .clear
    )
    configuration.sliderColor = UIColor(red: 6, green: 188, blue: 193)
    configuration.sliderMinTrackTintColor = UIColor(red: 6, green: 188, blue: 193)
    configuration.toolTipLabel = TextConfiguration(
      kern: 0.0,
      font: UIFont.systemFont(ofSize: 16.0),
      color: .white,
      alignment: .left
    )
    
    return configuration
  }
  
  private func updateMusicEditorConfigurtion(_ configuration: MusicEditorConfig) -> MusicEditorConfig {
    var configuration = configuration
    
    configuration.mainMusicViewControllerConfig = updateMainMusicViewControllerConfig(configuration.mainMusicViewControllerConfig)
    configuration.audioRecorderViewControllerConfig = updateAudioRecorderViewControllerConfig(configuration.audioRecorderViewControllerConfig)
    configuration.audioTrackLineEditControllerConfig = updateAudioTrackLineEditControllerConfig(configuration.audioTrackLineEditControllerConfig)
    configuration.videoTrackLineEditControllerConfig = updateVideoTrackLineEditControllerConfig(configuration.videoTrackLineEditControllerConfig)
    
    return configuration
  }
  
  private func updateMainMusicViewControllerConfig(_ configuration: MainMusicViewControllerConfig) -> MainMusicViewControllerConfig {
    var configuration = configuration
    
    configuration.editButtons = [
      EditButtonConfig(
        font: UIFont.systemFont(ofSize: 14.0),
        type: .track,
        title: "Tracks",
        titleColor: .white,
        imageName: "ic_tracks"
      ),
      EditButtonConfig(
        font: UIFont.systemFont(ofSize: 14.0),
        type: .effect,
        title: "Effects",
        titleColor: .white,
        imageName: "ic_effects"
      ),
      EditButtonConfig(
        font: UIFont.systemFont(ofSize: 14.0),
        type: .record,
        title: "Recording",
        titleColor: .white,
        imageName: "ic_voice_recording"
      )
    ]
    
    configuration.editCompositionButtons = [
      EditCompositionButtonConfig(
        font: UIFont.systemFont(ofSize: 14.0),
        type: .edit,
        title: "Edit",
        titleColor: .white,
        imageName: "ic_edit",
        selectedImageName: nil
      ),
      EditCompositionButtonConfig(
        font: UIFont.systemFont(ofSize: 14.0),
        type: .delete,
        title: "Delete",
        titleColor: .white,
        imageName: "ic_trash",
        selectedImageName: nil
      )
    ]
    
    configuration.controlButtons = [
      ControlButtonConfig(
        type: .reset,
        imageName: "ic_restart",
        selectedImageName: nil
      ),
      ControlButtonConfig(
        type: .play,
        imageName: "ic_editor_play",
        selectedImageName: "ic_pause"
      ),
      ControlButtonConfig(
        type: .done,
        imageName: "ic_done",
        selectedImageName: nil
      )
    ]
    
    return configuration
  }
  
  private func updateAudioRecorderViewControllerConfig(_ configuration: AudioRecorderViewControllerConfig) -> AudioRecorderViewControllerConfig {
    var configuration = configuration
    
    configuration.playPauseButton = ControlButtonConfig(
      type: .play,
      imageName: "ic_play",
      selectedImageName: "ic_pause"
    )
    
    configuration.recordButton = ControlButtonConfig(
      type: .play,
      imageName: "ic_start_recording",
      selectedImageName: "ic_pause_recording"
    )
    configuration.timerColor = .white
    configuration.backButtonImage = "ic_close"
    configuration.dimViewColor = UIColor(red: 6, green: 188, blue: 193).withAlphaComponent(0.6)
    
    configuration.rewindToStartButton = ControlButtonConfig(
      type: .reset,
      imageName: "ic_restart",
      selectedImageName: nil
    )
    configuration.doneButtonImage = "ic_done"
    
    return configuration
  }
  
  private func updateAudioTrackLineEditControllerConfig(_ configuration: AudioTrackLineEditViewControllerConfig) -> AudioTrackLineEditViewControllerConfig {
    var configuration = configuration
    
    configuration.doneButtonImageName = "ic_done"
    configuration.draggersColor = UIColor(red: 250, green: 62, blue: 118)
    configuration.draggersLineColor = UIColor(red: 250, green: 62, blue: 118)
    configuration.sliderTintColor = UIColor(red: 6, green: 188, blue: 193)
    
    return configuration
  }
  
  private func updateVideoTrackLineEditControllerConfig(_ configuration: VideoTrackLineEditViewControllerConfig) -> VideoTrackLineEditViewControllerConfig {
    var configuration = configuration
    
    configuration.doneButtonImageName = "ic_done"
    configuration.sliderTintColor = UIColor(red: 6, green: 188, blue: 193)
    configuration.mainLabelColors = UIColor(red: 6, green: 188, blue: 193)
    
    return configuration
  }
  
  private func updateOverlayEditorConfiguraiton(_ configuration: OverlayEditorConfiguration) -> OverlayEditorConfiguration {
    var configuration = configuration
    
    configuration.mainOverlayViewControllerConfig.controlButtons = [
      OverlayControlButtonConfig(
        type: .reset,
        imageName: "ic_restart",
        selectedImageName: nil
      ),
      OverlayControlButtonConfig(
        type: .play,
        imageName: "ic_editor_play",
        selectedImageName: "ic_pause"
      ),
      OverlayControlButtonConfig(
        type: .done,
        imageName: "ic_done",
        selectedImageName: nil
      )
    ]
    
    configuration.mainOverlayViewControllerConfig.addButtons = [
      OverlayAddButtonConfig(
        type: .text,
        title: "Text",
        titleColor: .white,
        font: UIFont.systemFont(ofSize: 14.0),
        imageName: "ic_AddText"
      ),
      OverlayAddButtonConfig(
        type: .sticker,
        title: "Sticker",
        titleColor: .white,
        font: UIFont.systemFont(ofSize: 14.0),
        imageName: "ic_AddSticker"
      )
    ]
    
    configuration.mainOverlayViewControllerConfig.editCompositionButtons = [
      OverlayEditButtonConfig(
        type: .edit,
        title: "Edit",
        titleColor: .white,
        font: UIFont.systemFont(ofSize: 14.0),
        imageName: "ic_edit",
        selectedImageName: nil
      ),
      OverlayEditButtonConfig(
        type: .delete,
        title: "Delete",
        titleColor: .white,
        font: UIFont.systemFont(ofSize: 14.0),
        imageName: "ic_trash",
        selectedImageName: nil
      )
    ]
    
    configuration.mainOverlayViewControllerConfig.resizeImageName = "ic_cut_arrow"
    configuration.mainOverlayViewControllerConfig.draggerBackgroundColor = .clear
    configuration.mainOverlayViewControllerConfig.draggersHorizontalInset = 10.0
    configuration.mainOverlayViewControllerConfig.draggersHeight = 20.0
    
    return configuration
  }
  
  private func updateTextEditorConfiguration(_ configuration: TextEditorConfiguration) -> TextEditorConfiguration {
    var configuration = configuration
    
    configuration.alignmentImages = [
      .left: ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_text_align_left")),
      .center: ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_text_align_center")),
      .right: ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_text_align_right"))
    ]
    configuration.textBackgroundButton = ImageButtonConfiguration(
      imageConfiguration: ImageConfiguration(imageName: "ic_text_without_background"),
      selectedImageConfiguration: ImageConfiguration(imageName: "ic_text_with_background")
    )
    configuration.doneButton.textConfiguration.color = UIColor(red: 6, green: 188, blue: 193)
    configuration.fontButton.borderColor = UIColor(red: 6, green: 188, blue: 193).cgColor
    configuration.fontButton.textConfiguration.color = UIColor(red: 6, green: 188, blue: 193)
    
    return configuration
  }
  
  private func updateSpeedSelectionConfiguration(_ configuration: SpeedSelectionConfiguration) -> SpeedSelectionConfiguration {
    var configuration = configuration
    
    configuration.backButton = BackButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "back_arrow"))
    configuration.speedBarConfiguration.speedItemBackgroundColor = UIColor(red: 18, green: 38, blue: 58)
    configuration.speedBarConfiguration.selectorColor = UIColor(red: 6, green: 188, blue: 193)
    configuration.speedBarConfiguration.selectorTextColor = UIColor.white
    
    return configuration
  }
  
  private func updateTrimGalleryVideoConfiguration(_ configuration: TrimGalleryVideoConfiguration) -> TrimGalleryVideoConfiguration {
    var configuration = configuration
    
    configuration.backButtonConfiguration = BackButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "back_arrow"))
    configuration.playerControlConfiguration = PlayerControlConfiguration(
      playButtonImageName: "ic_play",
      pauseButtonImageName: "ic_trim_pause"
    )
    
    configuration.galleryVideoPartsConfiguration.addGalleryVideoPartImageName = "add_video_part"
    configuration.deleteGalleryVideoPartButtonConfiguration = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_delete_video_part"))
    
    configuration.nextButtonConfiguration.backgroundColor = .clear
    configuration.nextButtonConfiguration.textConfiguration.color = UIColor(red: 6, green: 188, blue: 193)
    
    configuration.editedTimeLabelConfiguration.errorColor = UIColor(red: 250, green: 62, blue: 118)
    
    return configuration
  }
  
  private func updateMultiTrimConfiguration(_ configuration: MultiTrimConfiguration) -> MultiTrimConfiguration {
    var configuration = configuration
    
    configuration.backButton = BackButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "back_arrow"))
    configuration.playerControlConfiguration = PlayerControlConfiguration(
      playButtonImageName: "ic_play",
      pauseButtonImageName: "ic_trim_pause"
    )
    
    configuration.trimTimeLineConfiguration.draggerImageName = "trim_left"
    configuration.trimTimeLineConfiguration.doneButtonConfiguration.style.color = UIColor(red: 6, green: 188, blue: 193)
    configuration.trimTimeLineConfiguration.trimControlsColor = UIColor(red: 250, green: 62, blue: 118)
    
    configuration.saveButton.backgroundColor = .clear
    configuration.saveButton.textConfiguration.color = UIColor(red: 6, green: 188, blue: 193)
    
    configuration.editedTimeLabelConfiguration.errorColor = UIColor(red: 250, green: 62, blue: 118)
    
    return configuration
  }
  
  private func updateSingleTrimConfiguration(_ configuration: SingleTrimConfiguration) -> SingleTrimConfiguration {
    var configuration = configuration
    
    configuration.playerControlConfiguration = PlayerControlConfiguration(
      playButtonImageName: "ic_play",
      pauseButtonImageName: "ic_trim_pause"
    )
    configuration.backButton = BackButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "back_arrow"))
    
    configuration.trimTimeLineConfiguration.draggerImageName = "trim_left"
    configuration.trimTimeLineConfiguration.trimControlsColor = UIColor(red: 250, green: 62, blue: 118)
    
    configuration.saveButton.backgroundColor = .clear
    configuration.saveButton.textConfiguration.color = UIColor(red: 6, green: 188, blue: 193)
    
    configuration.editedTimeLabelConfiguration.errorColor = UIColor(red: 250, green: 62, blue: 118)
    
    return configuration
  }
  
  private func updateFilterConfiguration(_ configuration: FilterConfiguration) -> FilterConfiguration {
    var configuration = configuration
    
    configuration.resetButton.backgroundColor = UIColor(red: 6, green: 188, blue: 193)
    configuration.resetButton.cornerRadius = 4.0
    configuration.resetButton.textConfiguration.color = .white
    configuration.toolTipLabel.color = .white
    configuration.cursorButton = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_cursor"))
  
    configuration.effectItemConfiguration.cornerRadius = 4.0
    
    return configuration
  }
  
  private func updateAlertConfiguration(_ configuration: AlertViewConfiguration) -> AlertViewConfiguration {
    var configuration = configuration
    
    configuration.refuseButtonBackgroundColor = UIColor(red: 6, green: 188, blue: 193)
    configuration.refuseButtonTextColor = UIColor.white
    
    return configuration
  }
  
  private func updateFullScreenActivityConfiguration(_ configuration: FullScreenActivityConfiguration) -> FullScreenActivityConfiguration {
      var configuration = configuration

      configuration.activityIndicator = SmallActivityIndicatorConfiguration(
        gradientType: .color(
          SmallActivityIndicatorConfiguration.GradientColorConfiguration(
            angle: 0.0,
            colors: [UIColor(red: 6, green: 188, blue: 193).cgColor, UIColor.white.cgColor]
          )
        ),
        activityLineWidth: 3.0
      )
    return configuration
  }
}

// MARK: - Export example
extension ViewController {
  func exportVideo() {
    let manager = FileManager.default
    let videoURL = manager.temporaryDirectory.appendingPathComponent("tmp.mov")
    if manager.fileExists(atPath: videoURL.path) {
      try? manager.removeItem(at: videoURL)
    }
    
    let exportConfiguration = ExportVideoConfiguration(
      fileURL: videoURL,
      quality: .preset(AVAssetExportPresetHighestQuality),
      watermarkConfiguration: nil
    )
    videoEditorSDK?.exportVideos(using: [exportConfiguration], completion: { (success, error) in
      DispatchQueue.main.async {
        // Clear video editor session data
        self.videoEditorSDK?.clearSessionData()
        if success {
          self.playVideoAtURL(videoURL)
        }
      }
    })
  }
  
  private func playVideoAtURL(_ videoURL: URL) {
    let player = AVPlayer(url: videoURL)
    let playerController = AVPlayerViewController()
    playerController.player = player
    present(playerController, animated: true) {
        player.play()
    }
  }
}

extension ViewController: BanubaVideoEditorDelegate {
  func videoEditorDidCancel(_ videoEditor: BanubaVideoEditor) {
    videoEditor.dismissVideoEditor(animated: true, completion: nil)
  }
  
  func videoEditorDone(_ videoEditor: BanubaVideoEditor) {
    exportVideo()
    videoEditor.dismissVideoEditor(animated: true, completion: nil)
  }
}
