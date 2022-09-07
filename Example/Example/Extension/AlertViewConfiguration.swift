import UIKit
import BanubaVideoEditorSDK

extension ViewController {
  func updateAlertViewConfiguration(_ configuration: AlertViewConfiguration) -> AlertViewConfiguration {
    var config = configuration
    config.cornerRadius = 7.0
    config.agreeButtonRadius = 4.0
    config.refuseButtonRadius = 4.0
    config.refuseButtonTextConfig = TextButtonConfiguration(
      style: TextConfiguration(
        font: UIFont.systemFont(ofSize: 16.0),
        color: UIColor.white
      ),
      text: nil
    )
    config.agreeButtonTextConfig = TextButtonConfiguration(
      style: TextConfiguration(
        font: UIFont.systemFont(ofSize: 16.0),
        color: UIColor.white
      ),
      text: nil
    )
    config.refuseButtonBackgroundColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    config.agreeButtonBackgroundColor = #colorLiteral(red: 0.07058823529, green: 0.1490196078, blue: 0.2274509804, alpha: 1)
    
    config.titleTextConfig = TextConfiguration(
      kern: .zero,
      font: UIFont.boldSystemFont(ofSize: 22.0),
      color: .black,
      alignment: .center,
      text: nil,
      shadow: nil
    )
    config.additionalButtonRadius = 4.0
    config.additionalButtonBackgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    config.refuseButtonBorderConfiguration = BorderButtonConfiguration(
      borderWidth: .zero,
      borderColor: UIColor.clear.cgColor
    )
    config.agreeButtonBorderConfiguration = BorderButtonConfiguration(
      borderWidth: .zero,
      borderColor: UIColor.clear.cgColor
    )
    config.additionalButtonBorderConfiguration = BorderButtonConfiguration(
      borderWidth: .zero,
      borderColor: UIColor.clear.cgColor
    )
    config.additionalButtonTextConfig = TextButtonConfiguration(
      style: TextConfiguration(
        font: UIFont.boldSystemFont(ofSize: 15.0),
        color: .black
      ),
      text: nil
    )
    config.preferredStatusBarStyle = .default

    return config
  }
}
