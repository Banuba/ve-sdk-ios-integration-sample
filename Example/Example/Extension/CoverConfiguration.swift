import BanubaVideoEditorSDK

extension ViewController {
  
  func updateVideCoverSelectionConfiguration(_ configuration: SimpleVideoCoverSelectionConfiguration) -> SimpleVideoCoverSelectionConfiguration {
    var configuration = configuration
    
    configuration.cancelButton = TextButtonConfiguration(
      style: TextConfiguration(
        font: UIFont.boldSystemFont(ofSize: 18.0),
        color: UIColor(red: 6, green: 188, blue: 193)
      ),
      text: "Cancel"
    )
    
    configuration.doneButton = RoundedButtonConfiguration(
      textConfiguration: TextConfiguration(
        font: UIFont.boldSystemFont(ofSize: 18.0),
        color: UIColor(red: 6, green: 188, blue: 193)
      ),
      cornerRadius: 0.0,
      backgroundColor: .clear
    )
    
    configuration.toolTipLabel.text = "Tool tip label text"
    configuration.toolTipLabel = TextConfiguration(
      kern: 0.0,
      font: UIFont.systemFont(ofSize: 16.0),
      color: .white,
      alignment: .left
    )
    configuration.sliderColor = UIColor(red: 6, green: 188, blue: 193)
    configuration.sliderMinTrackTintColor = UIColor(red: 6, green: 188, blue: 193)
    configuration.sliderMaxTrackTintColor = UIColor.white
    configuration.backgroundConfiguration.color = UIColor.black
    
    return configuration
  }
  
  func updateVideCoverSelectionConfiguration(_ configuration: VideoCoverSelectionConfiguration) -> VideoCoverSelectionConfiguration {
    var configuration = configuration
    configuration.cancelButton.backgroundColor = .clear
    configuration.cancelButton.textConfiguration?.color = UIColor(
      red: 6, green: 188, blue: 193
    )
    configuration.doneButton.backgroundColor = .clear
    configuration.doneButton.textConfiguration?.color = UIColor(
      red: 6, green: 188, blue: 193
    )
    configuration.titleLabel?.text = "Title cover"
    configuration.toolTipLabel.text = "Tool tip tabel"
    configuration.selectorColor = .clear
    configuration.selectGalleryImageButton.titlePosition = .left
    configuration.deleteImageButtonImageConfiguration.titlePosition = .top
    configuration.backgroundConfiguration.color = UIColor.black
    configuration.previewBackgroundConfiguration.color = .clear
    configuration.thumbnailsCursorConfiguration.imageConfiguration = ImageConfiguration(imageName: "thumb")
    configuration.numberOfThumbnails = 12
    return configuration
  }
}
