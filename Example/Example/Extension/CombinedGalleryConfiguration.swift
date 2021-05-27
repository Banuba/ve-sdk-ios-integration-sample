import UIKit
import BanubaVideoEditorSDK
import VideoEditor

extension ViewController {
  func updateCombinedGalleryConfiguration(_ configuration: CombinedGalleryConfiguration) -> CombinedGalleryConfiguration {
    var configuration = configuration
    
    configuration.videoResolution = VideoResolutionConfiguration(
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
    configuration.galleryItemConfiguration.orderNumberBackgroudColor = UIColor.yellow
    configuration.galleryItemConfiguration.orderNumberTitleColor = UIColor.black
    configuration.galleryItemConfiguration.backgroundSelectionIndicatorImageName = "elipce"
    configuration.galleryItemConfiguration.hideSelectionIndicatorBySelection = true
    configuration.galleryItemConfiguration.durationLabelConfiguration.color = UIColor.white
    configuration.galleryItemConfiguration.durationLabelBackgroundColor = UIColor.clear
    configuration.galleryItemConfiguration.activityIndicatorConfiguration.activityLineWidth = 2.0
    configuration.galleryItemConfiguration.cornerRadius = 0.0
    configuration.closeButtonConfiguration.imageConfiguration.imageName = "camera_control.back"
    configuration.albumButtonConfiguration.style.color = UIColor.yellow
    configuration.nextButtonConfiguration.text = "Next"
    configuration.noItemsLabelConfiguration.alignment = .center
    configuration.layoutConfiguration.numberOfItemsPerRow = 2
    configuration.topBarBlurColor = UIColor.yellow
    configuration.clearSelectionButtonConfiguration.imageConfiguration.imageName = "camera_control.back"
    configuration.galleryTypeButton.style.color = UIColor.yellow
    configuration.galleryTypeUnderlineColor = UIColor.yellow
    configuration.isVideoEnabled = true
    configuration.isPhotoEnabled = true
    
    return configuration
  }
}
