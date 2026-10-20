
import UIKit
import BanubaVideoEditorSDK
import BanubaVideoEditorCore
import AVFoundation
import AVKit
import Photos
import BanubaAudioBrowserSDK

typealias VideoEditingResult = (URL?, BanubaVideoEditorSDK.ExportCoverImages?)

@MainActor
final class VideoEditorModule: BanubaVideoEditorDelegate {

    /// Callback for handling export result
    let onVideoEditingFinished: (Swift.Result<VideoEditingResult, Error>) -> Void

    let videoEditorSDK: BanubaVideoEditor

    // Set to true to allow users to restore the last video editing session.
    private let restoreLastVideoEditingSession: Bool = false

    init?(
        token: String,
        isEditorV2Enabled: Bool,
        onVideoEditingFinished: @escaping (Swift.Result<VideoEditingResult, Error>) -> Void
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

    private func export(_ completion: @escaping (Swift.Result<VideoEditingResult, Error>) -> Void) {
        // Show progress VC
        var progressViewController: ProgressViewController?
        if let topViewController = getTopViewController() {
            let progress = createProgressViewController()
            progressViewController = progress
            progress.cancelHandler = { [weak self] in self?.videoEditorSDK.stopExport() }
            topViewController.present(progress, animated: true)
        }

        videoEditorSDK.export(
            exportProgress: { [weak progressViewController] progress in
                DispatchQueue.main.async { progressViewController?.updateProgressView(with: Float(progress)) }
            },
            completion: { [weak self, weak progressViewController] videoURL, error, exportCoverImages in
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

    func createProgressViewController() -> ProgressViewController {
        let progressViewController = ProgressViewController.makeViewController()
        progressViewController.message = "Exporting"
        return progressViewController
    }

    static func createConfiguration() -> VideoEditorConfig {
        var config = VideoEditorConfig()

        AudioBrowserConfig.shared.musicSource = .localStorageWithMyFiles
        

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
