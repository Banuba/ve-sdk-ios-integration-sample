//
//  ViewControllerFactory.swift
//  VideoEditorSDKSandbox
//
//  Created by Andrei Sak on 17.11.20.
//  Copyright © 2020 Banuba. All rights reserved.
//

import BanubaMusicEditorSDK
import BanubaVideoEditorSDK

/// Example video editor view controller factory
class ViewControllerFactory: ExternalViewControllerFactory {
  var musicEditorFactory: MusicEditorExternalViewControllerFactory?
  var countdownTimerViewFactory: CountdownTimerViewFactory?
  var exposureViewFactory: AnimatableViewFactory?
}
