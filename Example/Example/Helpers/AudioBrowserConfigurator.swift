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
    AudioBrowserConfig.shared.mubertAudioConfig.pat = "Put Mubert PAT"
  }
}
