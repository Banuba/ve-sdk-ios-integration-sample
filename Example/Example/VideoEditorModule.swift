
import UIKit
import AVFoundation
import AVKit
import Photos
import BSImagePicker
import UnifiedVideoEditorSDK

// Adopting CountdownView to using in BanubaVideoEditorSDK
extension CountdownView: MusicEditorCountdownAnimatableView {}

class VideoEditorModule {
    
    var videoEditorSDK: BanubaVideoEditor?
    
    var isVideoEditorInitialized: Bool { videoEditorSDK != nil }
    private let resourcesDownloader: FaceARResourcesDownloader
    
    init(token: String) {
        resourcesDownloader = FaceARResourcesDownloader(
            resourceBundleUrl: URL(string: <#T##CDN URL#>)!
        )
        let config = createConfiguration()
        let externalViewControllerFactory = createExampleExternalViewControllerFactory()
        
        videoEditorSDK = BanubaVideoEditor(
            token: token,
            configuration: config,
            externalViewControllerFactory: externalViewControllerFactory
        )
    }
    
    func presentVideoEditor(with launchConfig: VideoEditorLaunchConfig) {
        guard isVideoEditorInitialized else {
            print("BanubaVideoEditor is not initialized!")
            return
        }
        Task { @MainActor in
            do {
                try await resourcesDownloader.downloadResources()
                
                videoEditorSDK?.presentVideoEditor(
                    withLaunchConfiguration: launchConfig,
                    completion: nil
                )
            } catch {
                print("Error happened during resource bundle download \(error)")
            }
        }
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
    
    // MARK: - Example view controller factory customization
    func createExampleExternalViewControllerFactory() -> ExternalViewControllerFactory {
        return ExampleViewControllerFactory()
    }
    
    /// Example video editor view controller factory stores custom view factories used for customization BanubaVideoEditor
    class ExampleViewControllerFactory: ExternalViewControllerFactory {
        var musicEditorFactory: MusicEditorExternalViewControllerFactory?
        var countdownTimerViewFactory: CountdownTimerViewFactory?
        var exposureViewFactory: AnimatableViewFactory?
        
        init() {
            countdownTimerViewFactory = CountdownTimerViewControllerFactory()
            exposureViewFactory = DefaultExposureViewFactory()
        }
        
        /// Example countdown timer view factory for Recorder countdown animation
        class CountdownTimerViewControllerFactory: CountdownTimerViewFactory {
            func makeCountdownTimerView() -> CountdownTimerAnimatableView {
                let countdownView = CountdownView()
                countdownView.frame = UIScreen.main.bounds
                countdownView.font = countdownView.font.withSize(102.0)
                countdownView.digitColor = .white
                return countdownView
            }
        }
    }
}
