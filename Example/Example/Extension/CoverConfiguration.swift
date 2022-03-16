import BanubaVideoEditorSDK

extension ViewController {
  func updateVideCoverSelectionConfiguration(_ configuration: VideoCoverSelectionConfiguration) -> VideoCoverSelectionConfiguration {
    var configuration = configuration
    configuration.cancelButton.backgroundColor = .clear
    configuration.cancelButton.textConfiguration?.color = UIColor(
      red: 6, green: 188, blue: 193, alpha: 1
    )
    configuration.doneButton.backgroundColor = .clear
    configuration.doneButton.textConfiguration?.color = UIColor(
      red: 6, green: 188, blue: 193, alpha: 1
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
