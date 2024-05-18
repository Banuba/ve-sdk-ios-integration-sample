import BNBSdkCore
import UnifiedVideoEditorSDK

class FaceARResourcesDownloader {
    let resourceBundleUrl: URL
    let resourceBundleName: String
    
    init(resourceBundleUrl: URL) {
        self.resourceBundleUrl = resourceBundleUrl
        resourceBundleName = resourceBundleUrl.deletingPathExtension().lastPathComponent
    }
    
    func downloadResources(force: Bool = false) async throws {
        let fileManager = FileManager.default
        let applicationSupportRoot = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).last!
        let resourceBundleLocalUrl = applicationSupportRoot.appendingPathComponent(resourceBundleName, isDirectory: true)
        BNBUtilityManager.addResourcePath(resourceBundleLocalUrl.path)

        var isDirectory: ObjCBool = true
        if fileManager.fileExists(atPath: resourceBundleLocalUrl.path, isDirectory: &isDirectory),
            isDirectory.boolValue {
            if force {
                try? fileManager.removeItem(at: resourceBundleLocalUrl)
            } else {
                // Skipping the download as resource bundle is already present
                return
            }
        }
        print("Starting to download the resource bundle...")
        
        let request = URLRequest(url: resourceBundleUrl)
        let (tmpUrl, response) = try await URLSession.shared.download(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        try await ZipArchive.unzip(at: tmpUrl, destination: resourceBundleLocalUrl, overwrite: true)
        
        try? fileManager.removeItem(at: tmpUrl)
        
        print("Succesfully finished the download!")
    }
}
