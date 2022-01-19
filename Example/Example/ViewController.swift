import UIKit
import BanubaVideoEditorSDK
import BanubaMusicEditorSDK
import BanubaOverlayEditorSDK
import VideoEditor
import AVFoundation
import AVKit
import Photos
import BSImagePicker

class ViewController: UIViewController {
  
  // MARK: - IBOutlet
  @IBOutlet weak var openVEButton: UIButton!
  @IBOutlet weak var openPIPButton: UIButton!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var label: UILabel!
  
  // MARK: - VideoEditorSDK
  private var videoEditorSDK: BanubaVideoEditor?
  // MARK: - life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    activityIndicator.isHidden = true
  }
}

// MARK: - IBAction
extension ViewController {
  @IBAction func openVideoEditorAction(_ sender: Any) {
    initVideoEditor() {
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
      
      let cameraLaunchConfig = VideoEditorLaunchConfig(
        entryPoint: .camera,
        hostController: self,
        musicTrack: nil, // Paste a music track as a track preset at the camera screen to record video with music
        animated: true
      )
      self.videoEditorSDK?.presentVideoEditor(
        withLaunchConfiguration: cameraLaunchConfig,
        completion: nil
      )
    }
    
  }
  
  @IBAction func PIPAction(_ sender: Any) {
    initVideoEditor {
      self.openGallery()
    }
  }
}
// MARK: - initVideoEditor
extension ViewController {
  private func initVideoEditor(completion: @escaping () -> Void) {
    guard videoEditorSDK == nil else {
      completion()
      return
    }
    
    let config = createVideoEditorConfiguration()
    
    let viewControllerFactory = ViewControllerFactory()
    let musicEditorViewControllerFactory = MusicEditorViewControllerFactory()
    viewControllerFactory.musicEditorFactory = musicEditorViewControllerFactory
    viewControllerFactory.countdownTimerViewFactory = CountdownTimerViewControllerFactory()
    viewControllerFactory.exposureViewFactory = DefaultExposureViewFactory()
    
    videoEditorSDK = BanubaVideoEditor(
      token: "5a9vX8ua6fgsFHchSkZ6GTRKfEC8pkAjGbiOTzWJixLY5BOP5V4/JGzPALOAT7pG4MwQLkzuMrhMDHv/ZDS+ZPxpl5zcY+rUT8A2f6fIwjwdy5QoeXyynmi6lQrI1/OKDUjsM5puo5gflQSOUHVVEl/glE9EW/YUgtnywcKV91x1eGE1Vnm0MRrTY1KOWbYlD7Bvb7gh69Hce9m8033ObVZyfVD8FbLpWRnUzX7Sqhm4GKlo3NisOJEKtoxZp2Pp2Hs/r+Id24feocpdyOPCmYxBxCxosAMNsd7dj+d8uD8iVVXbyeMnKYNO8DWuxasyCBb9QLTn9HcU4JTpYzOcBfNflYHXyUdec19XmnTM8DAiMXoT1G2xmlZYgrUHIGhiWI0/owGiq2Prmv+6MU9XB7wj5IK3DMGuCwZ4rqlWfe41nFJv6UbfnpPDcF5zINiMfwuC+7lbHdHtH5g2jnpIxdywkEln4dy78mgPdbRPrQvwiWIsGiXwdjkikZxf6ARWFHgHV7Bn63S8B63oxS2NSduCIllHdhowcdJZCzWjCkP3AcTmuAz0rD3BynPCrwgEOL58g3GT+w7ZbNX8JDVE9mZVKORCRp7iMmNsR6Uxy/egcm5ylaV1QfBS6xaxK0gZLimBsvc6V2uVovMM0Ww+4pi9mL5y12toVOBZyMUVr9QcMFE2aVw3VAtJWlLXaiqUddXxWOTyxsJ5No0/Ht5ME5xADJWKK+Vi/U1SUMRPBnkcw+nRcfTsWgJ1yh449VVpW7BnUbkBpFDUeEaF3Y23dT0jr9ZTpjeRqqS9Fro32bFL7KfL02e7vd2UKCuUk/UXJsa2PNcGJaGBMCajP4M1pwiiyhUWuEcFBG90AYBBlEtURAEMdJM1ym6WytEr9G1XBka9e1Fwp+tWDarDoQx1X0t50bFFh0v/CALsEjh+6UYTPPI/E79cBS4IrezwfE6zmEVurNO81pFz67LHnhI7cC0o9lkIH8iS86zWqng9qNdJ0PnFwrEbLAjImdmq+LQcUxYwByancQ4lRQOrZvZHLfkowtkZ8ZYjmBEQ4+cd/IJf4K+MgQYwXNt+YFosS7q4KY5F2uzIlA7g0/KHR1x9Bp8ntGFeiiaDhnYXXkdoz5lFVHTNvXECpQxIrmVBOh+CIfd4cEt5EuPW29KOiWqgRAM7DNfimQZ3tBit68Vhl1Bhv1dR32wPtPz+83UobsuH+IPrd6FbgnMFv7mPlvDEnu15VPG73mKh7OCTY4QZ87j0OjBXNBBVZlRDbcb9ynopC6Ftlrkt1uchVa4edFaaSd8E37jjOZbrDFJcBcbdFBAKtoc8BqeYuVr1WAzQhSvGoiemZImPkL2TT7xlyn/7QPhNNdInc/f5ObvZCc7FLkP+1xXAL7PcZaXLZcu64K89i/A+zClE4qDYl0zd5+cYTeQeN4GuTs0LQ3ETFWaODa2hkTLNmZS9Q6JpSbfAnQ4lOpUWcojKKLrjQUfyrrLsAKjKa1/6qnSmrOJsWThajOfCTlZ4zTn9B0Dj5IVtu1lJRbPlWpW65rbfasISnMi6sEgU6JrW7/sFrpa4M2eexR1t1xMfzmqBwhxtFMvfBKiy+7MJgJYPwCcUDlEBN3/VzTFmru4JpspsA1uro/tUOv9JvaXAyLSzn9cj2Muy2AHuk+OM/U53AEoz1L8TW5dd+g+xRlLOIXPvzxTOmGLQrCop2NYMMYtwXOp4CUrekvADNtvJAY+UnVV6WeiDKfE3raPuyGMwJBKOlPHH2A7yfgQK4Q364WX/ZwlmmLf8ntfGifzlkeQcfeVEILUy8bUMbwUYrlTcDqfZLAdrFmHrMvmTATd3a3y5C33iMsZIi6tsSQ0QN/qRdoEsxinD6fBZwAZzNL9bhN+uQkYj85UHnPk0yhPoq4U5cwgci5/iF0yq0w0txTrv/CUYZshPGqH8O1hXo4e9AhT639ld2IaomnddPWByehn7GncmJw4y8OCebihrZ0iVbNadl3CK9ljU3nbNHNhnwxyKRyxey9MVmNl2u/Yoh9iAnpgEdhD3IiGPlPxc3AjGDYGTe305ww0x3r39GeEWcujUdEx3N8uQlnemzuL8YvUmWT7H3XelSEc0TLGPUhpcK0R8VBG3wi9VYqGRIO0ZDWYFhyV1FEwqn2y4whVazTgMrYMbRb6MWG9+xpqjlygnTELK4eY7KeAGTTfQR2nXort7w/g0wJFgDaSCUsV/UVyQhC1ZDeo6bMEsnIh2nyoVEl6f2LQ1FWx6pO1YsH26iK5ozSh0bFBdC2F/Mp4pB8FGP5+6wvAWUWcA0JXIYe+SLeO+ajNsTu/XZg==",
      configuration: config,
      analytics: Analytics(),
      externalViewControllerFactory: viewControllerFactory
    )
    
    videoEditorSDK?.delegate = self
    completion()
  }
}
// MARK: - Configuration helpers
extension ViewController {
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
    config.trimVideoConfiguration = updateTrimVideoConfiguration(config.trimVideoConfiguration)
    config.trimVideosConfiguration = updateTrimVideosConfiguration(config.trimVideosConfiguration)
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
    setupActivityIndicatorHidden(false)
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
    
