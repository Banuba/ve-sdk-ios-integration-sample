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
import BanubaAudioBrowserSDK

/// Music editor view controller factory example
class MusicEditorViewControllerFactory: MusicEditorExternalViewControllerFactory {

  // Track audio browser feature enabled
  weak var videoEditorSDK: BanubaVideoEditor?
  
  private var isAudioBrowserEnabled: Bool {
    return videoEditorSDK?.currentConfiguration.featureConfiguration.isAudioBrowserEnabled ?? false
  }
  
  func makeTrackSelectionViewController(selectedAudioItem: AudioItem?) -> TrackSelectionViewController? {
    if isAudioBrowserEnabled {
      return makeAudioBrowserViewController(selectedAudioItem: selectedAudioItem)
    }
    let controller = UIStoryboard(
      name: "TrackSelection",
      bundle: Bundle(for: TrackPickerViewController.self)
    ).instantiateInitialViewController() as! TrackPickerViewController
    return controller
  }
  
  private func makeAudioBrowserViewController(selectedAudioItem: AudioItem?) -> EditorNavigationController {
    var selectedAudioBrowserTrack: AudioBrowserTrack?
    
    if let selectedAudioItem = selectedAudioItem {
      selectedAudioBrowserTrack = AudioBrowserTrack(
        id: Int32(truncating: NSNumber(value: selectedAudioItem.id)),
        name: selectedAudioItem.title ?? "",
        url: selectedAudioItem.url
      )
    }
    
    let browser = BanubaAudioBrowser(
      audioService: AudioBrowserService(),
      audioBrowserConfig: AudioBrowserConfig(),
      slideInTransitioningDelegate: SlideInPresentationManager(
        coverPercentage: 0.8, panToDismiss: true
      ),
      selectedTrack: selectedAudioBrowserTrack
    )
    
    let browserController = browser.getAudioBrowserController()
    return browserController
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
