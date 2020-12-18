//
//  AudioBrowserAdoptor.swift
//  VideoEditorSDKSandbox
//
//  Created by Andrei Sak on 17.11.20.
//  Copyright © 2020 Banuba. All rights reserved.
//

import BanubaAudioBrowserSDK
import BanubaMusicEditorSDK
import UIKit

// Adopt audio browser to TrackSelectionViewController
extension EditorNavigationController: TrackSelectionViewController {
  private static var trackSelectionDelegateProxy = TrackSelectionDelegateProxy()
  public var trackSelectionDelegate: TrackSelectionViewControllerDelegate? {
    get {
      return EditorNavigationController.trackSelectionDelegateProxy.trackSelectionDelegate
    }
    set {
      EditorNavigationController.trackSelectionDelegateProxy.trackSelectionDelegate = newValue
      EditorNavigationController.trackSelectionDelegateProxy.editorController = self
      navigationDelegate = EditorNavigationController.trackSelectionDelegateProxy
    }
  }
  
  class TrackSelectionDelegateProxy: UIViewController, TrackSelectionViewController, AudioBrowserSelectionViewControllerDelegate {
    
    public var trackSelectionDelegate: TrackSelectionViewControllerDelegate?
    weak var editorController: EditorNavigationController?
    
    func audioBrowserSelectionViewController(
      viewController: AudioBrowserSelectionViewController,
      didSelectFile url: URL,
      title: String,
      id: Int32
    ) {
      guard let editorController = editorController else {
        return
      }
      trackSelectionDelegate?.trackSelectionViewController(
        viewController: editorController,
        didSelectFile: url,
        title: title,
        id: Int64(id)
      )
    }
    
    func audioBrowserSelectionViewControllerDidCancel(viewController: AudioBrowserSelectionViewController) {
      guard let editorController = editorController else {
        return
      }
      trackSelectionDelegate?.trackSelectionViewControllerDidCancel(viewController: editorController)
    }
    
    func audioBrowserSelectionViewController(
      viewController: AudioBrowserSelectionViewController,
      didStopUsingTrackWithId trackId: Int32
    ) {
      guard let editorController = editorController else {
        return
      }
      trackSelectionDelegate?.trackSelectionViewController(
        viewController: editorController,
        didStopUsingTrackWithId: trackId
      )
    }
  }
}
