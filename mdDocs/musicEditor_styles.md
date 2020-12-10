# Banuba VideoEditor SDK
## MusicEditorConfig

- mainMusicViewControllerConfig: MainMusicViewControllerConfig

MainMusicViewControllerConfig setups main screen style

- videoTrackLineEditControllerConfig: VideoTrackLineEditViewControllerConfig

VideoTrackLineEditViewControllerConfig setups video track line editing screen style

- audioTrackLineEditControllerConfig: AudioTrackLineEditViewControllerConfig

VideoTrackLineEditViewControllerConfig setups audio track line editing screen style

- audioRecorderViewControllerConfig: AudioRecorderViewControllerConfig

AudioRecorderViewControllerConfig setups audio recorder style

- isAudioBrowserEnabled: Bool

Is audio browser enabled. (audioBrowser framework exist only)

## MainMusicViewControllerConfig

- editButtons: [EditButtonConfig]

Array of adding buttons

- editButtonsHeight: CGFloat

Adding buttons container height

- editCompositionButtons: [EditCompositionButtonConfig]

Array of edit composition buttons

- controlButtons: [ControlButtonConfig]

Aray of control buttons

- playerControlsHeight: CGFloat

Сontrol buttons container height

- audioWaveConfiguration: AudioWaveConfiguration

AudioWaveConfiguration setups audio wave style

- mainLabelColors: UIColor

Color for main titles color

- additionalLabelColors: UIColor

Color for additional titles color

- speakerImageName: String

 Image name setups speaker image view

- volumeLabel: TextButtonConfig

TextButtonConfig setups volume label title style

- tracksLimit: Int

Number of maximum tracks

- cursorColor: UIColor

Cursor color

- controlsBackgroundConfiguration: BackgroundConfiguration

BackgroundConfiguration setups controls container background style

- backgroundConfiguration: BackgroundConfiguration

BackgroundConfiguration setups main view background style

- timelineCornerRadius: CGFloat

Time line corner radius

![img](screenshots/MusicEditorMainScreen.png)

## AudioRecorderViewControllerConfig

- rewindToStartButton: ControlButtonConfig?

ControlButtonConfig setups rewind to start button

- playPauseButton: ControlButtonConfig

ControlButtonConfig setups play pause button

- playerControlsHeight: CGFloat

Player controls height

- recordButton: ControlButtonConfig

ControlButtonConfig setups record button

- backButtonImage: String

Image name setups back button UIImage

- resetButtonImage: String

Image name setups reset button UIImage

- doneButtonImage: String

 Image name setups done button UIImage

- dimViewColor: UIColor

Dim view color

- additionalLabelColors: UIColor

Additional labels color

- startingRecordingTimerSeconds: TimeInterval

Countdown to start recording

- timerColor: UIColor

Timer color

- cursorColor: UIColor

Cursor color

- backgroundConfiguration: BackgroundConfiguration

BackgroundConfiguration setups background view

- playerControlsBackgroundConfiguration: BackgroundConfiguration

BackgroundConfiguration setups player controls background view

- timelineCornerRadius: CGFloat

Time line corner radius

![img](screenshots/AudioRecorderScreen.png)

## VideoTrackLineEditViewControllerConfig

- doneButtonImageName: String

Image name setups done button UIImage

- doneButtonTintColor: UIColor

Done button tint color

- sliderTintColor: UIColor

Slider tint color

- mainLabelColors: UIColor

Main labels color

- additionalLabelColors: UIColor

Additional labels colors

- backgroundConfiguration: BackgroundConfiguration

BackgroundConfiguration setups background view

- height: CGFloat

Pop-up screen's height

![img](screenshots/VideoEditScreen.png)

## AudioTrackLineEditViewControllerConfig

- audioWaveConfiguration: AudioWaveConfiguration

AudioWaveConfiguration setups audio wave style

- doneButtonImageName: String

Image name setups done buttom UIImage

- doneButtonTintColor: UIColor

Done button tint color

- sliderTintColor: UIColor

Slider tint color

- draggersColor: UIColor

Draggers background color

- draggerImageName: String?

Image name setups draggers additional UIImage

- trimHeight: CGFloat

Trim container heught

- trimBorderColor: UIColor

Trim container border lines color

- trimBorderWidth: CGFloat

Trim container border lines width

- cursorHeight: CGFloat

Cursor height

- dimViewColor: UIColor

Dim view background color

- mainLabelColors: UIColor

Main labels' title color

- additionalLabelColors: UIColor

Additional labels' title color

- cursorColor: UIColor

Cursor background color

- draggersWidth: CGFloat

Draggers' view width

- draggersLineColor: UIColor

Draggers' central line view color

- draggersCornerRadius: CGFloat

Draggers' view corner radius

- draggersLineWidth: CGFloat

Draggers' central line view width

- draggersLineHeight: CGFloat

Draggers' central line view height

- numberOfLinesInDraggers: Int

Number of draggers' central lines

- draggerLinesSpacing: CGFloat

Draggers' central lines spacing

- draggersLineCornerRadius: CGFloat

Draggers' central lines corner radius

- backgroundConfiguration: BackgroundConfiguration

BackgroundConfiguration setups common container view background style

- voiceFilterConfiguration: VoiceFilterConfiguration?

VoiceFilterConfiguration seups voice filter container view item style

- voiceFilterProvider: VoiceFilterProvider?

VoiceFilterProvider setups voice filters provider

![img](screenshots/AudioEditScreen.png)
