import UIKit
import BanubaVideoEditorSDK
import VideoEditor

extension ViewController {
  func updateCombinedGalleryConfiguration(_ configuration: GalleryConfiguration) -> GalleryConfiguration {
    configuration.videoResolution = .hd1920x1080
    configuration.galleryItemConfiguration.orderNumberBackgroudColor = UIColor.yellow
    configuration.galleryItemConfiguration.orderNumberTitleColor = UIColor.black
    configuration.galleryItemConfiguration.backgroundSelectionIndicatorImageName = "elipce"
    configuration.galleryItemConfiguration.hideSelectionIndicatorBySelection = true
    configuration.galleryItemConfiguration.durationLabelConfiguration.color = UIColor.white
    configuration.galleryItemConfiguration.durationLabelBackgroundColor = UIColor.clear
    configuration.galleryItemConfiguration.activityIndicatorConfiguration.activityLineWidth = 2.0
    configuration.galleryItemConfiguration.cornerRadius = 0.0
    configuration.closeButtonConfiguration.imageConfiguration = BanubaVideoEditorSDK.ImageConfiguration(imageName: "camera_control.back")
    configuration.albumButtonConfiguration.style.color = UIColor.yellow
    configuration.nextButtonConfiguration.text = "Next"
    configuration.noItemsLabelConfiguration.alignment = .center
    configuration.layoutConfiguration.numberOfItemsPerRow = 2
    configuration.topBarBlurColor = UIColor.yellow
    configuration.clearSelectionButtonConfiguration.imageConfiguration = BanubaVideoEditorSDK.ImageConfiguration(imageName: "camera_control.back")
    configuration.galleryTypeButton.style.color = UIColor.yellow
    configuration.galleryTypeUnderlineColor = UIColor.yellow
    
    return configuration
  }
}
