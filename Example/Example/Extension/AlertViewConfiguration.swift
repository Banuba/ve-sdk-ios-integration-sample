import UIKit
import BanubaVideoEditorSDK

extension ViewController {
  func updateAlertViewConfiguration(_ configuration: AlertViewConfiguration) -> AlertViewConfiguration {
    var config = configuration
    config.cornerRadius = 7.0
    config.refuseButtonRadius = 4.0
    config.agreeButtonRadius = 4.0

    config.refuseButtonBackgroundColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    config.agreeButtonBackgroundColor = #colorLiteral(red: 0.07058823529, green: 0.1490196078, blue: 0.2274509804, alpha: 1)
    
    config.refuseButtonTextConfig = TextButtonConfiguration(
      style: TextConfiguration(
        font: UIFont.systemFont(ofSize: 16.0),
        color: .white
      )
    )
    config.agreeButtonTextConfig = TextButtonConfiguration(
      style: TextConfiguration(
        font: UIFont.systemFont(ofSize: 16.0),
        color: .white
      )
    )
    
    config.titleTextConfig = TextConfiguration(
      font: UIFont.boldSystemFont(ofSize: 22.0),
      color: .blue
    )
    
    return config
  }
}
