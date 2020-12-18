//
//  CountdownTimerViewControllerFactory.swift
//  VideoEditorSDKSandbox
//
//  Created by Andrei Sak on 17.11.20.
//  Copyright © 2020 Banuba. All rights reserved.
//

import BanubaVideoEditorSDK
import BanubaMusicEditorSDK
import Lottie

// Adopting CountdownView to using in BanubaMusicEditorSDK
extension CountdownView: MusicEditorCountdownAnimatableView {}

/// Example countdown timer view factory
class CountdownTimerViewControllerFactory: CountdownTimerViewFactory {
  func makeCountdownTimerView() -> CountdownTimerAnimatableView {
    guard let lottieAnimationFilePath = Bundle.main.path(forResource: "data", ofType: "json", inDirectory: "LottieAnimation") else {
        fatalError("Wrong Lottie file path")
    }
    let animationView = AnimationView(filePath: lottieAnimationFilePath)
    return animationView
  }
}
