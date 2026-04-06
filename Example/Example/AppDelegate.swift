import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  // License token is required to start Video Editor SDK
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

