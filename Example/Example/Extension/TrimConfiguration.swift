import UIKit
import BanubaVideoEditorSDK

extension ViewController {
  func updateMultiTrimConfiguration(_ configuration: MultiTrimConfiguration) -> MultiTrimConfiguration {
    var configuration = configuration
    
    configuration.saveButton.cornerRadius = 4.0
    configuration.saveButton.backgroundColor = .clear
    configuration.saveButton.textConfiguration.color = UIColor(
      red: 6, green: 188, blue: 193
    )
    
    configuration.backButton.position = .left
    configuration.backButton = BackButtonConfiguration(
      imageConfiguration: ImageConfiguration(imageName: "back_arrow")
    )
    
    configuration.rotateButton?.imageConfiguration = ImageConfiguration(
      imageName: "editor.rotate"
    )
    
    configuration.timeLimeConfiguration.itemsCornerRadius = .zero
    configuration.trimTimeLineConfiguration.draggersCornerRadius = 8.0
    configuration.trimTimeLineConfiguration.draggerImageName = "trim_left"
    configuration.trimTimeLineConfiguration.doneButtonConfiguration.style.color = UIColor(
      red: 6, green: 188, blue: 193
    )
    configuration.trimTimeLineConfiguration.trimControlsColor = UIColor(
      red: 250, green: 62, blue: 118
    )
    configuration.trimTimeLineHeight = 50.0
    configuration.playerControlConfiguration = PlayerControlConfiguration(
      playButtonImageName: "ic_play",
      pauseButtonImageName: "ic_trim_pause"
    )
    configuration.backgroundConfiguration.cornerRadius = .zero
    configuration.bottomViewBackgroundConfiguration.cornerRadius = .zero
    configuration.screenNameConfiguration.style = nil
    configuration.trimSequenceEdgeInsets = .zero
    configuration.trimSequenceHeight = 10.0
    configuration.editedTimeLabelConfiguration.cornerRadius = .zero
    configuration.editedTimeLabelConfiguration.errorColor = UIColor(
      red: 250, green: 62, blue: 118
    )
    
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
    configuration.deleteGalleryVideoPartButtonConfiguration = ImageButtonConfiguration(
      imageConfiguration: ImageConfiguration(imageName: "ic_delete_video_part")
    )
    configuration.galleryVideoPartsConfiguration.videoPartConfiguration.cornerRadius = .zero
    configuration.galleryVideoPartsConfiguration.addGalleryVideoPartImageName = "add_video_part"
    
    configuration.backButtonConfiguration.position = .left
    configuration.backButtonConfiguration = BackButtonConfiguration(
      imageConfiguration: ImageConfiguration(imageName: "back_arrow")
    )
    
    configuration.nextButtonConfiguration.cornerRadius = 4.0
    configuration.nextButtonConfiguration.backgroundColor = .clear
    configuration.nextButtonConfiguration.textConfiguration.color = UIColor(
      red: 6, green: 188, blue: 193
    )
    
    configuration.deleteToolTipLabel.color = UIColor.white
    configuration.playerControlConfiguration = PlayerControlConfiguration(
      playButtonImageName: "ic_play",
      pauseButtonImageName: "ic_trim_pause"
    )
    configuration.videoPartsBackgroundConfiguration.cornerRadius = .zero
    configuration.backgroundConfiguration.cornerRadius = .zero
    configuration.screenNameConfiguration.style = nil
    configuration.editedTimeLabelConfiguration.cornerRadius = .zero
    configuration.editedTimeLabelConfiguration.errorColor = UIColor(
      red: 250, green: 62, blue: 118
    )
    
    return configuration
  }
}
