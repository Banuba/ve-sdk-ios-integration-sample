import UIKit
import BanubaVideoEditorSDK
import BanubaPhotoEditorSDK

import VideoEditor
import AVFoundation
import AVKit
import Photos
import BSImagePicker
import VEExportSDK
import BanubaAudioBrowserSDK
import BanubaLicenseServicingSDK

class ViewController: UIViewController, BanubaVideoEditorDelegate, BanubaPhotoEditorDelegate {
  
  // MARK: - IBOutlet
  @IBOutlet weak var invalidTokenMessageLabel: UILabel!
  
  // MARK: - VideoEditorSDK
  private let videoEditorModule = VideoEditorModule(token: AppDelegate.licenseToken)
  
  // Use “true” if you want users could restore the last video editing session.
  private let restoreLastVideoEditingSession: Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Check video editor initialization status
    guard let videoEditorSDK = videoEditorModule.videoEditorSDK else {
      invalidTokenMessageLabel.text = "Banuba Video Editor SDK is not initialized: license token is unknown or incorrect.\nPlease check your license token or contact Banuba"
      invalidTokenMessageLabel.isHidden = false
      return
    }
    
    videoEditorSDK.delegate = self
    
    videoEditorSDK.getLicenseState(completion: { [weak self] isValid in
      if isValid {
        print("✅ License is active, all good")
      } else {
        self?.invalidTokenMessageLabel.text = "License is revoked or expired. Please contact Banuba https://www.banuba.com/faq/kb-tickets/new"
        print("❌ License is either revoked or expired")
      }
      self?.invalidTokenMessageLabel.isHidden = isValid
    })
  }
  
  // MARK: - Handle BanubaVideoEditor callbacks
  func videoEditorDidCancel(_ videoEditor: BanubaVideoEditor) {
    if restoreLastVideoEditingSession == false {
      videoEditor.clearSessionData()
    }
    videoEditor.dismissVideoEditor(animated: true, completion: nil)
  }
  
  func videoEditorDone(_ videoEditor: BanubaVideoEditor) {
    videoEditor.dismissVideoEditor(animated: true) { [weak self] in
      self?.exportVideo(videoEditor: videoEditor)
    }
  }
  
  // MARK: - Actions
  @IBAction func openVideoEditorDefault(_ sender: Any) {
    let musicTrackPreset: MediaTrack? = nil
    // Uncomment to apply custom audio track in video editor
    //let musicTrackPreset = prepareMusicTrack(audioFileName: "short_music_20.wav")
    
    let launchConfig = VideoEditorLaunchConfig(
      entryPoint: .camera,
      hostController: self,
      musicTrack: musicTrackPreset, // Paste a music track as a track preset at the camera screen to record video with music
      animated: true
    )
    videoEditorModule.presentVideoEditor(with: launchConfig)
  }
  
  @IBAction func openVideoEditorPiP(_ sender: Any) {
    pickerGalleryVideos(entryPoint: .pip) { [weak self] pickedVideoUrls in
      guard let self, !pickedVideoUrls.isEmpty else { return }
      
      let launchConfig = VideoEditorLaunchConfig(
        entryPoint: .pip,
        hostController: self,
        videoItems: pickedVideoUrls,
        pipVideoItem: pickedVideoUrls[.zero],
        animated: true
      )
      
      self.videoEditorModule.presentVideoEditor(with: launchConfig)
    }
  }
  
  @IBAction func openVideoEditorDrafts(_ sender: UIButton) {
    let launchConfig = VideoEditorLaunchConfig(
      entryPoint: .drafts,
      hostController: self,
      animated: true
    )
    
    videoEditorModule.presentVideoEditor(with: launchConfig)
  }
  
  @IBAction func openVideoEditorTrimmer(_ sender: UIButton) {
    pickerGalleryVideos(entryPoint: .trimmer) { [weak self] pickedVideoUrls in
      guard let self, !pickedVideoUrls.isEmpty else { return }
      
      let launchConfig = VideoEditorLaunchConfig(
        entryPoint: .trimmer,
        hostController: self,
        videoItems: pickedVideoUrls,
        pipVideoItem: nil,
        animated: true
      )
      
      self.videoEditorModule.presentVideoEditor(with: launchConfig)
    }
  }
  
  @IBAction func openPhotoEditor(_ sender: UIButton) {
    let launchConfig = PhotoEditorLaunchConfig(
      hostController: self
    )
    videoEditorModule.presentPhotoEditor(
      with: launchConfig,
      delegate: self
    )
  }
  
  private func prepareMusicTrack(audioFileName: String) -> MediaTrack {
    let musicURL = Bundle.main.bundleURL.appendingPathComponent(audioFileName)
    let assset = AVURLAsset(url: musicURL)
    
    let musicTrackPreset = MediaTrack(
      uuid: UUID(),
      id: nil,
      url: musicURL,
      coverURL: nil,
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
    
    return musicTrackPreset
  }
}

