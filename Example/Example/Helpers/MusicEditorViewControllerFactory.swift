//
//  MusicEditorViewControllerFactory.swift
//  VideoEditorSDKSandbox
//
//  Created by Andrei Sak on 17.11.20.
//  Copyright © 2020 Banuba. All rights reserved.
//

import BanubaMusicEditorSDK
import BanubaVideoEditorSDK
import UIKit

/// Music editor view controller factory example
class MusicEditorViewControllerFactory: MusicEditorExternalViewControllerFactory {

  func makeTrackSelectionViewController(selectedAudioItem: AudioItem?) -> TrackSelectionViewController? {
    let controller = UIStoryboard(
      name: "TrackSelection",
      bundle: Bundle(for: TrackPickerViewController.self)
    ).instantiateInitialViewController() as! TrackPickerViewController
    return controller
  }
  
  func makeEffectSelectionViewController(selectedAudioItem: AudioItem?) -> EffectSelectionViewController? {
    let controller = UIStoryboard(
      name: "EffectSelection",
      bundle: Bundle(for: EffectPickerViewController.self)
    ).instantiateInitialViewController() as! EffectPickerViewController
    return controller
  }
  
  func makeRecorderCountdownAnimatableView() -> MusicEditorCountdownAnimatableView? {
    let countdownView = CountdownView()
    countdownView.font = countdownView.font.withSize(22.0)
    countdownView.digitColor = #colorLiteral(red: 1, green: 0.7529411765, blue: 0.01176470588, alpha: 1)
    return countdownView
  }
}
