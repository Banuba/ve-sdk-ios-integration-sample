
import UIKit
import BanubaVideoEditorSDK

import VideoEditor
import AVFoundation
import AVKit
import Photos
import BSImagePicker
import VEExportSDK
import BanubaAudioBrowserSDK

// Adopting CountdownView to using in BanubaVideoEditorSDK
extension CountdownView: MusicEditorCountdownAnimatableView {}

class VideoEditorModule {
    
    var videoEditorSDK: BanubaVideoEditor?
    
    var isVideoEditorInitialized: Bool { videoEditorSDK != nil }
    
    init(token: String) {
        let config = createConfiguration()
        
        let videoEditorSDK = BanubaVideoEditor(
            token: token,
            configuration: config
        )
        
        self.videoEditorSDK = videoEditorSDK
    }
    
    func presentVideoEditor(with launchConfig: VideoEditorLaunchConfig) {
        guard isVideoEditorInitialized else {
            print("BanubaVideoEditor is not initialized!")
            return
        }
        videoEditorSDK?.presentVideoEditor(
            withLaunchConfiguration: launchConfig,
            completion: nil
        )
    }
    
    func createExportConfiguration(destFile: URL) -> ExportConfiguration {
        let watermarkConfiguration = WatermarkConfiguration(
          watermark: ImageConfiguration(imageName: "Common.Banuba.Watermark"),
          size: CGSize(width: 204, height: 52),
          sharedOffset: 20,
          position: .rightBottom)
        
        let exportConfiguration = ExportVideoConfiguration(
          fileURL: destFile,
          quality: .auto,
          useHEVCCodecIfPossible: true,
          watermarkConfiguration: watermarkConfiguration
        )
        
        let exportConfig = ExportConfiguration(
          videoConfigurations: [exportConfiguration],
          isCoverEnabled: true,
          gifSettings: GifSettings(duration: 0.3)
        )
        
        return exportConfig
    }
    
    func createProgressViewController() -> ProgressViewController {
      let progressViewController = ProgressViewController.makeViewController()
      progressViewController.message = "Exporting"
      return progressViewController
    }
    
    func createConfiguration() -> VideoEditorConfig {
        var config = VideoEditorConfig()
        
        config.autoCutConfiguration.embeddingsDownloadUrl = "https://ve-autocut-v2-ap-south-1.s3.ap-south-1.amazonaws.com/index.zip"
        config.autoCutConfiguration.musicApiSelectedTracksUrl = "https://soundstripe-proxy.banuba.net/v1/songs"
        
        // Set Mubert API KEYS here
        BanubaAudioBrowser.setMubertKeys(
            license: "SET MUBERT API LICENSE",
            token: "SET MUBERT API TOKEN"
        )
        AudioBrowserConfig.shared.musicSource = .allSources
        AudioBrowserConfig.shared.setPrimaryColor(#colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1))
        
        var featureConfiguration = config.featureConfiguration
        featureConfiguration.supportsTrimRecordedVideo = true
        featureConfiguration.isMuteCameraAudioEnabled = true
        config.updateFeatureConfiguration(featureConfiguration: featureConfiguration)
        
        return config
    }
}
