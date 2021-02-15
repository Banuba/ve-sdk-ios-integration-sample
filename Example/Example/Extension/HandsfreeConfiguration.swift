extension ViewController {
  private func updateHandsfreeConfiguration(_ configuration: HandsfreeConfiguration?) -> HandsfreeConfiguration? {
    guard var config = configuration else { return nil }
    config.timerOptionBarConfiguration.disableOptionTitle = "Off"
    config.timerOptionBarConfiguration.selectorColor = UIColor.yellow
    config.timerOptionBarConfiguration.selectorTextColor = UIColor.black
    config.timerOptionBarConfiguration.optionBackgroundColor = UIColor.clear
    config.timerOptionBarConfiguration.optionCornerRadius = 0.0
    config.timerOptionBarConfiguration.optionTextColor = UIColor.white
    config.timerOptionBarConfiguration.backgroundColor = UIColor.black
    config.timerOptionBarConfiguration.cornerRadius = 8.0
    config.timerOptionBarConfiguration.sliderCornerRadius = 8.0
    config.timerOptionBarConfiguration.barCornerRadius = 4.0
    config.timerOptionBarConfiguration.selectorEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    config.timerOptionBarConfiguration.activeThumbAndLineColor = UIColor.yellow
    config.timerOptionBarConfiguration.inactiveThumbAndLineColor = UIColor.white
    config.timerOptionBarConfiguration.minVideoDuration = 1.0
    config.timerOptionBarConfiguration.buttonCornerRadius = 20.0
    config.timerOptionBarConfiguration.buttonBackgroundColor = UIColor.yellow
    config.timerOptionBarConfiguration.switchOnTintColor = #colorLiteral(red: 1, green: 0.7529411765, blue: 0.01176470588, alpha: 0.3034032534)
    return config
  }
}
