import UIKit
import BanubaVideoEditorSDK

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
    config.videoCoverSelectionConfiguration = updateVideCoverSelectionConfiguration(config.videoCoverSelectionConfiguration)
    
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
}

extension ViewController: BanubaVideoEditorSDKDelegate {
  func videoEditorDidCancel(_ videoEditor: BanubaVideoEditorSDK) {
    videoEditor.dismissVideoEditor(animated: true, completion: nil)
  }
  
  func videoEditorDone(_ videoEditor: BanubaVideoEditorSDK) {
    videoEditor.dismissVideoEditor(animated: true, completion: nil)
  }
}
