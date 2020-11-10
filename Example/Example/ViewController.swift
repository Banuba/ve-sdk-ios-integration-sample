import UIKit
import BanubaVideoEditorSDK
import BanubaMusicEditorSDK

class ViewController: UIViewController {
  
  private var videoEditorSDK: BanubaVideoEditorSDK?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initVideoEditor()
  }
  
  private func initVideoEditor() {
    let config = createVideoEditorConfiguration()
    videoEditorSDK = BanubaVideoEditorSDK(
      token: "place client token here",
      effectsToken: "place effects token here",
      configuration: config,
      analytics: nil,
      externalViewControllerFactory: nil
    )
    videoEditorSDK?.delegate = self
  }
  
  @IBAction func openVideoEditorAction(_ sender: Any) {
    videoEditorSDK?.presentVideoEditor(from: self, animated: true, completion: nil)
  }
  
  private func createVideoEditorConfiguration() -> VideoEditorConfig {
    var config = VideoEditorConfig()
    
    config.recorderConfiguration = updateRecorderConfiguration(config.recorderConfiguration)
    config.editorConfiguration = updateEditorConfiguration(config.editorConfiguration)
    config.galleryConfiguration = updateGalleryConfiguration(config.galleryConfiguration)
    config.slideShowConfiguration = updateSlideShowConfiguration(config.slideShowConfiguration)
    config.videoCoverSelectionConfiguration = updateVideCoverSelectionConfiguration(config.videoCoverSelectionConfiguration)
    config.musicEditorConfiguration = updateMusicEditorConfigurtion(config.musicEditorConfiguration)
    
    return config
  }
  
  private func updateRecorderConfiguration(_ configuration: RecorderConfiguration) -> RecorderConfiguration {
    var configuration = configuration
    
    configuration.backButton = BackButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_nav_close"))
    configuration.removeButtonImageName = "delete_videopart"
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
    
    configuration.timerConfiguration.defaultButton = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_timer_off"))
    configuration.timerConfiguration.options = [
      TimerConfiguration.TimerOptionConfiguration(
        button: ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_timer_on")),
        startingTimerSeconds: 3,
        stoppingTimerSeconds: 0
      )
    ]
    configuration.recordButtonConfiguration.normalImageName = "ic_record_normal"
    configuration.recordButtonConfiguration.recordImageName = "ic_record_stop"
    
    return configuration
  }
  
  private func updateEditorConfiguration(_ configuration: EditorConfiguration) -> EditorConfiguration {
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
        imageConfiguration: ImageConfiguration(imageName: "ic_filters_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_filters_on")
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
        identifier: .speed,
        imageConfiguration: ImageConfiguration(imageName: "ic_speed_effect_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_speed_effect_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .color,
        imageConfiguration: ImageConfiguration(imageName: "ic_effects_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_effects_on")
      )
    ]
    
    configuration.backButton = BackButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_nav_back_arrow"))
    configuration.playButtonImageName = "ic_play"
    
    return configuration
  }
  
  private func updateSlideShowConfiguration(_ configuration: SlideShowConfiguration) -> SlideShowConfiguration {
    var configuration = configuration
    
    configuration.clearSelectionButtonConfiguration = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "cancel_cross"))
    configuration.closeButtonConfiguration = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "back_arrow"))
    
    return configuration
  }
  
  private func updateGalleryConfiguration(_ configuration: GalleryConfiguration) -> GalleryConfiguration {
    var configuration = configuration
    
    configuration.multiselectButtonConfiguration = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "multi_choise"))
    configuration.cancelMultiselectButtonConfiguration = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "cancel_cross"))
    configuration.backButtonConfiguration = BackButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "back_arrow"))
    
    return configuration
  }
  
  private func updateVideCoverSelectionConfiguration(_ configuration: VideoCoverSelectionConfiguration) -> VideoCoverSelectionConfiguration {
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
    configuration.sliderColor = UIColor(red: 6, green: 188, blue: 193)
    configuration.sliderMinTrackTintColor = UIColor(red: 6, green: 188, blue: 193)
    configuration.toolTipLabel = TextConfiguration(
      kern: 0.0,
      font: UIFont.systemFont(ofSize: 16.0),
      color: .white,
      alignment: .left
    )
    
    return configuration
  }
  
  private func updateMusicEditorConfigurtion(_ configuration: MusicEditorConfig) -> MusicEditorConfig {
    var configuration = configuration
    
    configuration.mainMusicViewControllerConfig = updateMainMusicViewControllerConfig(configuration.mainMusicViewControllerConfig)
    configuration.audioRecorderViewControllerConfig = updateAudioRecorderViewControllerConfig(configuration.audioRecorderViewControllerConfig)
    configuration.audioTrackLineEditControllerConfig = updateAudioTrackLineEditControllerConfig(configuration.audioTrackLineEditControllerConfig)
    configuration.videoTrackLineEditControllerConfig = updateVideoTrackLineEditControllerConfig(configuration.videoTrackLineEditControllerConfig)
    
    return configuration
  }
  
  private func updateMainMusicViewControllerConfig(_ configuration: MainMusicViewControllerConfig) -> MainMusicViewControllerConfig {
    var configuration = configuration
    
    configuration.cancelButtonConfiguration.color = UIColor(red: 6, green: 188, blue: 193)
    configuration.editButtons = [
      EditButtonConfig(
        font: UIFont.systemFont(ofSize: 14.0),
        type: .track,
        title: "Tracks",
        titleColor: .white,
        imageName: "ic_tracks"
      ),
      EditButtonConfig(
        font: UIFont.systemFont(ofSize: 14.0),
        type: .effect,
        title: "Effects",
        titleColor: .white,
        imageName: "ic_effects"
      ),
      EditButtonConfig(
        font: UIFont.systemFont(ofSize: 14.0),
        type: .record,
        title: "Recording",
        titleColor: .white,
        imageName: "ic_voice_recording"
      )
    ]
    
    configuration.editCompositionButtons = [
      EditCompositionButtonConfig(
        font: UIFont.systemFont(ofSize: 14.0),
        type: .edit,
        title: "Edit",
        titleColor: .white,
        imageName: "ic_edit",
        selectedImageName: nil
      ),
      EditCompositionButtonConfig(
        font: UIFont.systemFont(ofSize: 14.0),
        type: .delete,
        title: "Delete",
        titleColor: .white,
        imageName: "ic_trash",
        selectedImageName: nil
      )
    ]
    
    configuration.controlButtons = [
      ControlButtonConfig(
        type: .reset,
        imageName: "ic_restart",
        selectedImageName: nil
      ),
      ControlButtonConfig(
        type: .play,
        imageName: "ic_play",
        selectedImageName: "ic_pause"
      ),
      ControlButtonConfig(
        type: .done,
        imageName: "ic_done",
        selectedImageName: nil
      )
    ]
    
    return configuration
  }
  
  private func updateAudioRecorderViewControllerConfig(_ configuration: AudioRecorderViewControllerConfig) -> AudioRecorderViewControllerConfig {
    var configuration = configuration
    
    configuration.playPauseButton = ControlButtonConfig(
      type: .play,
      imageName: "ic_play",
      selectedImageName: "ic_pause"
    )
    
    configuration.recordButton = ControlButtonConfig(
      type: .play,
      imageName: "ic_start_recording",
      selectedImageName: "ic_pause_recording"
    )
    
    configuration.resetButtonImage = "ic_cancel"
    configuration.rewindToStartButton = ControlButtonConfig(
      type: .reset,
      imageName: "ic_restart",
      selectedImageName: nil
    )
    configuration.doneButtonImage = "ic_done"
    
    return configuration
  }
  
  private func updateAudioTrackLineEditControllerConfig(_ configuration: AudioTrackLineEditViewControllerConfig) -> AudioTrackLineEditViewControllerConfig {
    var configuration = configuration
    
    configuration.doneButtonImageName = "ic_done"
    configuration.draggersColor = UIColor(red: 250, green: 62, blue: 118)
    configuration.draggersLineColor = UIColor(red: 250, green: 62, blue: 118)
    configuration.sliderTintColor = UIColor(red: 6, green: 188, blue: 193)
    
    return configuration
  }
  
  private func updateVideoTrackLineEditControllerConfig(_ configuration: VideoTrackLineEditViewControllerConfig) -> VideoTrackLineEditViewControllerConfig {
    var configuration = configuration
    
    configuration.doneButtonImageName = "ic_done"
    configuration.sliderTintColor = UIColor(red: 6, green: 188, blue: 193)
    configuration.mainLabelColors = UIColor(red: 6, green: 188, blue: 193)
    
    return configuration
  }
}

extension ViewController: BanubaVideoEditorSDKDelegate {
  func videoEditorDidCancel(_ videoEditor: BanubaVideoEditorSDK) {
    videoEditor.dismissVideoEditor(animated: true, completion: nil)
  }
  
  func videoEditorDone(_ videoEditor: BanubaVideoEditorSDK) {
    videoEditor.dismissVideoEditor(animated: true, completion: nil)
  }
}
