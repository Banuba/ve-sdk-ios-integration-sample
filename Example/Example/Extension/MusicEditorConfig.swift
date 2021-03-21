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
        titleColor: UIColor.yellow,
        imageName: "btn_add_track"
      ),
      EditButtonConfig(
        font: UIFont.systemFont(ofSize: 14.0),
        type: .effect,
        title: "Effects",
        titleColor: UIColor.yellow,
        imageName: "btn_add_track"
      ),
      EditButtonConfig(
        font: UIFont.systemFont(ofSize: 14.0),
        type: .record,
        title: "Record",
        titleColor: UIColor.yellow,
        imageName: "btn_add_record"
      )
    ]
    
    configuration.editButtonsHeight = 50.0
    
    configuration.editCompositionButtons = [
      EditCompositionButtonConfig(
        font: UIFont.systemFont(ofSize: 14.0),
        type: .edit,
        title: "Edit",
        titleColor: #colorLiteral(red: 0.3176470588, green: 0.5960784314, blue: 0.8549019608, alpha: 1),
        imageName: "btn_edit_on",
        selectedImageName: "imageName"
      ),
      EditCompositionButtonConfig(
        font: UIFont.systemFont(ofSize: 14.0),
        type: .delete,
        title: "Delete",
        titleColor: #colorLiteral(red: 0.3176470588, green: 0.5960784314, blue: 0.8549019608, alpha: 1),
        imageName: "btn_X",
        selectedImageName: "imageName"
      )
    ]
    
    configuration.controlButtons = [
      ControlButtonConfig(
        type: .reset,
        imageName: "btn_delete",
        selectedImageName: nil
      ),
      ControlButtonConfig(
        type: .play,
        imageName: "btn_play_music",
        selectedImageName: "imageName"
      ),
      ControlButtonConfig(
        type: .done,
        imageName: "btn_accepted_track",
        selectedImageName: nil
      )
    ]
    
    configuration.playerControlsHeight = 50.0
    configuration.audioWaveConfiguration.isRandomWaveColor = true
    configuration.mainLabelColors = UIColor.yellow
    configuration.additionalLabelColors = UIColor.black
    configuration.speakerImageName = "imageName"
    configuration.volumeLabel.title = "Title"
    configuration.tracksLimit = 5
    configuration.cursorColor = UIColor.yellow
    configuration.controlsBackgroundConfiguration.cornerRadius = 0.0
    configuration.backgroundConfiguration.cornerRadius = 0.0
    configuration.timelineCornerRadius = 0.0
    
    return configuration
  }
  
  func updateAudioRecorderViewControllerConfig(_ configuration: AudioRecorderViewControllerConfig) -> AudioRecorderViewControllerConfig {
    var configuration = configuration
    
    configuration.rewindToStartButton = ControlButtonConfig(
      type: .reset,
      imageName: "imageName",
      selectedImageName: nil
    )
    
    configuration.playPauseButton = ControlButtonConfig(
      type: .play,
      imageName: "imageName",
      selectedImageName: "imageName"
    )
    
    configuration.playerControlsHeight = 50.0
    
    configuration.recordButton = ControlButtonConfig(
      type: .play,
      imageName: "imageName",
      selectedImageName: "imageName"
    )
    
    configuration.backButtonImage = "imageName"
    configuration.doneButtonImage = "imageName"
    configuration.dimViewColor = #colorLiteral(red: 0.3176470588, green: 0.5960784314, blue: 0.8549019608, alpha: 0.2039811644)
    configuration.additionalLabelColors = UIColor.yellow
    configuration.startingRecordingTimerSeconds = 0.0
    configuration.timerColor = UIColor.yellow
    configuration.cursorColor = UIColor.yellow
    configuration.backgroundConfiguration.cornerRadius = 0.0
    configuration.playerControlsBackgroundConfiguration.cornerRadius = 0.0
    configuration.timelineCornerRadius = 0.0
    
    return configuration
  }
  
  func updateVideoTrackLineEditControllerConfig(_ configuration: VideoTrackLineEditViewControllerConfig) -> VideoTrackLineEditViewControllerConfig {
    var configuration = configuration
    
    configuration.doneButtonImageName = "imageName"
    configuration.doneButtonTintColor = UIColor.yellow
    configuration.sliderTintColor = UIColor.yellow
    configuration.mainLabelColors = UIColor.yellow
    configuration.additionalLabelColors = UIColor.yellow
    configuration.backgroundConfiguration.cornerRadius = 0.0
    configuration.height = 50.0
    return configuration
  }
  
  
  func updateAudioTrackLineEditControllerConfig(_ configuration: AudioTrackLineEditViewControllerConfig) -> AudioTrackLineEditViewControllerConfig {
    var configuration = configuration
    
    configuration.audioWaveConfiguration.isRandomWaveColor = true
    configuration.audioWaveConfiguration.waveLinesColor = UIColor.yellow
    configuration.doneButtonImageName = "imageName"
    configuration.doneButtonTintColor = UIColor.yellow
    configuration.sliderTintColor = UIColor.yellow
    configuration.draggersColor = UIColor.yellow
    configuration.draggerImageName = "imageName"
    configuration.trimHeight = 61.0
    configuration.trimBorderColor = UIColor.yellow
    configuration.trimBorderWidth = 2.0
    configuration.cursorHeight = 1.0
    configuration.dimViewColor = UIColor.yellow.withAlphaComponent(0.5)
    configuration.mainLabelColors = UIColor.yellow
    configuration.additionalLabelColors = UIColor.yellow
    configuration.cursorColor = UIColor.yellow
    configuration.draggersWidth = 25.0
    configuration.draggersLineColor = UIColor.yellow
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
