//
//  AudioBrowserConfigurator.swift
//  VideoEditorSDKSandbox
//
//  Created by Andrei Sak on 17.11.20.
//  Copyright © 2020 Banuba. All rights reserved.
//

import BanubaAudioBrowserSDK
import BanubaMusicEditorSDK
import UIKit

struct AudioBrowserConfigurator {
  static func configure() {
    // If you don't want to use external music source disable the follow property
    AudioBrowserConfig.shared.isExternalMusicEnabled = false
    // Otherwise enable previous property and specify for example Mubert PAT
    AudioBrowserConfig.shared.mubertAudioConfig.pat = "Put Mubert PAT"
  }
}