    let exportConfig = ExportConfiguration(
      videoConfigurations: [exportConfiguration],
      isCoverEnabled: true,
      gifSettings: GifSettings(duration: 0.3)
    )
    
    videoEditorSDK?.export(using: exportConfig, completion: { success, error, exportCoverImages in
      DispatchQueue.main.async {
        // Clear video editor session data
        self.videoEditorSDK?.clearSessionData()
        if success {
          /// If you want play exported video
//          self.playVideoAtURL(videoURL)
         
          /// if you want share exported video
          self.shareResultVideo(urls: [videoURL])
        }
        self.videoEditorSDK = nil
      }
    })
  }
  
  /// For demonstration purpose let's play exported video
  private func playVideoAtURL(_ videoURL: URL) {
    let player = AVPlayer(url: videoURL)
    let playerController = AVPlayerViewController()
    playerController.player = player
    present(playerController, animated: true) {
      player.play()
    }
  }
  
  /// For demonstration purpose lets share exported video
  private func shareResultVideo(urls: [URL]) {
    let shareController = UIActivityViewController(
      activityItems: urls,
      applicationActivities: nil
    )
    present(shareController, animated: true) {
      self.setupActivityIndicatorHidden(true)
    }
  }
}

// MARK: - BanubaVideoEditorDelegate
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

