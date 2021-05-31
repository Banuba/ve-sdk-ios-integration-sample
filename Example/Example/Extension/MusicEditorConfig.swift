import UIKit
import BanubaMusicEditorSDK

extension ViewController {
  func updateMusicEditorConfigurtion(_ configuration: MusicEditorConfig) -> MusicEditorConfig {
    var configuration = configuration
    
    configuration.mainMusicViewControllerConfig = updateMainMusicViewControllerConfig(configuration.mainMusicViewControllerConfig)
    configuration.audioRecorderViewControllerConfig = updateAudioRecorderViewControllerConfig(configuration.audioRecorderViewControllerConfig)
    configuration.audioTrackLineEditControllerConfig = updateAudioTrackLineEditControllerConfig(configuration.audioTrackLineEditControllerConfig)
    configuration.videoTrackLineEditControllerConfig = updateVideoTrackLineEditControllerConfig(configuration.videoTrackLineEditControllerConfig)
    
    return configuration
  }
  
  func updateMainMusicViewControllerConfig(_ configuration: MainMusicViewControllerConfig) -> MainMusicViewControllerConfig {
    var configuration = configuration
    
    configuration.editButtons = [
      EditButtonConfig(
        font: UIFont.systemFont(ofSize: 14.0),
        type: .track,
        title: "Tracks",
        titleColor: #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1),
        imageName: "ic_tracks"
      ),
      EditButtonConfig(
        font: UIFont.systemFont(ofSize: 14.0),
        type: .effect,
        title: "Effects",
        titleColor: #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1),
        imageName: "ic_effects"
      ),
      EditButtonConfig(
        font: UIFont.systemFont(ofSize: 14.0),
        type: .record,
        title: "Record",
        titleColor: #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1),
        imageName: "ic_voice_recording"
      )
    ]
    
    configuration.editButtonsHeight = 50.0
    
    configuration.editCompositionButtons = [
      EditCompositionButtonConfig(
        font: UIFont.systemFont(ofSize: 14.0),
        type: .edit,
        title: "Edit",
        titleColor: #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1),
        imageName: "ic_edit",
        selectedImageName: nil
      ),
      EditCompositionButtonConfig(
        font: UIFont.systemFont(ofSize: 14.0),
        type: .delete,
        title: "Delete",
        titleColor: #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1),
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
        imageName: "ic_editor_play",
        selectedImageName: "ic_pause"
      ),
      ControlButtonConfig(
        type: .done,
        imageName: "ic_done",
        selectedImageName: nil
      )
    ]
    
    configuration.playerControlsHeight = 50.0
    configuration.audioWaveConfiguration.isRandomWaveColor = true
    configuration.mainLabelColors = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    configuration.additionalLabelColors = UIColor.black
    configuration.speakerImageName = "imageName"
    configuration.volumeLabel.title = "Title"
    configuration.tracksLimit = 5
    configuration.cursorColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    configuration.controlsBackgroundConfiguration.cornerRadius = 0.0
    configuration.backgroundConfiguration.cornerRadius = 0.0
    configuration.timelineCornerRadius = 0.0
    
    return configuration
  }
  
  func updateAudioRecorderViewControllerConfig(_ configuration: AudioRecorderViewControllerConfig) -> AudioRecorderViewControllerConfig {
    var configuration = configuration
    
    configuration.rewindToStartButton = ControlButtonConfig(
      type: .reset,
      imageName: "ic_restart",
      selectedImageName: nil
    )
    
    configuration.playPauseButton = ControlButtonConfig(
      type: .play,
      imageName: "ic_editor_play",
      selectedImageName: "ic_pause"
    )
    
    configuration.playerControlsHeight = 50.0
    
    configuration.recordButton = ControlButtonConfig(
      type: .play,
      imageName: "ic_start_recording",
      selectedImageName: "ic_pause_recording"
    )
    
    configuration.backButtonImage = "ic_close"
    configuration.doneButtonImage = "ic_done"
    configuration.dimViewColor = #colorLiteral(red: 0.3176470588, green: 0.5960784314, blue: 0.8549019608, alpha: 0.2039811644)
    configuration.additionalLabelColors = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    configuration.startingRecordingTimerSeconds = 0.0
    configuration.timerColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    configuration.cursorColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    configuration.backgroundConfiguration.cornerRadius = 0.0
    configuration.playerControlsBackgroundConfiguration.cornerRadius = 0.0
    configuration.timelineCornerRadius = 0.0
    
    return configuration
  }
  
  func updateVideoTrackLineEditControllerConfig(_ configuration: VideoTrackLineEditViewControllerConfig) -> VideoTrackLineEditViewControllerConfig {
    var configuration = configuration
    
    configuration.doneButtonImageName = "ic_done"
    configuration.doneButtonTintColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    configuration.sliderTintColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    configuration.mainLabelColors = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    configuration.additionalLabelColors = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    configuration.backgroundConfiguration.cornerRadius = 0.0
    configuration.height = 50.0
    return configuration
  }
  
  
  func updateAudioTrackLineEditControllerConfig(_ configuration: AudioTrackLineEditViewControllerConfig) -> AudioTrackLineEditViewControllerConfig {
    var configuration = configuration
    
    configuration.audioWaveConfiguration.isRandomWaveColor = true
    configuration.audioWaveConfiguration.waveLinesColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    configuration.doneButtonImageName = "ic_done"
    configuration.doneButtonTintColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    configuration.sliderTintColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    configuration.draggersColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    configuration.draggerImageName = "trim_left"
    configuration.trimHeight = 61.0
    configuration.trimBorderColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    configuration.trimBorderWidth = 2.0
    configuration.cursorHeight = 1.0
    configuration.dimViewColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    configuration.mainLabelColors = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    configuration.additionalLabelColors = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    configuration.cursorColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    configuration.draggersWidth = 25.0
    configuration.draggersLineColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    configuration.draggersCornerRadius = 0.0
    configuration.draggersLineWidth = 2.0
    configuration.draggersLineHeight = 35.0
    configuration.numberOfLinesInDraggers = 1
    configuration.draggerLinesSpacing = 2.0
    configuration.draggersCornerRadius = 0.0
    configuration.backgroundConfiguration.cornerRadius = 0.0
    configuration.voiceFilterConfiguration?.cornerRadius = 4.0
    
    return configuration
  }
}
