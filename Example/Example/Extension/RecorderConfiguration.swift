import UIKit
import BanubaVideoEditorSDK
import VideoEditor

extension ViewController {
  func updateRecorderConfiguration(_ configuration: RecorderConfiguration) -> RecorderConfiguration {
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
    
    let nextButtonTextConfiguration = TextConfiguration(
      kern: 1.0,
      font: UIFont.systemFont(ofSize: 12.0),
      color: UIColor.white
    )
    let inactiveNextButtonTextConfiguration = TextConfiguration(
      kern: 1.0,
      font: UIFont.systemFont(ofSize: 12.0),
      color: UIColor.white.withAlphaComponent(0.5)
    )
    
    configuration.saveButton = SaveButtonConfiguration(
      textConfiguration: nextButtonTextConfiguration,
      inactiveTextConfiguration: inactiveNextButtonTextConfiguration,
      text: "NEXT",
      width: 68.0,
      height: 41.0,
      cornerRadius: 4.0,
      backgroundColor: UIColor(red: 6, green: 188, blue: 193),
      inactiveBackgroundColor: UIColor(red: 6, green: 188, blue: 193).withAlphaComponent(0.5)
    )
    
    configuration.backButton = BackButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_nav_close"))
    configuration.removeButtonImageName = "delete_videopart"
    configuration.captureButtonMode = .mixed
    configuration.recordButtonConfiguration.normalImageName = "ic_record_normal"
    configuration.recordButtonConfiguration.recordImageName = "ic_record_normal"
    configuration.recordButtonConfiguration.idleStrokeColor = UIColor.white.cgColor
    configuration.recordButtonConfiguration.strokeColor = UIColor(red: 6, green: 188, blue: 193).cgColor
    configuration.recordButtonConfiguration.spacingBetweenButtonAndCircular = 6
    
    
    
    configuration.additionalEffectsButtons = [
      AdditionalEffectsButtonConfiguration(
        identifier: .beauty,
        imageConfiguration: ImageConfiguration(imageName: "ic_beauty_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_beauty_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .sound,
        imageConfiguration: ImageConfiguration(imageName: "ic_audio_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_audio_on"),
        position: .bottom
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .effects,
        imageConfiguration: ImageConfiguration(imageName: "ic_filters_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_filters_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .masks,
        imageConfiguration: ImageConfiguration(imageName: "ic_masks_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_masks_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .toggle,
        imageConfiguration: ImageConfiguration(imageName: "ic_cam_front"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_cam_back_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .flashlight,
        imageConfiguration: ImageConfiguration(imageName: "ic_flash_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_flash_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .timer,
        imageConfiguration: ImageConfiguration(imageName: "ic_timer_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_timer_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .speed,
        imageConfiguration: ImageConfiguration(imageName: "ic_speed_1x"),
        selectedImageConfiguration: nil
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .muteSound,
        imageConfiguration: ImageConfiguration(imageName: "ic_mic_on"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_mic_off")
      ),
    ]
    
    configuration.speedButton = SpeedButtonConfiguration(
      imageNameHalf: "ic_speed_0.5x",
      imageNameNormal: "ic_speed_1x",
      imageNameDouble: "ic_speed_2x",
      imageNameTriple: "ic_speed_3x"
    )
    
    let galleryButton: RoundedButtonConfiguration = RoundedButtonConfiguration(
      textConfiguration: TextConfiguration(
        kern: 0.0,
        font: UIFont.systemFont(ofSize: 12.0),
        color: UIColor.clear
      ),
      cornerRadius: 3,
      backgroundColor: UIColor.clear,
      borderWidth: 0
    )
    
    configuration.galleryButton = galleryButton
    configuration.emptyGalleryImageName = "multi_choise"
    
    configuration.timerConfiguration.defaultButton = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_timer_off"))
    configuration.timerConfiguration.options = [
      TimerConfiguration.TimerOptionConfiguration(
        button: ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_timer_on")),
        startingTimerSeconds: 3,
        stoppingTimerSeconds: 0
      )
    ]
    
    configuration.timeLineConfiguration.progressBarColor = UIColor(red: 6, green: 188, blue: 193)
    configuration.timeLineConfiguration.progressBarSelectColor = UIColor.white
    
    configuration.regularRecordButtonPosition = 10.0
    configuration.recorderEffectsConfiguration.cornerRadius = 0.0
    configuration.leftControlsBottomOffsetFromCaptureButton = 0.0
    configuration.leftControlsLeftOffset = 25.0
    configuration.sequenceHeight = 6.0
    configuration.useHorizontalVersion = false
    configuration.loopAudioWhileRecording = true
    configuration.takeAudioDurationAsMaximum = false
    configuration.isDynamicMusicTitle = false
    
    return configuration
  }
}

