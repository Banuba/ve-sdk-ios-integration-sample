import UIKit
import BanubaVideoEditorSDK
import BanubaPhotoEditorSDK
import BanubaLicenseServicingSDK

class ExampleViewController: UIViewController {

    private struct ErrorStrings {
        static let photoEditorNotInitialized = "Banuba Photo Editor SDK is not initialized: license token is unknown or incorrect.\nPlease check your license token or contact Banuba"
        static let videoEditorNotInitialized = "Banuba Video Editor SDK is not initialized: license token is unknown or incorrect.\nPlease check your license token or contact Banuba"
        static let licenseRevokedOrExpired = "License is revoked or expired. Please contact Banuba https://www.banuba.com/support"
    }

    // MARK: - IBOutlet
    @IBOutlet weak var invalidTokenMessageLabel: UILabel!

    // MARK: - PhotoEditorSDK
    private var photoEditorModule: PhotoEditorModule?

    // MARK: - VideoEditorSDK
    private var videoEditorModule: VideoEditorModule?

    // MARK: - Use cases
    // Backward-compatible selectors for storyboard actions.
    @IBAction func openVideoEditorNewUI(_ sender: Any) {
        openNewVideoEditorNewUI(sender)
    }

    @IBAction func openPhotoEditorFromGallery(_ sender: Any) {
        openPhotoEditorDefault(sender)
    }

    @IBAction func openPhotoEditorFromEditor(_ sender: Any) {
        openPhotoEditorImage(sender)
    }

    @IBAction func openNewVideoEditorNewUI(_ sender: Any) {
        let launchConfig = VideoEditorLaunchConfig(
            entryPoint: .camera,
            hostController: self,
            animated: true
        )
        checkLicenseAndOpenVideoEditor(with: launchConfig, isEditorV2Enabled: true)
    }

    @IBAction func openVideoEditorDefault(_ sender: Any) {
        let launchConfig = VideoEditorLaunchConfig(
            entryPoint: .camera,
            hostController: self,
            animated: true
        )
        checkLicenseAndOpenVideoEditor(with: launchConfig)
    }

    @IBAction func openVideoEditorTemplates(_ sender: Any) {
        let launchConfig = VideoEditorLaunchConfig(
            entryPoint: .videoTemplates,
            hostController: self,
            animated: true
        )
        checkLicenseAndOpenVideoEditor(with: launchConfig)
    }

    @IBAction func openVideoEditorPiP(_ sender: Any) {
        let launchConfig = VideoEditorLaunchConfig(
            entryPoint: .camera,
            hostController: self,
            animated: true
        )
        checkLicenseAndOpenVideoEditor(with: launchConfig)
    }

    @IBAction func openVideoEditorDrafts(_ sender: UIButton) {
        let launchConfig = VideoEditorLaunchConfig(
            entryPoint: .drafts,
            hostController: self,
            animated: true
        )
        checkLicenseAndOpenVideoEditor(with: launchConfig)
    }

    @IBAction func openVideoEditorTrimmer(_ sender: UIButton) {
        pickerGalleryVideos(entryPoint: .trimmer) { [weak self] pickedVideoUrls in
            guard let self, !pickedVideoUrls.isEmpty else { return }

            let launchConfig = VideoEditorLaunchConfig(
                entryPoint: .trimmer,
                hostController: self,
                videoItems: pickedVideoUrls,
                animated: true
            )
            self.checkLicenseAndOpenVideoEditor(with: launchConfig)
        }
    }

    @IBAction func openPhotoEditorDefault(_ sender: Any) {
        let launchConfig = PhotoEditorLaunchConfig(
            hostController: self,
            entryPoint: .gallery
        )
        checkLicenseAndOpenPhotoEditor(with: launchConfig)
    }

    @IBAction func openPhotoEditorImage(_ sender: Any) {
        pickGalleryPhoto() { image in
            guard let image else { return }
            let launchConfig = PhotoEditorLaunchConfig(
                hostController: self,
                entryPoint: .editorWithImage(image)
            )
            self.checkLicenseAndOpenPhotoEditor(with: launchConfig)
        }
    }

    private func checkLicenseAndOpenPhotoEditor(with launchConfig: PhotoEditorLaunchConfig) {
        // Deallocate any active instances of both editors to free used resources
        // and to prevent "You are trying to create the second instance of the singleton." crash
        photoEditorModule = nil
        videoEditorModule = nil

        let photoEditorModule = PhotoEditorModule(
            token: AppDelegate.licenseToken,
            onPhotoEditingFinished: { [weak self] image in
                guard let self else { return }
                self.previewImage(image)
            }
        )

        guard let photoEditorModule else {
            handleFailedInitialization(message: ErrorStrings.photoEditorNotInitialized)
            return
        }

        photoEditorModule.getLicenseState(completion: { [weak self] isValid in
            self?.handleTokenValidationResult(isValid)
            if isValid { self?.photoEditorModule?.presentPhotoEditor(with: launchConfig) }
        })

        self.photoEditorModule = photoEditorModule
    }

    private func checkLicenseAndOpenVideoEditor(with launchConfig: VideoEditorLaunchConfig, isEditorV2Enabled: Bool = false) {
        // Deallocate any active instances of both editors to free used resources
        // and to prevent "You are trying to create the second instance of the singleton." crash
        photoEditorModule = nil
        videoEditorModule = nil

        let videoEditorModule = VideoEditorModule(
            token: AppDelegate.licenseToken,
            isEditorV2Enabled: isEditorV2Enabled,
            onVideoEditingFinished: { exportResult in
                switch exportResult {
                case .success((let videoUrl, let exportCoverImages)):
                    self.showExportResult(videoUrl: videoUrl, exportCoverImages: exportCoverImages)
                case .failure(let error):
                    print("Video editing finished with error: \(error)")
                }
            }
        )

        guard let videoEditorModule else {
            handleFailedInitialization(message: ErrorStrings.videoEditorNotInitialized)
            return
        }

        videoEditorModule.getLicenseState(completion: { [weak self] isValid in
            self?.handleTokenValidationResult(isValid)
            if isValid { self?.videoEditorModule?.presentVideoEditor(with: launchConfig) }
        })

        self.videoEditorModule = videoEditorModule
    }

    // MARK: - Token validation handling
    private func handleTokenValidationResult(_ isValid: Bool) {
        if isValid {
            print("✅ License is active, all good")
        } else {
            print("❌ License is either revoked or expired")
        }
        invalidTokenMessageLabel.text = isValid ? "" : ErrorStrings.licenseRevokedOrExpired
        invalidTokenMessageLabel.isHidden = isValid
    }

    private func handleFailedInitialization(message: String) {
        invalidTokenMessageLabel.text = message
        invalidTokenMessageLabel.isHidden = false
    }
}
