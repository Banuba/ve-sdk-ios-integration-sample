//
//  AnalyticsExample.swift
//  VideoEditorSDKSandbox
//
//  Created by Andrei Sak on 17.11.20.
//  Copyright © 2020 Banuba. All rights reserved.
//

import BanubaVideoEditorSDK

/// Example AnalyticsEngine which just prints events
class Analytics: AnalyticsEngine {
  func report(error: Error, message: String) {
    print("Analytic: [Error:\(message)]")
  }
  
  func report(message: String, parameters: [String : Any]?) {
    print("Analytic: [Message:\(message); Params:\(parameters ?? [:])]")
  }
}
