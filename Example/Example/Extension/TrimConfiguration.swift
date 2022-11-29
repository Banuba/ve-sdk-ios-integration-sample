import UIKit
import BanubaVideoEditorSDK

extension ViewController {
  func updateTrimVideosConfiguration(_ configuration: TrimVideosConfiguration) -> TrimVideosConfiguration {
    var configuration = configuration
    
    configuration.backButtonConfiguration = ImageButtonConfiguration(
      imageConfiguration: ImageConfiguration(imageName: "ic_close")
    )
    
    configuration.nextButtonConfiguration = ImageTextButtonConfiguration(
      imageConfiguration: ImageConfiguration(imageName: "ic_done")
    )
    
    configuration.editVideoItemTitleConfiguration = TextConfiguration(
      font: .systemFont(ofSize: 11.0),
      color: .white
    )
  
    configuration.editVideoItems = [
      TrimVideoCompositionEditItem(
        title: NSLocalizedString("com.banuba.trim.rotateEditButtonTitle", comment: ""),
        icon: ImageConfiguration(imageName: "ic_rotate"),
        type: .rotate
      ),
      TrimVideoCompositionEditItem(
        title: NSLocalizedString("com.banuba.trim.splitEditButtonTitle", comment: ""),
        icon: ImageConfiguration(imageName: "ic_split"),
        type: .split
      ),
      TrimVideoCompositionEditItem(
        title: NSLocalizedString("com.banuba.trim.deleteEditButtonTitle", comment: ""),
        icon: ImageConfiguration(imageName: "ic_trash"),
        type: .delete
      ),
      TrimVideoCompositionEditItem(
        title: NSLocalizedString("com.banuba.trim.trimEditButtonTitle", comment: ""),
        icon: ImageConfiguration(imageName: "ic_split"),
        type: .trim
      ),
    ]
    
    configuration.addGalleryVideoImageButtonConfiguration = ImageButtonConfiguration(
      imageConfiguration: ImageConfiguration(imageName: "btn_add_video_sticky")
    )
    
    configuration.addGalleryVideoButtonBackgroundConfiguration = BackgroundConfiguration(
      cornerRadius: 4.0,
      color: UIColor.clear
    )
    
    configuration.trimTimelineConfiguration.trimContentCornerRadius = .zero
    configuration.trimTimelineConfiguration.draggerConfiguration.backgroundConfiguraiton.cornerRadius = 8.0
    configuration.trimTimelineConfiguration.draggerConfiguration.draggerImageName = "trim_left"
    configuration.trimTimelineConfiguration.controlsColor = UIColor(
      red: 250, green: 62, blue: 118, alpha: 1
    )
    configuration.playerControlConfiguration = PlayerControlConfiguration(
      playButtonImageName: "ic_play",
      pauseButtonImageName: "ic_trim_pause"
    )
    configuration.backgroundConfiguration.cornerRadius = .zero
    configuration.screenNameConfiguration.style = nil
    
    configuration.videoResolutionConfiguration = VideoResolutionConfiguration(
      default: .hd1920x1080,
      resolutions: [
        .iPhone5s: .hd1280x720,
        .iPhone6: .default854x480,
        .iPhone6s: .hd1280x720,
        .iPhone6Plus: .default854x480,
        .iPhone6sPlus: .hd1280x720,
        .iPhoneSE: .hd1280x720,
      ],
      thumbnailHeights: [
        .iPhone5s: 200.0,
        .iPhone6: 80.0,
        .iPhone6s: 200.0,
        .iPhone6Plus: 80.0,
        .iPhone6sPlus: 200.0,
        .iPhoneSE: 200.0,
      ],
      defaultThumbnailHeight: 400.0
    )
    
    return configuration
  }
  
  func updateTrimVideoConfiguration(_ configuration: TrimVideoConfiguration) -> TrimVideoConfiguration {
    var configuration = configuration
    
    configuration.backButton = ImageButtonConfiguration(
      imageConfiguration: ImageConfiguration(imageName: "ic_close")
    )
    
    configuration.saveButton = ImageButtonConfiguration(
    imageConfiguration: ImageConfiguration(imageName: "ic_done")
    )
    
    configuration.playerControlConfiguration = PlayerControlConfiguration(
      playButtonImageName: "ic_play",
      pauseButtonImageName: "ic_trim_pause"
    )
    configuration.backgroundConfiguration.cornerRadius = .zero
    configuration.screenNameConfiguration.style = nil
    
    return configuration
  }
  
  func updateAspectsConfiguration(_ configuration: EffectsListConfiguration) -> EffectsListConfiguration {
    var configuration = configuration
    
    configuration.doneButton = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_done"))
    configuration.cancelButton = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_close"))
    
    return configuration
  }
}
