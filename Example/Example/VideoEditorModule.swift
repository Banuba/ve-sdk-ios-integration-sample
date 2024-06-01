
import UIKit
import AVFoundation
import AVKit
import Photos
import BSImagePicker
import UnifiedVideoEditorSDK

class VideoEditorModule {
    
    var videoEditorSDK: BanubaVideoEditor?
    
    var isVideoEditorInitialized: Bool { videoEditorSDK != nil }
    
    init(token: String) {
        let config = createConfiguration()
        
        videoEditorSDK = BanubaVideoEditor(
            token: token,
            configuration: config
        )
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
        
        config.setupColorsPalette(
            VideoEditorColorsPalette(
                primaryColor: .white,
                secondaryColor: .black,
                accentColor: .white,
                effectButtonColorsPalette: EffectButtonColorsPalette(
                    defaultIconColor: .white,
                    defaultBackgroundColor: .clear,
                    selectedIconColor: .black,
                    selectedBackgroundColor: .white
                ),
                addGalleryItemBackgroundColor: .white,
                addGalleryItemIconColor: .black,
                timelineEffectColorsPalette: TimelineEffectColorsPalette.default
            )
        )
        
        var featureConfiguration = config.featureConfiguration
        featureConfiguration.supportsTrimRecordedVideo = true
        featureConfiguration.isMuteCameraAudioEnabled = true
        config.updateFeatureConfiguration(featureConfiguration: featureConfiguration)
        
        return config
    }
}
