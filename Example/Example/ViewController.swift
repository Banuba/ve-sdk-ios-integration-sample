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
  
  func createVideoEditorConfiguration() -> VideoEditorConfig {
    var config = VideoEditorConfig()
    
    config.musicEditorConfiguration = updateMusicEditorConfigurtion(config.musicEditorConfiguration)
    
    return config
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
