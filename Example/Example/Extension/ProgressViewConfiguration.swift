import BanubaVideoEditorSDK

extension ViewController {
  func updateProgressViewConfiguration(_ configuration: ProgressViewConfiguration) -> ProgressViewConfiguration {
    configuration.progressBarColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    configuration.progressBarHeight = 2.0
    configuration.progressBarCornerRadius = 1.0
    
    configuration.cancelButtonBorderConfiguration.borderColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    configuration.cancelButtonTextConfiguration.style.color = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    
    configuration.messageConfiguration.color = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    configuration.tooltipMessageConfiguration.color = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    
    return configuration
  }
}
