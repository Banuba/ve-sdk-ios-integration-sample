//
//  PhotoEditorModule.swift
//  Example
//
//  Created by Ivan Ghulidau on 5.03.24.
//

import BanubaPhotoEditorSDK

class PhotoEditorModule {
  var photoEditorSDK: BanubaPhotoEditor?
  
  init(token: String) {
    let configuration = PhotoEditorConfig()
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
