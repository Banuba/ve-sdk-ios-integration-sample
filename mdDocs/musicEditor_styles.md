# Banuba VideoEditor SDK
## MusicEditorConfig

- [mainMusicViewControllerConfig: MainMusicViewControllerConfig](/Example/Example/Extension/MusicEditorConfig.swift#L6)

MainMusicViewControllerConfig setups main screen style

- [videoTrackLineEditControllerConfig: VideoTrackLineEditViewControllerConfig](/Example/Example/Extension/MusicEditorConfig.swift#L7)

VideoTrackLineEditViewControllerConfig setups video track line editing screen style

- [audioTrackLineEditControllerConfig: AudioTrackLineEditViewControllerConfig](/Example/Example/Extension/MusicEditorConfig.swift#L8)

VideoTrackLineEditViewControllerConfig setups audio track line editing screen style

- [audioRecorderViewControllerConfig: AudioRecorderViewControllerConfig](/Example/Example/Extension/MusicEditorConfig.swift#L9)

AudioRecorderViewControllerConfig setups audio recorder style

- [isAudioBrowserEnabled: Bool](/Example/Example/ViewController.swift#L71)

Is audio browser enabled. (audioBrowser framework exist only)

## MainMusicViewControllerConfig

- [editButtons: [EditButtonConfig]](/Example/Example/Extension/MusicEditorConfig.swift#L17)

Array of adding buttons

- [editButtonsHeight: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L41)

Adding buttons container height

- [editCompositionButtons: [EditCompositionButtonConfig]](/Example/Example/Extension/MusicEditorConfig.swift#L43)

Array of edit composition buttons

- [controlButtons: [ControlButtonConfig]](/Example/Example/Extension/MusicEditorConfig.swift#L62)

Aray of control buttons

- [playerControlsHeight: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L80)

Сontrol buttons container height

- [audioWaveConfiguration: AudioWaveConfiguration](/Example/Example/Extension/MusicEditorConfig.swift#L81)

AudioWaveConfiguration setups audio wave style

- [mainLabelColors: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L82)

Color for main titles color

- [additionalLabelColors: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L83)

Color for additional titles color

- [speakerImageName: String](/Example/Example/Extension/MusicEditorConfig.swift#L84)

 Image name setups speaker image view

- [volumeLabel: TextButtonConfig](/Example/Example/Extension/MusicEditorConfig.swift#L85)

TextButtonConfig setups volume label title style

- [tracksLimit: Int](/Example/Example/Extension/MusicEditorConfig.swift#L86)

Number of maximum tracks

- [cursorColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L87)

Cursor color

- [controlsBackgroundConfiguration: BackgroundConfiguration](/Example/Example/Extension/MusicEditorConfig.swift#L88)

BackgroundConfiguration setups controls container background style

- [backgroundConfiguration: BackgroundConfiguration](/Example/Example/Extension/MusicEditorConfig.swift#L89)

BackgroundConfiguration setups main view background style

- [timelineCornerRadius: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L90)

Time line corner radius

![img](screenshots/MusicEditorMainScreen.png)





## AudioRecorderViewControllerConfig

- [rewindToStartButton: ControlButtonConfig?](/Example/Example/Extension/MusicEditorConfig.swift#L98)

ControlButtonConfig setups rewind to start button

- [playPauseButton: ControlButtonConfig](/Example/Example/Extension/MusicEditorConfig.swift#L104)

ControlButtonConfig setups play pause button

- [playerControlsHeight: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L110)

Player controls height

- [recordButton: ControlButtonConfig](/Example/Example/Extension/MusicEditorConfig.swift#L112)

ControlButtonConfig setups record button

- [backButtonImage: String](/Example/Example/Extension/MusicEditorConfig.swift#L118)

Image name setups back button UIImage

- [doneButtonImage: String](/Example/Example/Extension/MusicEditorConfig.swift#L119)

 Image name setups done button UIImage

- [dimViewColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L120)

Dim view color

- [additionalLabelColors: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L121)

Additional labels color

- [startingRecordingTimerSeconds: TimeInterval](/Example/Example/Extension/MusicEditorConfig.swift#L122)

Countdown to start recording

- [timerColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L123)

Timer color

- [cursorColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L124)

Cursor color

- [backgroundConfiguration: BackgroundConfiguration](/Example/Example/Extension/MusicEditorConfig.swift#L125)

BackgroundConfiguration setups background view

- [playerControlsBackgroundConfiguration: BackgroundConfiguration](/Example/Example/Extension/MusicEditorConfig.swift#L126)

BackgroundConfiguration setups player controls background view

- [timelineCornerRadius: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L127)

Time line corner radius

![img](screenshots/AudioRecorderScreen.png)





## VideoTrackLineEditViewControllerConfig

- [doneButtonImageName: String](/Example/Example/Extension/MusicEditorConfig.swift#L135)

Image name setups done button UIImage

- [doneButtonTintColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L136)

Done button tint color

- [sliderTintColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L137)

Slider tint color

- [mainLabelColors: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L138)

Main labels color

- [additionalLabelColors: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L139)

Additional labels colors

- [backgroundConfiguration: BackgroundConfiguration](/Example/Example/Extension/MusicEditorConfig.swift#L140)

BackgroundConfiguration setups background view

- [height: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L141)

Pop-up screen's height

![img](screenshots/VideoEditScreen.png)




## AudioTrackLineEditViewControllerConfig

- [audioWaveConfiguration: AudioWaveConfiguration](/Example/Example/Extension/MusicEditorConfig.swift#L149)

AudioWaveConfiguration setups audio wave style

- [doneButtonImageName: String](/Example/Example/Extension/MusicEditorConfig.swift#L151)

Image name setups done buttom UIImage

- [doneButtonTintColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L152)

Done button tint color

- [sliderTintColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L153)

Slider tint color

- [draggersColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L154)

Draggers background color

- [draggerImageName: String?](/Example/Example/Extension/MusicEditorConfig.swift#L155)

Image name setups draggers additional UIImage

- [trimHeight: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L156)

Trim container heught

- [trimBorderColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L157)

Trim container border lines color

- [trimBorderWidth: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L158)

Trim container border lines width

- [cursorHeight: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L159)

Cursor height

- [dimViewColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L160)

Dim view background color

- [mainLabelColors: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L161)

Main labels' title color

- [additionalLabelColors: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L162)

Additional labels' title color

- [cursorColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L163)

Cursor background color

- [draggersWidth: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L164)

Draggers' view width

- [draggersLineColor: UIColor](/Example/Example/Extension/MusicEditorConfig.swift#L165)

Draggers' central line view color

- [draggersCornerRadius: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L166)

Draggers' view corner radius

- [draggersLineWidth: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L167)

Draggers' central line view width

- [draggersLineHeight: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L168)

Draggers' central line view height

- [numberOfLinesInDraggers: Int](/Example/Example/Extension/MusicEditorConfig.swift#L169)

Number of draggers' central lines

- [draggerLinesSpacing: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L170)

Draggers' central lines spacing

- [draggersLineCornerRadius: CGFloat](/Example/Example/Extension/MusicEditorConfig.swift#L171)

Draggers' central lines corner radius

- [backgroundConfiguration: BackgroundConfiguration](/Example/Example/Extension/MusicEditorConfig.swift#L172)

BackgroundConfiguration setups common container view background style

- [voiceFilterConfiguration: VoiceFilterConfiguration?](/Example/Example/Extension/MusicEditorConfig.swift#L173)

VoiceFilterConfiguration seups voice filter container view item style

- voiceFilterProvider: VoiceFilterProvider?

VoiceFilterProvider setups voice filters provider

![img](screenshots/AudioEditScreen.png)
