import BanubaPhotoEditorSDKLight
import BNBSdkCore

class PhotoEditorModule {
    var photoEditorSDK: BanubaPhotoEditor?
    
    init(token: String) {
        let configuration = PhotoEditorConfig(
            previewScreenMode: .disabled,
            beautyMaskURL: ExternalResourcesManager.shared.resourcesBundleLocalURL.appendingPathComponent("photo_editor"),
            effectPlayerResourcesURL: ExternalResourcesManager.shared.resourcesBundleLocalURL.appendingPathComponent("photo_editor/Resources")

        )
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
}
