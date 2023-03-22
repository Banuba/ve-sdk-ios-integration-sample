import UIKit
import BanubaVideoEditorSDK
import BanubaMusicEditorSDK
  
import VideoEditor
import AVFoundation
import AVKit
import Photos
import BSImagePicker
import VEExportSDK
import BanubaAudioBrowserSDK
import BanubaLicenseServicingSDK

class ViewController: UIViewController {
  
  private static let errEditorNotInitialized =
  "Banuba Video Editor SDK is not initialized: license token is unknown or incorrect.\nPlease check your license token or contact Banuba"
  private static let errEditorLicenseRevoked =
  "License is revoked or expired. Please contact Banuba https://www.banuba.com/faq/kb-tickets/new"
  
  // MARK: - IBOutlet
  @IBOutlet weak var openVEButton: UIButton!
  @IBOutlet weak var openPIPButton: UIButton!
  @IBOutlet weak var invalidTokenMessageLabel: UILabel!
  
  // MARK: - VideoEditorSDK
  private var videoEditorSDK: BanubaVideoEditor?
  private let videoEditorModule = VideoEditorModule()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    invalidTokenMessageLabel.isHidden = true
  }
}

// MARK: - IBAction
extension ViewController {
  @IBAction func openVideoEditorAction(_ sender: Any) {
    initVideoEditor() { isTokenValid in
      guard isTokenValid else { return }
      let musicURL = Bundle.main.bundleURL
        .appendingPathComponent("Music/long", isDirectory: true)
        .appendingPathComponent("long_music_2.wav")
      let assset = AVURLAsset(url: musicURL)
      
      let musicTrackPreset = MediaTrack(
        uuid: UUID(),
        id: nil,
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
      let launchConfig = VideoEditorLaunchConfig(
        entryPoint: .camera,
        hostController: self,
        musicTrack: nil, // Paste a music track as a track preset at the camera screen to record video with music
        animated: true
      )
      self.presentVideoEditor(with: launchConfig)
    }
  }
  
  @IBAction func PIPAction(_ sender: Any) {
    initVideoEditor { isTokenValid in
      guard isTokenValid else { return }
      self.openGallery(for: .pip)
    }
  }
  
  @IBAction func draftsAction(_ sender: UIButton) {
    initVideoEditor { isTokenValid in
      guard isTokenValid else { return }
      let launchConfig = VideoEditorLaunchConfig(
        entryPoint: .drafts,
        hostController: self,
        animated: true
      )
      self.presentVideoEditor(with: launchConfig)
    }
  }
  
  @IBAction func trimmerAction(_ sender: UIButton) {
    initVideoEditor { isTokenValid in
      guard isTokenValid else { return }
      self.openGallery(for: .trimmer)
    }
  }
}

// MARK: - initVideoEditor
extension ViewController {
  private func initVideoEditor(completion: @escaping (Bool) -> Void) {
    guard videoEditorSDK == nil else {
      videoEditorSDK?.getLicenseState(completion: completion)
      return
    }
    
    let config = videoEditorModule.createConfiguration()
    let externalViewControllerFactory = videoEditorModule.createExampleExternalViewControllerFactory()
    
    videoEditorSDK = BanubaVideoEditor(
      token: AppDelegate.licenseToken,
      configuration: config,
      externalViewControllerFactory: externalViewControllerFactory
    )
    
    videoEditorSDK?.delegate = self
    
    if videoEditorSDK == nil {
      invalidTokenMessageLabel.text = ViewController.errEditorNotInitialized
      invalidTokenMessageLabel.isHidden = false
      return
    }
    videoEditorSDK?.getLicenseState(completion: { [weak self] isValid in
      if isValid {
        print("✅ License is active, all good")
      } else {
        self?.invalidTokenMessageLabel.text = ViewController.errEditorLicenseRevoked
        print("❌ License is either revoked or expired")
      }
      self?.invalidTokenMessageLabel.isHidden = isValid
      completion(isValid)
    })
  }
}

// MARK: - Export example
extension ViewController {
  func exportVideo() {
    let progressViewController = videoEditorModule.createProgressViewController()
    progressViewController.cancelHandler = { [weak self] in
      self?.videoEditorSDK?.stopExport()
    }
    present(progressViewController, animated: true)
    
    
    let manager = FileManager.default
    let exportedVideoFileName = "tmp.mov"
    let videoURL = manager.temporaryDirectory.appendingPathComponent(exportedVideoFileName)
    if manager.fileExists(atPath: videoURL.path) {
      try? manager.removeItem(at: videoURL)
    }
    
    let exportConfiguration = videoEditorModule.createExportConfiguration(destFile: videoURL)
    
    videoEditorSDK?.export(
      using: exportConfiguration,
      exportProgress: { progress in
        DispatchQueue.main.async {
          progressViewController.updateProgressView(with: Float(progress))
        }
      },
      completion: { [weak self] success, error, exportCoverImages in
      DispatchQueue.main.async {
        // Hide progress view
        progressViewController.dismiss(animated: true) {
          // Clear video editor session data
          self?.videoEditorSDK?.clearSessionData()
          if success {
            /// If you want to play exported video
//          self.playVideoAtURL(videoURL)
            
            /// If you want to share exported video
            if let self = self, let config = self.videoEditorSDK?.currentConfiguration.sharingScreenConfiguration {
              BanubaVideoEditor.presentSharingViewController(
                from: self,
                configuration: config,
                mainVideoUrl: videoURL,
                videoUrls: [videoURL],
                previewImage: exportCoverImages?.coverImage ?? UIImage(),
                animated: true,
                completion: nil
              )
            }
          }
          self?.videoEditorSDK = nil
        }
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
  
  private func presentVideoEditor(
    with launchConfig: VideoEditorLaunchConfig
  ) {
    self.videoEditorSDK?.presentVideoEditor(
      withLaunchConfiguration: launchConfig,
      completion: nil
    )
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

// MARK: - PIP Helpers
extension ViewController {
  private func openGallery(for entryPoint: PresentEventOptions.EntryPoint) {
    pickVideo(
      isMultiSelectionEnabled: entryPoint != .pip
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
        ) { (asset, _, _) in
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
        
        let presentingHandler = { [weak self] in
          guard let self = self, !resultUrls.isEmpty else { return }
          
          let launchConfig = VideoEditorLaunchConfig(
            entryPoint: entryPoint,
            hostController: self,
            videoItems: resultUrls,
            pipVideoItem: resultUrls[.zero],
            animated: true
          )
          self.presentVideoEditor(with: launchConfig)
        }
        
        guard self.videoEditorSDK == nil else {
          presentingHandler()
          return
        }
        
        self.initVideoEditor() { isTokenValid in
          guard isTokenValid else { return }
          presentingHandler()
        }
      }
    }
  }
}