// MARK: - BanubaPhotoEditorDelegate
extension ViewController {
  func photoEditorDidCancel(_ photoEditor: BanubaPhotoEditorSDK.BanubaPhotoEditor) {
    print("User has closed the photo editor")
    photoEditor.dismissPhotoEditor(animated: true, completion: nil)
  }
  
  func photoEditorDidFinishWithImage(_ photoEditor: BanubaPhotoEditorSDK.BanubaPhotoEditor, image: UIImage) {
    print("User has saved the edited image")
    photoEditor.dismissPhotoEditor(animated: true, completion: nil)
  }
}

// MARK: - Export example
extension ViewController {
  func exportVideo(videoEditor: BanubaVideoEditor) {
    let progressViewController = videoEditorModule.createProgressViewController()
    progressViewController.cancelHandler = { videoEditor.stopExport() }
    present(progressViewController, animated: true)
    
    let manager = FileManager.default
    let exportedVideoFileName = "tmp.mov"
    let videoURL = manager.temporaryDirectory.appendingPathComponent(exportedVideoFileName)
    if manager.fileExists(atPath: videoURL.path) {
      try? manager.removeItem(at: videoURL)
    }
    
    let exportConfiguration = videoEditorModule.createExportConfiguration(destFile: videoURL)
    
    videoEditor.export(
      using: exportConfiguration,
      exportProgress: { progress in
        DispatchQueue.main.async {
          progressViewController.updateProgressView(with: Float(progress))
        }
      },
      completion: { [weak self] error, exportCoverImages in
        DispatchQueue.main.async {
          // Hide progress view
          progressViewController.dismiss(animated: true) {
            // Clear video editor session data
            if self?.restoreLastVideoEditingSession == false {
              videoEditor.clearSessionData()
            }
            if error == nil {
              /// If you want to play exported video
              //          self.playVideoAtURL(videoURL)
              
              /// If you want to share exported video
              self?.showSharingScreen(
                videoUrl: videoURL,
                exportCoverImages: exportCoverImages
              )
            }
          }
        }
    })
  }
  
  private func showSharingScreen(videoUrl: URL, exportCoverImages: ExportCoverImages?) {
    let config = videoEditorModule.videoEditorSDK!.currentConfiguration.sharingScreenConfiguration
    
    BanubaVideoEditor.presentSharingViewController(
      from: self,
      configuration: config,
      mainVideoUrl: videoUrl,
      videoUrls: [videoUrl],
      previewImage: exportCoverImages?.coverImage ?? UIImage(),
      animated: true,
      completion: nil
    )
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
}

// MARK: - Helpers
extension ViewController {
  private func pickerGalleryVideos(
    entryPoint: PresentEventOptions.EntryPoint,
    completion: @escaping (_ videoUrls: [URL]) -> Void
  ) {
    pickGalleryVideo(
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
        
        completion(resultUrls)
      }
    }
  }
  
  private func pickGalleryVideo(
    isMultiSelectionEnabled: Bool,
    completion: @escaping ([PHAsset]?) -> Void
  ) {
    let imagePicker = ImagePickerController()
    
    imagePicker.settings.fetch.assets.supportedMediaTypes = [.video]
    imagePicker.settings.selection.max = isMultiSelectionEnabled ? Int.max : 1
    
    self.presentImagePicker(
      imagePicker,
      select: nil,
      deselect: nil,
      cancel: { assets in
        completion(nil)
      }, finish: { assets in
        completion(assets)
      }
    )
  }
}
