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
      token: "Put video editor token here",
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
      isEditable: true,
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
    featureConfiguration.supportsTrimRecordedVideo = true
    featureConfiguration.isMuteCameraAudioEnabled = true
    config.updateFeatureConfiguration(featureConfiguration: featureConfiguration)
    
    config.isHandfreeEnabled = true
    config.gifPickerConfiguration = updateGifPickerConfiguration(config.gifPickerConfiguration)
    config.recorderConfiguration = updateRecorderConfiguration(config.recorderConfiguration)
    config.editorConfiguration = updateEditorConfiguration(config.editorConfiguration)
    config.combinedGalleryConfiguration = updateCombinedGalleryConfiguration(config.combinedGalleryConfiguration)
    config.videoCoverSelectionConfiguration = updateVideCoverSelectionConfiguration(config.videoCoverSelectionConfiguration)
    config.extendedVideoCoverSelectionConfiguration = updateVideCoverSelectionConfiguration(config.extendedVideoCoverSelectionConfiguration)
    config.musicEditorConfiguration = updateMusicEditorConfigurtion(config.musicEditorConfiguration)
    config.overlayEditorConfiguration = updateOverlayEditorConfiguraiton(config.overlayEditorConfiguration)
    config.textEditorConfiguration = updateTextEditorConfiguration(config.textEditorConfiguration)
    config.trimGalleryVideoConfiguration = updateTrimGalleryVideoConfiguration(config.trimGalleryVideoConfiguration)
    config.multiTrimConfiguration = updateMultiTrimConfiguration(config.multiTrimConfiguration)
    config.filterConfiguration = updateFilterConfiguration(config.filterConfiguration)
    config.alertViewConfiguration = updateAlertViewConfiguration(config.alertViewConfiguration)
    config.fullScreenActivityConfiguration = updateFullScreenActivityConfiguration(config.fullScreenActivityConfiguration)
    config.handsfreeConfiguration = updateHandsfreeConfiguration(config.handsfreeConfiguration)
    config.aspectsConfiguration = updateAspectsConfiguration(config.aspectsConfiguration)
    
    return config
  }
  
  private func updateFilterConfiguration(_ configuration: FilterConfiguration) -> FilterConfiguration {
    var configuration = configuration
    
    configuration.resetButton.backgroundColor = UIColor(red: 6, green: 188, blue: 193)
    configuration.resetButton.cornerRadius = 4.0
    configuration.resetButton.textConfiguration?.color = .white
    configuration.toolTipLabel.color = .white
    configuration.cursorButton = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_cursor"))
  
    configuration.effectItemConfiguration.cornerRadius = 4.0
    
    configuration.controlButtons = [
      FilterControlButtonConfig(type: .cancel, imageName: "ic_close", selectedImageName: nil),
      FilterControlButtonConfig(type: .play, imageName: "ic_editor_play", selectedImageName: "ic_pause"),
      FilterControlButtonConfig(type: .done, imageName: "ic_done", selectedImageName: nil),
    ]
    
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
      watermarkConfiguration: watermarkConfiguration,
      gifSettings: GifSettings(duration: 0.3)
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
