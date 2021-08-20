//
//  VideoPicker.swift
//  Example
//
//  Created by Ruslan Filistovich on 20.08.21.
//

import UIKit
import Photos
import BSImagePicker

class VideoPicker {
  func pickVideo(
    isMultipleSelectionEnabled: Bool = true,
    from controller: UIViewController,
    withCompletion completion: @escaping ([PHAsset]?) -> Void
  ) {
    let imagePicker = ImagePickerController()
    if !isMultipleSelectionEnabled {
      imagePicker.settings.selection.max = 1
    }
    imagePicker.settings.fetch.assets.supportedMediaTypes = [.video]
    
    controller.presentImagePicker(
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
