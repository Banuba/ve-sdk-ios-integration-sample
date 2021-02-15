extension ViewController {
  
  func updateSimpleVideoCoverSelectionConfiguration(_ configuration: SimpleVideoCoverSelectionConfiguration) -> SimpleVideoCoverSelectionConfiguration {
    var config = configuration
    
    config.cancelButton.text = "Cancel"
    config.doneButton.textConfiguration.text = "Done"
    config.toolTipLabel.text = "Text"
    config.sliderColor = UIColor.yellow
    config.sliderMinTrackTintColor = UIColor.gray
    config.sliderMaxTrackTintColor = UIColor.white
    config.backgroundConfiguration.color = UIColor.black
    
    return config
   }
}
