
import UIKit
import BanubaVideoEditorSDK
import BanubaVideoEditorCore
import AVFoundation
import AVKit
import Photos
import BanubaAudioBrowserSDK

typealias VideoEditingResult = (URL, BanubaVideoEditorSDK.ExportCoverImages?)

final class VideoEditorModule: BanubaVideoEditorDelegate {

    /// Callback for handling export result
    let onVideoEditingFinished: (Result<VideoEditingResult>) -> Void

    let videoEditorSDK: BanubaVideoEditor

    // Set to true to allow users to restore the last video editing session.
    private let restoreLastVideoEditingSession: Bool = false

    init?(
        token: String,
        isEditorV2Enabled: Bool,
        onVideoEditingFinished: @escaping (Result<VideoEditingResult>) -> Void
    ) {
        self.onVideoEditingFinished = onVideoEditingFinished

        guard let videoEditorSDK = BanubaVideoEditor(
            token: token,
            arguments: [.useEditorV2: isEditorV2Enabled],
            configuration: Self.createConfiguration()
        ) else {
            return nil
        }

        self.videoEditorSDK = videoEditorSDK
        videoEditorSDK.delegate = self
    }

    func getLicenseState(completion: @escaping (_ isValid: Bool) -> Void) {
        videoEditorSDK.getLicenseState(completion: completion)
    }

    func presentVideoEditor(with launchConfig: VideoEditorLaunchConfig) {
        videoEditorSDK.presentVideoEditor(
            withLaunchConfiguration: launchConfig,
            completion: nil
        )
    }

    // MARK: - BanubaVideoEditorDelegate
    func videoEditorDidCancel(_ videoEditor: BanubaVideoEditor) {
        if !restoreLastVideoEditingSession {
            videoEditor.clearSessionData()
        }
        videoEditor.dismissVideoEditor(animated: true, completion: nil)
    }

    func videoEditorDone(_ videoEditor: BanubaVideoEditor) {
        export() { [weak self] exportResult in
            videoEditor.dismissVideoEditor(animated: true) { [weak self] in
                self?.onVideoEditingFinished(exportResult)
            }
        }
    }

    private func export(_ completion: @escaping (Result<VideoEditingResult>) -> Void) {
        // Show progress VC
        var progressViewController: ProgressViewController?
        if let topViewController = getTopViewController() {
            let progress = createProgressViewController()
            progressViewController = progress
            progress.cancelHandler = { [weak self] in self?.videoEditorSDK.stopExport() }
            topViewController.present(progress, animated: true)
        }

        // Configure destination video URL
        let exportedVideoFileName = "tmp.mov"
        let manager = FileManager.default
        let videoURL = manager.temporaryDirectory.appendingPathComponent(exportedVideoFileName)
        if manager.fileExists(atPath: videoURL.path) {
            try? manager.removeItem(at: videoURL)
        }

        let exportConfiguration = createExportConfiguration(destFile: videoURL)

        videoEditorSDK.export(
            using: exportConfiguration,
            exportProgress: { [weak progressViewController] progress in
                DispatchQueue.main.async { progressViewController?.updateProgressView(with: Float(progress)) }
            },
            completion: { [weak self, weak progressViewController] error, exportCoverImages in
                DispatchQueue.main.async {
                    guard let self else { return }
                    // Hide progress view
                    progressViewController?.dismiss(animated: true) {
                        // Clear video editor session data
                        if !self.restoreLastVideoEditingSession {
                            self.videoEditorSDK.clearSessionData()
                        }
                        // Handle export result
                        if let error {
                            completion(.failure(error))
                        } else {
                            completion(.success((videoURL, exportCoverImages)))
                        }
                    }
                }
            }
        )
    }

    func createExportConfiguration(destFile: URL) -> ExportConfiguration {
        // Set up watermark. To export without a watermark, omit the configuration.
        let watermarkConfiguration = WatermarkConfiguration(
            watermark: ImageConfiguration(imageName: "Common.Banuba.Watermark"),
            size: CGSize(width: 204, height: 52),
            sharedOffset: 20,
            position: .rightBottom
        )

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

    static func createConfiguration() -> VideoEditorConfig {
        var config = VideoEditorConfig()

        AudioBrowserConfig.shared.musicSource = .allSources
        AudioBrowserConfig.shared.setPrimaryColor(#colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1))

        var featureConfiguration = config.featureConfiguration
        featureConfiguration.supportsTrimRecordedVideo = true
        config.updateFeatureConfiguration(featureConfiguration: featureConfiguration)

        return config
    }

    // Returns the top-most view controller for presenting the progress UI.
    private func getTopViewController() -> UIViewController? {
        let window = UIApplication.shared.connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow }.last
        guard let window, let rootViewController = window.rootViewController else {
            return nil
        }

        var topController = rootViewController

        while let newTopController = topController.presentedViewController {
            topController = newTopController
        }

        return topController
    }
}
