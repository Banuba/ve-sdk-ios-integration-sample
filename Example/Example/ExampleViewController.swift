import UIKit
import Photos
import BSImagePicker
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
    private var photoEditorSDK: BanubaPhotoEditor?
    private var photoEditorHandler: PhotoEditorHandler?
    
    // MARK: - VideoEditorSDK
    private var editorSDK: VideoEditorSDK?
    private var editorHandler: VideoEditorHandler?
    
    // MARK: - Video Editor SDK Handler
    // Step 5: Handle Video Editor export and close callbacks.
    private final class VideoEditorHandler: VideoEditorSDKDelegate {
        weak var hostController: ExampleViewController?
        
        init(_ hostController: ExampleViewController) {
            self.hostController = hostController
        }
        
        func videoEditorClose() {
            hostController?.releaseSDK()
        }
        
        func videoEditorExportDone(with videoUrls: [URL], error: (any Error)?, coverImages: BanubaVideoEditorSDK.ExportCoverImages?) {
            if let error {
                print("Video Editor finish export with error: \(error)")
                return
            }
            
            if let firstVideo = videoUrls.first {
                guard let hostController else { return }
                hostController.showExportResult(videoUrl: firstVideo)
            }
        }
    }
    
    // MARK: - Photo Editor SDK Handler
    // Handle Photo Editor cancellation and preview its exported image.
    private final class PhotoEditorHandler: BanubaPhotoEditorDelegate {
        weak var hostViewController: ExampleViewController?
        
        init(hostViewController: ExampleViewController) {
            self.hostViewController = hostViewController
        }
        
        func photoEditorDidCancel(_ photoEditor: BanubaPhotoEditor) {
            photoEditor.dismissPhotoEditor(animated: true) { [weak self] in
                self?.hostViewController?.releaseSDK()
            }
        }
        
        func photoEditorDidFinishWithImage(_ photoEditor: BanubaPhotoEditor, image: UIImage) {
            photoEditor.dismissPhotoEditor(animated: true) {
                guard let hostViewController = self.hostViewController,
                      let data = image.pngData() else {
                    return
                }
                
                // The preview helper takes a URL, so save the image to a temporary file.
                let imageURL = FileManager.default.temporaryDirectory.appendingPathComponent("\(UUID().uuidString).png")
                do {
                    try data.write(to: imageURL, options: .atomic)
                    SdkIntegrationUtils.previewExportedImage(view: hostViewController, at: imageURL)
                } catch {
                    print("Couldn't save image: \(error)")
                }
            }
        }
    }
    
    // MARK: - Use cases
    // Step 4: Launch the Video Editor from the selected entry point.
    // Launch the camera flow with Editor V2 enabled.
    @IBAction func openNewVideoEditorNewUI(_ sender: Any) {
        let launchConfig = VideoEditorLaunchConfig(
            entryPoint: .camera,
            hostController: self,
            animated: true
        )
        checkLicenseAndOpenVideoEditor(with: launchConfig, isEditorV2Enabled: true)
    }
    
    // Launch the default camera flow.
    @IBAction func openVideoEditorDefault(_ sender: Any) {
        let launchConfig = VideoEditorLaunchConfig(
            entryPoint: .camera,
            hostController: self,
            animated: true
        )
        checkLicenseAndOpenVideoEditor(with: launchConfig)
    }
    
    // Open the video templates screen.
    @IBAction func openVideoEditorTemplates(_ sender: Any) {
        let launchConfig = VideoEditorLaunchConfig(
            entryPoint: .videoTemplates,
            hostController: self,
            animated: true
        )
        checkLicenseAndOpenVideoEditor(with: launchConfig)
    }
    
    // Pick a video and prefill the camera's picture-in-picture layout.
    @IBAction func openVideoEditorPiP(_ sender: Any) {
        pickerGalleryVideos(entryPoint: .camera) { [weak self] pickedVideoUrls in
            guard let self, let pipVideoUrl = pickedVideoUrls.first else { return }
            
            let launchConfig = VideoEditorLaunchConfig(
                entryPoint: .camera,
                hostController: self,
                cameraLayout: .init(layout: .pipLeft, payload: .media(pipVideoUrl)),
                animated: true
            )
            self.checkLicenseAndOpenVideoEditor(with: launchConfig)
        }
    }
    
    // Open saved drafts.
    @IBAction func openVideoEditorDrafts(_ sender: UIButton) {
        let launchConfig = VideoEditorLaunchConfig(
            entryPoint: .drafts,
            hostController: self,
            animated: true
        )
        checkLicenseAndOpenVideoEditor(with: launchConfig)
    }
    
    // Pick videos to open directly in the trimmer.
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
    
    // Photo Editor entry points: open its gallery or edit a selected image.
    @IBAction func openPhotoEditorDefault(_ sender: UIButton) {
        let launchConfig = PhotoEditorLaunchConfig(
            hostController: self,
            entryPoint: .gallery
        )
        checkLicenseAndOpenPhotoEditor(with: launchConfig)
    }
    
    // Pick one image to edit in Photo Editor.
    @IBAction func openPhotoEditorImage(_ sender: UIButton) {
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
        releaseSDK()
        
        // Configure and initialize Photo Editor SDK with the license token.
        let config = PhotoEditorConfig()
        
        let photoEditorSDK = BanubaPhotoEditor(
            token: AppDelegate.licenseToken,
            configuration: config
        )
        
        guard let photoEditorSDK else {
            handleFailedInitialization(message: ErrorStrings.photoEditorNotInitialized)
            return
        }
        
        self.photoEditorSDK = photoEditorSDK
        let photoEditorHandler = PhotoEditorHandler(hostViewController: self)
        
        // The SDK holds its delegate weakly; retain the handler to receive callbacks.
        self.photoEditorHandler = photoEditorHandler
        photoEditorSDK.delegate = photoEditorHandler
        
        // Check the license asynchronously before presenting Photo Editor.
        photoEditorSDK.getLicenseState(completion: { [weak self] isValid in
            self?.handleTokenValidationResult(isValid)
            // Present Photo Editor only when the license is active.
            if isValid { self?.photoEditorSDK?.presentPhotoEditor(withLaunchConfiguration: launchConfig, completion: nil) }
        })
        
        self.photoEditorSDK = photoEditorSDK
    }
    
    private func checkLicenseAndOpenVideoEditor(with launchConfig: VideoEditorLaunchConfig, isEditorV2Enabled: Bool = false) {
        // Deallocate any active instances of both editors to free used resources
        // and to prevent "You are trying to create the second instance of the singleton." crash
        releaseSDK()
        
        // Step 3: Configure and initialize Video Editor SDK with the license token.
        var featureConfiguration = VideoEditorConfig().featureConfiguration
        featureConfiguration.supportsTrimRecordedVideo = true
        
        let editorSDK = VideoEditorSDK.Builder()
            .setEditorV2Enabled(isEditorV2Enabled)
            .setAudioBrowserProvider(.local)
            .setFeatureConfiguration(featureConfiguration)
            .initialize(token: AppDelegate.licenseToken)
        
        guard let editorSDK else {
            handleFailedInitialization(message: ErrorStrings.videoEditorNotInitialized)
            return
        }
        
        self.editorSDK = editorSDK
        let handler = VideoEditorHandler(self)
        // The SDK holds its delegate weakly; retain the handler to receive callbacks.
        self.editorHandler = handler
        editorSDK.delegate = handler
        
        // Check the license asynchronously before launching Video Editor.
        editorSDK.getLicenseState { [weak self] isValid in
            self?.handleTokenValidationResult(isValid)
            // Step 4: Launch Video Editor only when the license is active.
            if isValid { self?.editorSDK?.launch(with: launchConfig) }
        }
    }
    
    private func releaseSDK() {
        photoEditorSDK = nil
        photoEditorHandler = nil
        editorSDK?.release()
        editorSDK = nil
        editorHandler = nil
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

// Picking media from gallery, previewing images and exported video, and handling export results.
extension ExampleViewController {
    func showExportResult(videoUrl: URL) {
        // Demo: alert with option to play the exported video.
        let alertController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .alert
        )
        
        let previewButton = UIAlertAction(title: "Play Video", style: .default) { _ in
            SdkIntegrationUtils.playExportedVideo(view: self, at: videoUrl)
        }
        let cancelButton = UIAlertAction(title: "Close", style: .destructive)
        
        alertController.addAction(previewButton)
        alertController.addAction(cancelButton)
        
        present(alertController, animated: true)
    }
    
    func pickerGalleryVideos(
        entryPoint: PresentEventOptions.EntryPoint,
        completion: @escaping (_ videoUrls: [URL]) -> Void
    ) {
        let limit = entryPoint == .camera ? 1 : nil
        pickGalleryVideo(limit: limit) { assets in
            guard let assets = assets else {
                return
            }
            
            var resultUrls: [URL] = []
            let group = DispatchGroup()
            assets.forEach { asset in
                group.enter()
                PHImageManager.default().requestAVAsset(
                    forVideo: asset,
                    options: .none
                ) { (asset, _, _) in
                    guard let asset = asset else {
                        group.leave()
                        return
                    }
                    
                    if let urlAsset = asset as? AVURLAsset {
                        resultUrls.append(urlAsset.url)
                        group.leave()
                        return
                    }
                    
                    guard let exportSession = AVAssetExportSession(
                        asset: asset,
                        presetName: AVAssetExportPresetHighestQuality
                    ) else {
                        group.leave()
                        return
                    }
                    
                    let manager = FileManager.default
                    let targetURL = manager.temporaryDirectory.appendingPathComponent("\(UUID().uuidString).mp4")
                    exportSession.outputURL = targetURL
                    exportSession.outputFileType = AVFileType.mp4
                    exportSession.shouldOptimizeForNetworkUse = true
                    
                    exportSession.exportAsynchronously {
                        DispatchQueue.main.async {
                            if exportSession.status == .completed {
                                let exportedAsset = AVURLAsset(url: targetURL)
                                resultUrls.append(exportedAsset.url)
                            }
                            group.leave()
                        }
                    }
                }
            }
            
            group.notify(queue: .main) {
                completion(resultUrls)
            }
        }
    }
    
    private func pickGalleryVideo(
        limit: Int?,
        completion: @escaping ([PHAsset]?) -> Void
    ) {
        let imagePicker = ImagePickerController()
        
        if let limit {
            imagePicker.settings.selection.max = limit
        }
        imagePicker.settings.fetch.assets.supportedMediaTypes = [.video]
        
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
    
    func pickGalleryPhoto(completion: @escaping (UIImage?) -> Void) {
        let imagePicker = ImagePickerController()
        
        imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
        imagePicker.settings.selection.max = 1
        
        self.presentImagePicker(
            imagePicker,
            select: nil,
            deselect: nil,
            cancel: { assets in
                completion(nil)
            }, finish: { assets in
                guard let asset = assets.first else {
                    completion(nil)
                    return
                }
                let options = PHImageRequestOptions()
                options.version = .current
                options.resizeMode = .exact
                options.deliveryMode = .highQualityFormat
                options.isNetworkAccessAllowed = true
                options.isSynchronous = true
                
                PHImageManager.default().requestImage(
                    for: asset,
                    targetSize: PHImageManagerMaximumSize,
                    contentMode: .aspectFit,
                    options: options) { image, _ in
                        completion(image)
                    }
            }
        )
    }
}
