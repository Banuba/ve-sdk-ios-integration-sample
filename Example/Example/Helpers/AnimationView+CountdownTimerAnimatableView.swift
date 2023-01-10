//
//  Animationview+CountdownTimerAnimatableView.swift
//  VideoEditorSDKSandbox
//
//  Created by Andrei Sak on 11/8/20.
//  Copyright © 2020 Banuba. All rights reserved.
//

import BanubaVideoEditorSDK
import Lottie

// Example countdown timer view using Lottie
extension LottieAnimationView: CountdownTimerAnimatableView {
  private static var _countdownDigit: Int = 0
  
  public var countdownDigit: Int {
    get {
      LottieAnimationView._countdownDigit
    }
    set {
      LottieAnimationView._countdownDigit = newValue
    }
  }
  
  public func start(completion: @escaping (Bool) -> Void) {
    guard let animation = animation else {
      fatalError("animation variable missed")
    }
    let framerate = animation.framerate
    let startFrame = AnimationFrameTime(Double(countdownDigit) * framerate)
    let endFrame = AnimationFrameTime(0.0)
    play(
      fromFrame: startFrame,
      toFrame: endFrame,
      completion: completion
    )
  }
  
  public func stop() {
    pause()
  }
}

