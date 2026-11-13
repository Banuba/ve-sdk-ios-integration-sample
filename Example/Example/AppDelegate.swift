import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  // Set a license token to start Video Editor SDK or Photo Editor SDK.
  static let licenseToken: String = <#Enter your license token#>
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return true
  }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
}

