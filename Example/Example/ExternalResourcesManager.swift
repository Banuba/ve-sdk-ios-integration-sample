//
//  ExternalResourcesManager.swift
//  Example
//
//  Created by Andrey Sak on 18.10.24.
//

import BNBSdkCore
import BanubaUtilities

class ExternalResourcesManager {
    
    static let shared = ExternalResourcesManager()
    
    private init() {}
    
    let fileManager = FileManager.default
    
    var resourcesBundleLocalURL: URL {
        let applicationSupportRoot = fileManager.urls(
            for: .applicationSupportDirectory,
            in: .userDomainMask
        ).last!
        return applicationSupportRoot.appendingPathComponent("bnb-resources", isDirectory: true)
    }
    
    func prepareResources() {
        guard let zipURL = Bundle.main.url(forResource: "bnb-resources", withExtension: "zip") else {
            print("Unable to locate zip file")
            return
        }
        
        if !fileManager.fileExists(atPath: resourcesBundleLocalURL.path) {
            
            let isSuccess = SSZipArchive.unzipFile(
                atPath: zipURL.path,
                toDestination: resourcesBundleLocalURL.path
            )
            
            if !isSuccess {
                print("Unable to unarchive zip file")
                return
            }
        }
    }
}
