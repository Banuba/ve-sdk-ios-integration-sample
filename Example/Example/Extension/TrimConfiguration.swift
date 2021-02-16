extension ViewController {
  func updateSingleTrimConfiguration(_ configuration: SingleTrimConfiguration) -> SingleTrimConfiguration {
    var configuration = configuration
    
    configuration.saveButton.cornerRadius = 4.0
    configuration.backButton.position = .left
    configuration.rotateButton?.imageConfiguration.imageName = "imageName"
    configuration.throbber.activityLineWidth = 3.0
    configuration.trimTimeLineConfiguration.draggersCornerRadius = 8.0
    configuration.trimTimeLineHeight = 56.0
    configuration.playerControlConfiguration.pauseButtonImageName = "imageName"
    configuration.backgroundConfiguration.cornerRadius = .zero
    configuration.screenNameConfiguration.style = nil
    configuration.editedTimeLabelConfiguration.cornerRadius = .zero
    
    return configuration
  }
  
  func updateMultiTrimConfiguration(_ configuration: MultiTrimConfiguration) -> MultiTrimConfiguration {
    var configuration = configuration
    
    configuration.saveButton.cornerRadius = 4.0
    configuration.backButton.position = .left
    configuration.rotateButton?.imageConfiguration.imageName = "imageName"
    configuration.timeLimeConfiguration.itemsCornerRadius = .zero
    configuration.trimTimeLineConfiguration.draggersCornerRadius = 8.0
    configuration.trimTimeLineHeight = 50.0
    configuration.playerControlConfiguration.pauseButtonImageName = "imageName"
    configuration.backgroundConfiguration.cornerRadius = .zero
    configuration.bottomViewBackgroundConfiguration.cornerRadius = .zero
    configuration.screenNameConfiguration.style = nil
    configuration.trimSequenceEdgeInsets = .zero
    configuration.trimTimeLineHeight = 6.0
    configuration.editedTimeLabelConfiguration.cornerRadius = .zero
    
    return configuration
  }
  
  func updateTrimGalleryVideoConfiguration(_ configuration: TrimGalleryVideoConfiguration) -> TrimGalleryVideoConfiguration {
    var configuration = configuration
    
    configuration.videoResolutionConfiguration = VideoResolutionConfiguration(
      default: .hd1920x1080,
      resolutions: [
        .iPhone5S: .hd1280x720,
        .iPhone6: .default854x480,
        .iPhone6S: .hd1280x720,
        .iPhone6plus: .default854x480,
        .iPhone6Splus: .hd1280x720,
        .iPhoneSE: .hd1280x720,
      ],
      thumbnailHeights: [
        .iPhone5S: 200.0,
        .iPhone6: 80.0,
        .iPhone6S: 200.0,
        .iPhone6plus: 80.0,
        .iPhone6Splus: 200.0,
        .iPhoneSE: 200.0,
      ],
      defaultThumbnailHeight: 400.0
    )
    
    configuration.activityIndicatorConfiguration.activityLineWidth = 3.0
    configuration.deleteGalleryVideoPartButtonConfiguration.imageConfiguration.imageName = "imageName"
    configuration.galleryVideoPartsConfiguration.videoPartConfiguration.cornerRadius = .zero
    configuration.backButtonConfiguration.position = .left
    configuration.nextButtonConfiguration.cornerRadius = 4.0
    configuration.deleteToolTipLabel.color = UIColor.white
    configuration.playerControlConfiguration.playButtonImageName = "imageName"
    configuration.videoPartsBackgroundConfiguration.cornerRadius = .zero
    configuration.backgroundConfiguration.cornerRadius = .zero
    configuration.screenNameConfiguration.style = nil
    configuration.editedTimeLabelConfiguration.cornerRadius = .zero
    
    return configuration
  }
}
