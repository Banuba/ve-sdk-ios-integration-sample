import UIKit
import AVKit
import Photos
import BSImagePicker
import BanubaLicenseServicingSDK
import BanubaVideoEditorSDK

// Picking media from gallery, previewing images and exported video, and handling export results.
extension ExampleViewController {
    func showExportResult(
        videoUrl: URL,
        exportCoverImages: ExportCoverImages?
    ) {
        // Demo: alert with option to play the exported video.
        let alertController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .alert
        )

        let previewButton = UIAlertAction(title: "Play Video", style: .default) { _ in
            self.playVideo(at: videoUrl)
        }
        let cancelButton = UIAlertAction(title: "Close", style: .destructive)

        alertController.addAction(previewButton)
        alertController.addAction(cancelButton)

        present(alertController, animated: true)
    }

    func playVideo(at videoURL: URL) {
        let player = AVPlayer(url: videoURL)
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
        }
    }

    func pickerGalleryVideos(
        entryPoint: PresentEventOptions.EntryPoint,
        completion: @escaping (_ videoUrls: [URL]) -> Void
    ) {
        pickGalleryVideo { assets in
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
        completion: @escaping ([PHAsset]?) -> Void
    ) {
        let imagePicker = ImagePickerController()

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

    func previewImage(_ image: UIImage) {
        let preview = ImagePreviewController(image: image)
        preview.modalPresentationStyle = .pageSheet
        if let sheet = preview.sheetPresentationController {
            sheet.detents = [
                .large()
            ]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 16
        }
        present(preview, animated: true, completion: nil)
    }

    final class ImagePreviewController: UIViewController {

        private let image: UIImage
        private let imageView = UIImageView()
        private let closeButton = UIButton(type: .system)

        // Designated initializer
        init(image: UIImage) {
            self.image = image
            super.init(nibName: nil, bundle: nil)
            modalPresentationStyle = .pageSheet
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewDidLoad() {
            super.viewDidLoad()

            view.backgroundColor = .white

            // Configure image view
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(imageView)

            // Configure close button
            closeButton.setTitle("Close", for: .normal)
            closeButton.tintColor = .systemBlue
            closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
            closeButton.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(closeButton)

            NSLayoutConstraint.activate([
                // Image view constraints
                imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),

                // Close button constraints
                closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
                closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            ])
        }

        @objc private func didTapClose() {
            dismiss(animated: true, completion: nil)
        }
    }
}
