import BanubaPhotoEditorSDKLight
import BNBSdkCore

class PhotoEditorModule {
    var photoEditorSDK: BanubaPhotoEditor?
    
    init(token: String) {
        let configuration = PhotoEditorConfig(
            previewScreenMode: .disabled,
            resourcesURL: ExternalResourcesManager.shared.resourcesBundleLocalURL
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
