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
    config.handsfreeConfiguration = updateHandsfreeConfiguration(config.handsfreeConfiguration)
    config.recorderConfiguration = updateRecorderConfiguration(config.recorderConfiguration)
    config.editorConfiguration = updateEditorConfiguration(config.editorConfiguration)
    config.galleryConfiguration = updateGalleryConfiguration(config.galleryConfiguration)
    config.combinedGalleryConfiguration = updateCombinedGalleryConfiguration(config.combinedGalleryConfiguration)
    config.videoCoverSelectionConfiguration = updateVideCoverSelectionConfiguration(config.videoCoverSelectionConfiguration)
    config.musicEditorConfiguration = updateMusicEditorConfigurtion(config.musicEditorConfiguration)
    config.overlayEditorConfiguration = updateOverlayEditorConfiguraiton(config.overlayEditorConfiguration)
    config.textEditorConfiguration = updateTextEditorConfiguration(config.textEditorConfiguration)
    config.gifPickerConfiguration = updateGifPickerConfiguration(config.gifPickerConfiguration)
    config.speedSelectionConfiguration = updateSpeedSelectionConfiguration(config.speedSelectionConfiguration)
    config.trimGalleryVideoConfiguration = updateTrimGalleryVideoConfiguration(config.trimGalleryVideoConfiguration)
    config.multiTrimConfiguration = updateMultiTrimConfiguration(config.multiTrimConfiguration)
    config.singleTrimConfiguration = updateSingleTrimConfiguration(config.singleTrimConfiguration)
    config.filterConfiguration = updateFilterConfiguration(config.filterConfiguration)
    config.alertViewConfiguration = updateAlertConfiguration(config.alertViewConfiguration)
    config.fullScreenActivityConfiguration = updateFullScreenActivityConfiguration(config.fullScreenActivityConfiguration)
    config.videoCoverSelectionConfiguration = updateSimpleVideoCoverSelectionConfiguration(config.videoCoverSelectionConfiguration)
    
    return config
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
  
  private func updateSpeedSelectionConfiguration(_ configuration: SpeedSelectionConfiguration) -> SpeedSelectionConfiguration {
    var configuration = configuration
    
    configuration.backButton = BackButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "back_arrow"))
    configuration.speedBarConfiguration.speedItemBackgroundColor = UIColor(red: 18, green: 38, blue: 58)
    configuration.speedBarConfiguration.selectorColor = UIColor(red: 6, green: 188, blue: 193)
    configuration.speedBarConfiguration.selectorTextColor = UIColor.white
    
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
