import BanubaVideoEditorSDK
import VideoEditor

extension ViewController {
  func updateEditorConfiguration(_ configuration: EditorConfiguration) -> EditorConfiguration {
    var configuration = configuration
    
    configuration.additionalEffectsButtons = [
      AdditionalEffectsButtonConfiguration(
        identifier: .sticker,
        imageConfiguration: ImageConfiguration(imageName: "ic_stickers_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_stickers_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .text,
        imageConfiguration: ImageConfiguration(imageName: "ic_text_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_text_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .effects,
        imageConfiguration: ImageConfiguration(imageName: "ic_effects_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_effects_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .masks,
        imageConfiguration: ImageConfiguration(imageName: "ic_masks_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_masks_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .sound,
        imageConfiguration: ImageConfiguration(imageName: "ic_audio_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_audio_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .time,
        imageConfiguration: ImageConfiguration(imageName: "ic_speed_effects_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_speed_effects_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .color,
        imageConfiguration: ImageConfiguration(imageName: "ic_filters_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_filters_on")
      )
    ]
    
    configuration.additionalEffectsButtonsBottomOffset = 0.0
    configuration.videoResolution = VideoResolutionConfiguration(
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
    
    configuration.saveButton.background.color = UIColor(red: 6, green: 188, blue: 193, alpha: 1)
    configuration.saveButton.background.cornerRadius = 4.0
    configuration.saveButton.width = 68.0
    configuration.saveButton.height = 42.0
    configuration.saveButton.title.style.color = .white
    
    configuration.backButton = BackButtonConfiguration(imageConfiguration: BanubaVideoEditorSDK.ImageConfiguration(imageName: "ic_nav_back_arrow"))
    
    return configuration
  }
}