//MARK: - PIP Helpers
extension ViewController {
  private func openGallery() {
    VideoPicker().pickVideo(
      isMultipleSelectionEnabled: false,
      from: self
    ) { assets in
      
      guard let assets = assets else {
        return
      }
      
      var resultUrls: [URL] = []
      let group = DispatchGroup()
      var exportVideoRequests = assets.count
      assets.forEach { asset in
        group.enter()
        PHImageManager.default().requestAVAsset(
          forVideo: asset,
          options: .none
        ) { [weak self] (asset, _, _) in
          guard let asset = asset else { return }
          
          let groupHandler = {
            exportVideoRequests -= 1
            group.leave()
          }
          
          if let urlAsset = asset as? AVURLAsset {
            resultUrls.append(urlAsset.url)
            groupHandler()
            
          } else {
            guard let exportSession = AVAssetExportSession(
              asset: asset,
              presetName: ""
            ) else {
              return
            }
            
            let manager = FileManager.default
            let targetURL = manager.temporaryDirectory.appendingPathComponent("\(UUID().uuidString).mp4")
            
            exportSession.outputURL = targetURL
            exportSession.outputFileType = AVFileType.mp4
            exportSession.shouldOptimizeForNetworkUse = true
            
            exportSession.exportAsynchronously {
              DispatchQueue.main.async {
                guard exportSession.status == .completed else {
                  groupHandler()
                  return
                }
                
                let exportedAsset = AVURLAsset(url: targetURL)
                resultUrls.append(exportedAsset.url)
                groupHandler()
              }
            }
          }
        }
      }
      
      group.notify(queue: .main) {
        guard exportVideoRequests == 0 else {
          return
        }
        
        let presentingHandler = {  [weak self] in
          guard let self = self, !resultUrls.isEmpty else { return }
          
          let pipLaunchConfig = VideoEditorLaunchConfig(
            entryPoint: .pip,
            hostController: self,
            pipVideoItem: resultUrls[.zero],
            musicTrack: nil,
            animated: true
          )
          self.videoEditorSDK?.presentVideoEditor(
            withLaunchConfiguration: pipLaunchConfig,
            completion: nil
          )
        }
        
        guard self.videoEditorSDK == nil else {
          presentingHandler()
          return
        }
        
        self.initVideoEditor() {
          presentingHandler()
        }
      }
    }
  }
}

// MARK: - Helpers
extension ViewController {
  private func setupActivityIndicatorHidden(_ isHidden: Bool) {
    activityIndicator.isHidden = isHidden
    label.isHidden = isHidden
    openVEButton.isHidden = !isHidden
    openPIPButton.isHidden = !isHidden
    if isHidden {
      activityIndicator.stopAnimating()
    } else {
      activityIndicator.startAnimating()
    }
  }
}
