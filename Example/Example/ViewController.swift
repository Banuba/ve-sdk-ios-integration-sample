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
      token: "PUT FACEAR TOKEN",
      effectsToken: "u4fwA4rVK2P/nkHS/tKE7SxK7fK+1u0DuoAruXXgIJhuSI0aynki+8gGXUWAC1H3jBDYThexzTBxlPc0eq2x2mdwR/F+iL2gmVpXrC4mAXiEByjb5VpSqsJzbM/K9LGnEDByWZVRTzq8ZuvwKR7BCKU3f4Z7",
      cloudMasksToken: "PUT AR CLOUD ID",
      configuration: config,
      analytics: Analytics(),
      externalViewControllerFactory: viewControllerFactory
    )
    
    videoEditorSDK?.delegate = self
  }
  
  @IBAction func openVideoEditorAction(_ sender: Any) {
    if videoEditorSDK == nil {
      initVideoEditor()
    }
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
    
    AudioBrowserConfigurator.configure()
    
    var featureConfiguration = config.featureConfiguration
    featureConfiguration.isAudioBrowserEnabled = true
    featureConfiguration.supportsTrimRecordedVideo = true
    config.updateFeatureConfiguration(featureConfiguration: featureConfiguration)
    
    config.isHandfreeEnabled = true
    config.recorderConfiguration = updateRecorderConfiguration(config.recorderConfiguration)
    config.editorConfiguration = updateEditorConfiguration(config.editorConfiguration)
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
    config.alertViewConfiguration = updateAlertViewConfiguration(config.alertViewConfiguration)
    config.fullScreenActivityConfiguration = updateFullScreenActivityConfiguration(config.fullScreenActivityConfiguration)
    config.handsfreeConfiguration = updateHandsfreeConfiguration(config.handsfreeConfiguration)
    
    return config
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
    
    configuration.galleryTypeUnderlineColor = UIColor(red: 6, green: 188, blue: 193)
    
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
    configuration.resetButton.textConfiguration?.color = .white
    configuration.toolTipLabel.color = .white
    configuration.cursorButton = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_cursor"))
  
    configuration.effectItemConfiguration.cornerRadius = 4.0
    
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
    
    let watermarkConfiguration = WatermarkConfiguration(
      watermark: ImageConfiguration(imageName: "Common.Banuba.Watermark"),
      size: CGSize(width: 204, height: 52),
      sharedOffset: 20,
      position: .rightBottom)
    
    let exportConfiguration = ExportVideoConfiguration(
      fileURL: videoURL,
      quality: .auto,
      useHEVCCodecIfPossible: true,
      watermarkConfiguration: watermarkConfiguration
    )
    videoEditorSDK?.exportVideos(using: [exportConfiguration], completion: { (success, error) in
      DispatchQueue.main.async {
        // Clear video editor session data
        self.videoEditorSDK?.clearSessionData()
        if success {
          self.playVideoAtURL(videoURL)
        }
        self.videoEditorSDK = nil
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
    videoEditor.dismissVideoEditor(animated: true) { [weak self] in
      self?.videoEditorSDK = nil
    }
  }
  
  func videoEditorDone(_ videoEditor: BanubaVideoEditor) {
    videoEditor.dismissVideoEditor(animated: true) { [weak self] in
      self?.exportVideo()
    }
  }
}
