# Banuba VideoEditor SDK
## MusicEditorConfig

The Music Editing screen is needed to add and configure a music track, audio recording, and combine multiple sounds for a video.

Below are the configs for customizing the Music Editing screen.

- [mainMusicViewControllerConfig: MainMusicViewControllerConfig](/Example/Example/Extension/MusicEditorConfig.swift#L8)

MainMusicViewControllerConfig setups main screen style

- [videoTrackLineEditControllerConfig: VideoTrackLineEditViewControllerConfig](/Example/Example/Extension/MusicEditorConfig.swift#L9)

VideoTrackLineEditViewControllerConfig setups video track line editing screen style

- [audioTrackLineEditControllerConfig: AudioTrackLineEditViewControllerConfig](/Example/Example/Extension/MusicEditorConfig.swift#L10)

VideoTrackLineEditViewControllerConfig setups audio track line editing screen style

- [audioRecorderViewControllerConfig: AudioRecorderViewControllerConfig](/Example/Example/Extension/MusicEditorConfig.swift#L11)

AudioRecorderViewControllerConfig setups audio recorder style

## MainMusicViewControllerConfig

- [editButtons: [EditButtonConfig]](/Example/Example/Extension/MusicEditorConfig.swift#L19)

Array of adding buttons

- [editButtonsHeight: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L43)

Adding buttons container height

- [editCompositionButtons: [EditCompositionButtonConfig]](/Example/Example/Extension/MusicEditorConfig.swift#L45)

Array of edit composition buttons

- [controlButtons: [ControlButtonConfig]](/Example/Example/Extension/MusicEditorConfig.swift#L64)

Aray of control buttons

- [playerControlsHeight: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L82)

Сontrol buttons container height

- [audioWaveConfiguration: AudioWaveConfiguration](/Example/Example/Extension/MusicEditorConfig.swift#L83)

AudioWaveConfiguration setups audio wave style

- [mainLabelColors: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L84)

Color for main titles color

- [additionalLabelColors: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L85)

Color for additional titles color

- [speakerImageName: String](/Example/Example/Extension/MusicEditorConfig.swift#L86)

 Image name setups speaker image view

- [volumeLabel: TextButtonConfig](/Example/Example/Extension/MusicEditorConfig.swift#L87)

TextButtonConfig setups volume label title style

- [tracksLimit: Int](/Example/Example/Extension/MusicEditorConfig.swift#L88)

Number of maximum tracks

- [cursorColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L89)

Cursor color

- [controlsBackgroundConfiguration: BackgroundConfiguration](/Example/Example/Extension/MusicEditorConfig.swift#L90)

BackgroundConfiguration setups controls container background style

- [backgroundConfiguration: BackgroundConfiguration](/Example/Example/Extension/MusicEditorConfig.swift#L91)

BackgroundConfiguration setups main view background style

- [timelineCornerRadius: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L92)

Time line corner radius

- [previewViewBackgroundConfiguration: BackgroundConfiguration](/Example/Example/Extension/MusicEditorConfig.swift#L92)

BackgroundConfiguration setups preview view background style

- [videoControlsViewBackgroundConfiguration: BackgroundConfiguration](/Example/Example/Extension/MusicEditorConfig.swift#L92)

BackgroundConfiguration setups video controls view background style

- [alertConfig: AlertViewConfiguration](/Example/Example/Extension/MusicEditorConfig.swift#L92)

Configuration for alertView

![img](screenshots/MusicEditorMainScreen.png)





## AudioRecorderViewControllerConfig

- [rewindToStartButton: ControlButtonConfig?](/Example/Example/Extension/MusicEditorConfig.swift#L100)

ControlButtonConfig setups rewind to start button

- [playPauseButton: ControlButtonConfig](/Example/Example/Extension/MusicEditorConfig.swift#L106)

ControlButtonConfig setups play pause button

- [playerControlsHeight: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L112)

Player controls height

- [recordButton: ControlButtonConfig](/Example/Example/Extension/MusicEditorConfig.swift#L114)

ControlButtonConfig setups record button

- [backButtonImage: String](/Example/Example/Extension/MusicEditorConfig.swift#L120)

Image name setups back button UIImage

- [doneButtonImage: String](/Example/Example/Extension/MusicEditorConfig.swift#L121)

 Image name setups done button UIImage

- [dimViewColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L122)

Dim view color

- [additionalLabelColors: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L123)

Additional labels color

- [startingRecordingTimerSeconds: TimeInterval](/Example/Example/Extension/MusicEditorConfig.swift#L124)

Countdown to start recording

- [timerColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L125)

Timer color

- [cursorColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L126)

Cursor color

- [backgroundConfiguration: BackgroundConfiguration](/Example/Example/Extension/MusicEditorConfig.swift#L127)

BackgroundConfiguration setups background view

- [playerControlsBackgroundConfiguration: BackgroundConfiguration](/Example/Example/Extension/MusicEditorConfig.swift#L128)

BackgroundConfiguration setups player controls background view

- [timelineCornerRadius: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L129)

Time line corner radius

- [resetButton: RoundedButtonConfiguration](/Example/Example/Extension/MusicEditorConfig.swift#L129)

RoundedButtonConfiguration setups reset button style

![img](screenshots/AudioRecorderScreen.png)





## VideoTrackLineEditViewControllerConfig

- [doneButtonImageName: String](/Example/Example/Extension/MusicEditorConfig.swift#L137)

Image name setups done button UIImage

- [doneButtonTintColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L138)

Done button tint color

- [sliderTintColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L139)

Slider tint color

- [mainLabelColors: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L140)

Main labels color

- [additionalLabelColors: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L141)

Additional labels colors

- [backgroundConfiguration: BackgroundConfiguration](/Example/Example/Extension/MusicEditorConfig.swift#L142)

BackgroundConfiguration setups background view

- [height: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L143)

Pop-up screen's height

![img](screenshots/VideoEditScreen.png)




## AudioTrackLineEditViewControllerConfig

- [audioWaveConfiguration: AudioWaveConfiguration](/Example/Example/Extension/MusicEditorConfig.swift#L151)

AudioWaveConfiguration setups audio wave style

- [doneButtonImageName: String](/Example/Example/Extension/MusicEditorConfig.swift#L153)

Image name setups done buttom UIImage

- [doneButtonTintColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L154)

Done button tint color

- [sliderTintColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L155)

Slider tint color

- [draggersColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L156)

Draggers background color

- [draggerImageName: String?](/Example/Example/Extension/MusicEditorConfig.swift#L157)

Image name setups draggers additional UIImage

- [trimHeight: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L158)

Trim container heught

- [trimBorderColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L159)

Trim container border lines color

- [trimBorderWidth: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L160)

Trim container border lines width

- [cursorHeight: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L161)

Cursor height

- [dimViewColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L162)

Dim view background color

- [mainLabelColors: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L163)

Main labels' title color

- [additionalLabelColors: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L164)

Additional labels' title color

- [cursorColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L165)

Cursor background color

- [draggersWidth: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L166)

Draggers' view width

- [draggersLineColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L167)

Draggers' central line view color

- [draggersCornerRadius: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L168)

Draggers' view corner radius

- [draggersLineWidth: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L169)

Draggers' central line view width

- [draggersLineHeight: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L170)

Draggers' central line view height

- [numberOfLinesInDraggers: Int](/Example/Example/Extension/MusicEditorConfig.swift#L171)

Number of draggers' central lines

- [draggerLinesSpacing: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L172)

Draggers' central lines spacing

- [draggersLineCornerRadius: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L173)

Draggers' central lines corner radius

- [backgroundConfiguration: BackgroundConfiguration](/Example/Example/Extension/MusicEditorConfig.swift#L174)

BackgroundConfiguration setups common container view background style

- [voiceFilterConfiguration: VoiceFilterConfiguration?](/Example/Example/Extension/MusicEditorConfig.swift#L175)

VoiceFilterConfiguration seups voice filter container view item style

- voiceFilterProvider: VoiceFilterProvider?

VoiceFilterProvider setups voice filters provider

- isVoiceFilterHidden: Bool

Voice Filter will be hidden if voiceFilterProvider is nil



## AudioWaveConfiguration
 
  - [isRandomWaveColor: Bool](/Example/Example/Extension/MusicEditorConfig.swift#L159)

  Is random wave color enabled
  
  - [backgroundColor: UIColor?](/Example/Example/Extension/MusicEditorConfig.swift#L1)
  
  Background color view
  
  - [waveBorderColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L1)

  Time line border color
  
  - [waveCornerRadius: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L1)

  Time lime corner radius
  
  - [waveLinesColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L160)

  Audio wave lines color
 
  - [borderWidth: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L1)

  Time line border width
  
  - [height: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L1)

  Time line height
  
  - [maxWaveHeight: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L1)
  
  Max audio wave height
  
  - [audioTitleFont: UIFont?](/Example/Example/Extension/MusicEditorConfig.swift#L1)

  Audio title font
  
  - [audioTitleColor: UIColor?](/Example/Example/Extension/MusicEditorConfig.swift#L1)

  Audio title color
  
  - [bottomOffset: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L1)

  Time line bottom offset

![img](screenshots/AudioEditScreen.png)

## String resources

![img](screenshots/MusicLocalization.png)

| Key        |      Value      |   Description |
| ------------- | :----------- | :------------- |
| MusicEditor.Delete | Delete | Delete track button title
| MusicEditor.Volume | Volume | Edit track volume button title
| MusicEditor.VoiceEffect | Effect | Voice effect button title
| MusicEditor.Edit | Edit | Edit track button title
| MusicEditor.Tracks | Tracks | Add track button title
| MusicEditor.Effects | Effects | Add effects button title
| MusicEditor.Record | Record | Add voice record button title
| MusicEditor.VideoVolume | Volume | Video volume title
| MusicEditor.Duration | Duration | Audio duration title
| MusicEditor.Cancel | Cancel | Cancel button title
| MusicEditor.Yes | Yes | Confirmation button title
| MusicEditor.No | No | Discarding button title
| com.banuba.musicEditor.mainScreen.resetAll.title | Discard changes? | Confirmation message for discarding changes
| MusicEditor.Max available tracks - %i | Max available tracks - %i | Error message when a user tries to add tracks with reached limit
| com.banuba.musicEditor.elf | Elf | Elf filter title
| com.banuba.musicEditor.baritone | Baritone | Baritone filter title
| com.banuba.musicEditor.echo | Echo | Echo filter title
| com.banuba.musicEditor.giant | Giant | Giant filter title
| com.banuba.musicEditor.robot | Robot | Robot filter title
| com.banuba.musicEditor.squirrel | Squirrel | Squirrel filter title
| Undo | Undo | Undo applied to video in the add sound screen
