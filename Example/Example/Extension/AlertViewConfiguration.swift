import UIKit
import BanubaVideoEditorSDK

extension ViewController {
  func updateAlertViewConfiguration(_ configuration: AlertViewConfiguration) -> AlertViewConfiguration {
    var config = configuration
    config.cornerRadius = 7.0
    config.buttonRadius = 4.0
    config.refuseButtonTextColor = UIColor.white
    config.refuseButtonBackgroundColor = UIColor.green
    config.agreeButtonBackgroundColor = UIColor.yellow
    config.agreeButtonTextColor = UIColor.black
    config.titleAligment = .center
    config.titleFont = UIFont.boldSystemFont(ofSize: 22.0)
    config.buttonsFont = UIFont.systemFont(ofSize: 16.0)
    return config
  }
}
