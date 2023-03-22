//
//  VideoPicker.swift
//  Example
//
//  Created by Banuba on 22.03.23.
//

import UIKit
import Photos
import BSImagePicker

extension UIViewController {
  func pickVideo(
    isMultiSelectionEnabled: Bool,
    completion: @escaping ([PHAsset]?) -> Void
  ) {
    let imagePicker = ImagePickerController()
    
    imagePicker.settings.fetch.assets.supportedMediaTypes = [.video]
    imagePicker.settings.selection.max = isMultiSelectionEnabled ? Int.max : 1
    
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
}
