
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

// Adopting CountdownView to using in BanubaVideoEditorSDK
extension CountdownView: MusicEditorCountdownAnimatableView {}

class VideoEditorModule {
    
    var videoEditorSDK: BanubaVideoEditor?
    var photoEditorSDK: BanubaPhotoEditor?
    
    private let token: String
    
    init(token: String) {
        self.token = token
    }
    
    func createVideoEditor() {
        // Deallocate any active instances of both editors to free used resources
        // and to prevent "You are trying to create the second instance of the singleton." crash
        photoEditorSDK = nil
        videoEditorSDK = nil
        
        videoEditorSDK = BanubaVideoEditor(
            token: token,
            configuration: createConfiguration(),
            externalViewControllerFactory: createExampleExternalViewControllerFactory()
        )
    }
    
    func presentVideoEditor(with launchConfig: VideoEditorLaunchConfig) {
        videoEditorSDK?.presentVideoEditor(
            withLaunchConfiguration: launchConfig,
            completion: nil
        )
    }
    
    func createPhotoEditor() {
        // Deallocate any active instances of both editors to free used resources
        // and to prevent "You are trying to create the second instance of the singleton." crash
        photoEditorSDK = nil
        videoEditorSDK = nil
        
        let configuration = PhotoEditorConfig()
        photoEditorSDK = BanubaPhotoEditor(
            token: token,
            configuration: configuration
        )
    }
    
    func presentPhotoEditor(with launchConfig: PhotoEditorLaunchConfig) {
        photoEditorSDK?.presentPhotoEditor(
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
