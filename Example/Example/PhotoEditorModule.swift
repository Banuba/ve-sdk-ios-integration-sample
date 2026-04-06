import BanubaPhotoEditorSDK

final class PhotoEditorModule: BanubaPhotoEditorDelegate {

    /// Callback for handling editing result
    let onPhotoEditingFinished: (UIImage) -> Void

    let photoEditorSDK: BanubaPhotoEditor

    init?(token: String, onPhotoEditingFinished: @escaping (UIImage) -> Void) {
        self.onPhotoEditingFinished = onPhotoEditingFinished

        let configuration = PhotoEditorConfig()

        guard let photoEditorSDK = BanubaPhotoEditor(
            token: token,
            configuration: configuration
        ) else {
            return nil
        }

        self.photoEditorSDK = photoEditorSDK
        photoEditorSDK.delegate = self
    }

    func getLicenseState(completion: @escaping (_ isValid: Bool) -> Void) {
        photoEditorSDK.getLicenseState(completion: completion)
    }

    func presentPhotoEditor(with launchConfig: PhotoEditorLaunchConfig) {
        photoEditorSDK.presentPhotoEditor(
            withLaunchConfiguration: launchConfig,
            completion: nil
        )
    }

    // MARK: - BanubaPhotoEditorDelegate
    func photoEditorDidCancel(_ photoEditor: BanubaPhotoEditor) {
        photoEditor.dismissPhotoEditor(animated: true, completion: nil)
    }

    func photoEditorDidFinishWithImage(_ photoEditor: BanubaPhotoEditor, image: UIImage) {
        photoEditor.dismissPhotoEditor(animated: true) {
            self.onPhotoEditingFinished(image)
        }
    }
}
