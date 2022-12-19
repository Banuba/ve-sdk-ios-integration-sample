import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  /// Video editor requires token. Please follow steps described in https://github.com/Banuba/ve-sdk-ios-integration-sample#token
  static let banubaClientToken: String = <#Please set your Banuba Video Editor SDK token here#>
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return true
  }
}

