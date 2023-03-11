# Video recording integration guide

- [Quality details](#Quality-details)
- [Implement configurations](#Implement-configurations)
- [Configure microphone state](#Configure-microphone-state)
- [Configure recording modes](#Configure-recording-modes)
- [Configure timer](#Configure-timer)
- [Configure hands free](#Configure-hands-free)
- [Configure record button appearance](#Configure-record-button-appearance)
- [Picture in picture](#Picture-in-picture)
- [Configure camera screen appearance](#Configure-camera-screen-appearance)

## Quality details
Subsequent table describes video quality details used for video recording in various resolutions.  
To be able to use your own quality parametrs please follow this [guide](video_resolution_configuration.md).

| Recording speed | 360p(360 x 640) | 480p(480 x 854) | 540p(540 x 960) |  HD(720 x 1280) | FHD(1080 x 1920) |
| --------------- | --------------- | --------------- | --------------- | --------------- | ---------------- |
| 1x(Default)     | 800             | 2000            | 2000            | 4000            | 6400             |
| 0.5x            | 800             | 2000            | 2000            | 4000            | 6400             |
| 2x              | 800             | 2000            | 2000            | 4000            | 6400             |
| 3x              | 800             | 2000            | 2000            | 4000            | 6400             |  


## Implement configurations
```VideoEditorConfig``` is a main class used to customize features, behavior and user experience for video recording on camera screen i.e. set min/max recording duration, flashlight, etc.  
Video editor includes default implementation but you can provide your own implementation to meet your requirements in [ViewController](../Example/Example/ViewController.swift#L111).  

```VideoEditorDurationConfig``` is a main class for implementing custom recording features.

| Property |                Values                | Description |
| ------------- |:------------------------------------:| :------------- |
| maximumVideoDuration | TimeInterval > 0; Default ```60.0``` | ...
| minimumDurationFromCamera |   IN PROGRESS   | IN PROGRESS
| minimumDurationFromGallery |  IN PROGRESS   | IN PROGRESS
| minimumVideoDuration |   IN PROGRESS    | IN PROGRESS
| minimumTrimmedPartDuration |   IN PROGRESS    | IN PROGRESS
| slideshowDuration |   IN PROGRESS    | IN PROGRESS
| tolerance |             IN PROGRESS              | IN PROGRESS

In this example, maximum video duration(RECORDING??) is set to 30 seconds.

```swift
var config = VideoEditorConfig()
config.videoDurationConfiguration.maximumVideoDuration = 30.0
```

IN PROGRESS
```FeatureConfig``` helps to customize features on Camera screen.

| Property |            Values            | Description |
| ------------- |:----------------------------:| :------------- |
| minimumDurationFromCamera |          Double > 0          | for the minimum recording duration *in seconds* that is allowed to proceed with Editor screen (i.e. 3.0 for 3 seconds)
| maximumVideoDuration |          Double > 0          | for the maximum video duration *in seconds* available to record on the camera (i.e. 60.0 for 1 minute)
| minimumDurationFromGallery |          Double > 0          | for the maximum video duration *in seconds*  available to Duration video from Gallery (i.e. 3.0 for 3 seconds)
| minimumTrimmedPartDuration |          Double > 0          | for the maximum video duration *in seconds*  available to video part minimum duration at trimmer (i.e. 2.0 for 2 seconds)
| isDefaultFrontCamera |          true/false          | defines which camera will open by default on your device(*true* means the front camera opens by default, *false* means the main camera opens by default
| captureButtonModes | Set`<CaptureButtonViewMode>` | defines captureButtonMods setups camera capturing functionality. By default [.video, .photo]
| loopAudioWhileRecording |          true/false          | defines whether to loop the selected track during video recording (*true* means that the track will be repeated while recording is in progress, *false* means that the track will play once)
| takeAudioDurationAsMaximum |          true/false          | determines what maximum recording duration to take if a track is installed (*true* set the maximum duration equal to the duration of the selected track, *false* take the maximum recording duration from ***maximumVideoDuration***
| isMuteCameraAudioEnabled |          true/false          | setups the mute icon on the camera overlay and possibility to make video recording without capturing sound
| useHEVCCodecIfPossible |          true/false          | intermediate video will be encoded using the HEVC (H.265) encoder if available on the current device.


## Configure microphone state
IN PROGRESS...

## Configure recording modes
IN PROGRESS...

## Configure timer
IN PROGRESS...

## Configure hands free
IN PROGRESS...

## Configure record button appearance
IN PROGRESS
The record button is a main control on the camera screen which you can fully customize along with animations playing on tap.

First of all look at [RecordButtonConfiguration](record_button_configuration.md) entity which you can customize in [Camera screen configuration quide](camera_styles.md). If it still not suits your needs you can create your own view for more information look [here](record_button_provider.md)




## Picture in picture
Picture in picture mode is optional for the video editor SDK and would be disabled if it is not included in your token.
Use ```presentVideoEditor``` method to start Video Editor in picture in picture mode

```swift
/// - Parameters:
///   - configuration: contains configurations for launching Video editor's screen
///   - completion: The block to execute after the presentation finishes.
let config = VideoEditorLaunchConfig(
  entryPoint: .pip,
  hostController: self,
  pipVideoItem: resultUrls[.zero],
  animated: true
)
videoEditorSDK?.presentVideoEditor(
  withLaunchConfiguration: config,
  completion: nil
)
```

## PIP Configuration

``` swift
/// The picture in picture mode configuration
public struct PIPSettingsConfiguration {
  /// BackgroundConfiguration setups background view style
  public var backgroundConfiguration: BackgroundConfiguration
  /// Cursor color
  public var dragIndicatorConfiguration: RoundedButtonConfiguration
  /// Title font for controls
  public var titleConfiguration: TextConfiguration
  /// Main settings button's configurations
  public var layoutSettingsButtonsConfiguration: [PIPSelectableCellConfiguration]
}
``` 

Picture in picture supports four modes ```.floating```, ```.topBottom```, ```.react```, ```.leftRight```. You can customize the order of this modes and which of them will be available.
Use PIPSelectableCellConfiguration to achieve this

## PIPSelectableCellConfiguration

``` swift
/// The picture in picture cell's configuration
public struct PIPSelectableCellConfiguration {
  /// The button Identifier
  public var identifier: PIPPlayerLayoutSetting
  /// The PIP selectable cell switch config
  public var switchCellConfiguration: PIPSwitchCellConfiguration?
  /// The PIP selectable cell camera config
  public var cameraCellConfiguration: PIPCameraCellConfiguration
  /// The PIP selectable cell cropping config. Only for React mode.
  public var croppingCellConfiguration: PIPCameraCellConfiguration?
  /// The button text configuration.
  public var textConfiguration: TextConfiguration
  /// The default image configuration
  public var imageConfiguration: ImageConfiguration
  /// The border width configuration.
  public var borderWidth: CGFloat
  /// The border color configuration.
  public var borderColor: CGColor
  /// Is image view circable
  public var isRoundedImageView: Bool
  /// The corner radius configuration
  public var cornerRadius: CGFloat?
  /// The background color configuration.
  public var backgroundColor: UIColor
  /// Additional button width.
  ///Default is 130
  public var additionalButtonWidth: CGFloat
  /// Additional button height.
  ///Default is 32
  public var additionalButtonHeight: CGFloat
}
``` 

### Example

``` swift
var config = VideoEditorConfig()

config.pipSettingsConfiguration?.layoutSettingsButtonsConfiguration = [
  PIPSelectableCellConfiguration(identifier: .floating),
  PIPSelectableCellConfiguration(identifier: .react),
  PIPSelectableCellConfiguration(identifier: .topBottom),
  PIPSelectableCellConfiguration(identifier: .leftRight)
]
``` 

## Configure camera screen appearance

Here we set up the styles for the recording screen. These configs are for customizing action button icons, adjusting relative position and appearance of music, gallery, switching camera icons. Icons configurable using this style's custom attributes (for example, [icon_mask_on](/Example/Example/Extension/RecorderConfiguration.swift#L82) and [icon_mask_off](/Example/Example/Extension/RecorderConfiguration.swift#L81) setup drawings for icons associated with the applied AR mask effect)

- [videoResolution: VideoResolutionConfiguration](../Example/Example/Extension/RecorderConfiguration.swift#L9)

VideoResolutionConfiguration sets up the camera options for capturing and rendering video

- [saveButton: SaveButtonConfiguration?](../Example/Example/Extension/RecorderConfiguration.swift#L41)

SaveButtonConfiguration sets up the save button style

- [backButton: BackButtonConfiguration](../Example/Example/Extension/RecorderConfiguration.swift#L52)

BackButtonConfiguration sets up the back button style

- [backToDraftsButton: BanubaButtonConfiguration](../Example/Example/Extension/RecorderConfiguration.swift#L7)

BanubaButtonConfiguration sets up the back to drafts button

- [removeButtonImageName: String](../Example/Example/Extension/RecorderConfiguration.swift#L53)

ImageName sets up the remove button UIImage

- [progressLabelConfiguration: TextConfiguration?](../Example/Example/Extension/RecorderConfiguration.swift#L7)

Sets up the top progress label style. Only for horizontal recorder.

- [floatingLineViewConfiguration: TextConfiguration?](../Example/Example/Extension/RecorderConfiguration.swift#L7)

Sets up the top floating line view style.

- [floatingLineViewWidth: CGFloat?](../Example/Example/Extension/RecorderConfiguration.swift#L7)

Sets up the width for floatingLineView. Default is 150.

- [сaptureButtonMode: CaptureButtonMode](../Example/Example/Extension/RecorderConfiguration.swift#L7)

CaptureButtonMode contains two varieties:
1. Mixed. Photo and video camera functionality.
2. Video. Only photo camera functionality.

- [recordButtonConfiguration: RecordButtonConfiguration](../Example/Example/Extension/RecorderConfiguration.swift#L55)

RecordButtonConfiguration sets up the capture button style

- [recordButtonProvider: RecordButtonProvider?](../Example/Example/Extension/RecorderConfiguration.swift#L7)

RecordButtonProvider provides access to the possibility for creating a custom capture button

- [additionalEffectsButtons: [AdditionalEffectsButtonConfiguration]](../Example/Example/Extension/RecorderConfiguration.swift#L62)

AdditionalEffectsButtonConfiguration array sets up all of the camera screen control buttons' styles

- [speedBarButtons: SpeedBarButtonsConfiguration](../Example/Example/Extension/RecorderConfiguration.swift#L62)

SpeedButtonConfiguration sets up the speed button style

- [galleryButton: RoundedButtonConfiguration](../Example/Example/Extension/RecorderConfiguration.swift#L129)

RoundedButtonConfiguration sets up the gallery button style

- [emptyGalleryImageName: String](../Example/Example/Extension/RecorderConfiguration.swift#L130)

Image name sets up the gallery button image for empty gallery state

- [timerConfiguration: TimerConfiguration](../Example/Example/Extension/RecorderConfiguration.swift#L132)

TimerConfiguration sets up the timer functionality options

- [timeLineConfiguration: TimeLineConfiguration](../Example/Example/Extension/RecorderConfiguration.swift#L141)

TimeLineConfiguration sets up the progress bar style for sequences

- [regularRecordButtonPosition: CGFloat](../Example/Example/Extension/RecorderConfiguration.swift#L144)

This value sets up the capture button posttion according to the screen bottom

- [recorderEffectsConfiguration: RecorderEffectsConfiguration](../Example/Example/Extension/RecorderConfiguration.swift#L145)

RecorderEffectsConfiguration sets up the effects list style

- [leftControlsBottomOffsetFromCaptureButton: CGFloat](../Example/Example/Extension/RecorderConfiguration.swift#L146)

This value sets up the left controls position according to the capture button bottom

- [leftControlsLeftOffset: CGFloat](../Example/Example/Extension/RecorderConfiguration.swift#L147)

This value sets up the left controls position according to the capture button leading edge

- [sequenceHeight: CGFloat](../Example/Example/Extension/RecorderConfiguration.swift#L148)

Sequence bar height

- [loopAudioWhileRecording: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L150)

Loop audio while recording video if music is selected

- [takeAudioDurationAsMaximum: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L151)

This flag suggests that the given audio duration determines the maximum recording length

- [isDynamicMusicTitle: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L152)

Spacing between button and circular timeline

- [isDefaultFrontCamera: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L7)

This value provides the ability to open the front camera by default

- [isMusicTitleFloatingLineEnabled: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L7)

This value sets up whether the music title floating view is enabled

- [useHEVCCodecIfPossible: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L7)

The intermediate video will encoded with HEVC (H.265) encoder if it is available on the current device. Better quality, smaller size, better performance

- [isPhotoSequenceAnimationEnabled: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L7)

Should use animation for photo sequences

- [muteMicrophoneForPIP: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L7)

Mute microphone on PIP screen. Default is false.

- [isAudioRateEqualsVideoSpeed: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L158)

Applies video speed to audio player rate. Default is false.

- [isGalleryButtonHidden: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L159)

Hide gallery button. Defaults is false.

- [supportMultiRecords: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L160)

If recorded video can consist of more than one sequence. Default is true.

- [videoCaptureButtonConfiguration: BanubaUtilities.RoundedButtonConfiguration](../Example/Example/Extension/RecorderConfiguration.swift#L172)

Video capture button mode setup configuration

- [photoCaptureButtonConfiguration: BanubaUtilities.RoundedButtonConfiguration](../Example/Example/Extension/RecorderConfiguration.swift#L184)

Photo capture button mode setup configuration

- [backroundMusicContainerConfiguration: BanubaUtilities.BackgroundConfiguration?](../Example/Example/Extension/RecorderConfiguration.swift#L190)

Special for top centered music button config

- [floatingViewSeparatedLines: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L192)

Is floating view supports two lines

- [effectSelectorContainerCornerRadius: CGFloat](../Example/Example/Extension/RecorderConfiguration.swift#L193)

Effect selector container corner radius. Default is 8.0

- [preferredStatusBarStyle: UIStatusBarStyle](../Example/Example/Extension/RecorderConfiguration.swift#L194)

The style of the status bar.

- [isAudioRateEqualsVideoSpeed: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L7)

Applies video speed to audio player rate. Default is false.

- [isGalleryButtonHidden: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L7)

Hide gallery button. Default is false.

- [supportMultiRecords: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L7)

If recorded video can consist of more than one sequence. Default is true.

![img](screenshots/RecorderConfiguration.png)

You can change the position for the music button, for this you need:

In the array with additionalEffectsButtons, for the button with the identifier **.sound**, set up the [position](../Example/Example/Extension/RecorderConfiguration.swift#L72) property

- bottom
- center
- top

   <img src="screenshots/bottom.PNG" width="200" />  <img src="screenshots/center.PNG" width="200" />  <img src="screenshots/top.PNG" width="200" />

## String resources

![img](screenshots/CameraScreenLocalizations.png)

| Key        |      Value      |   Description |
| ------------- | :----------- | :------------- |
| Music | Music | Music selection screen title
| Delete | Delete | Audio track delete action
| Voice | Voice | Title on the screen of the voice recorder
| Yes | Yes | Used when the question is answered yes
| No | No | Used when answering a negative question
| Error | Error | Title of the message if an error occurs
| Next | Next | Move to next screen
| Publish | Publish | Publish video
| Back | Back | Return to the previous screen
| Cancel | Cancel | Ability to cancel
| BanubaVideoEditor.Settings.Later| Later | Alert action button title
| BanubaVideoEditor.Settings.Discard | Discard | Alert action button title
| Do you want to stop capturing and editing the video? | Do you want to stop capturing and editing the video? | Used in alert with Yes and No options when resetting filters.
| Do you want to reset all? | Do you want to reset all? | Used in alert with Yes and No options when resetting filters.
| Do you want to reset slideshow? | Do you want to reset slideshow? | Used in alert with Yes and No options when resetting slideshow.
| Do you want to delete the last clip? | Do you want to delete the last clip? | Used in alert with Yes and No options
| BanubaVideoEditor.NotFinishedVideoSequenceAlertQuestion | You have a new draft. Continue editing it? | Asking about continuing editing session
| First part not recorded | First part not recorded | Error message that appears when clicking the Next button in the camera when the first part of split mode is not recorded
| Mask not loaded | Mask not loaded | Error message received when trying to load a mask
| Second part is too short | Second part is too short | An error message that appears when you click the Next button in the camera, when the second part of the video in split mode is not equal in length to the first part
| Beautifier on/Beautifier off | Beautifier on/Beautifier off | Second part is too short
| Flash | Light | The light (flashlight) in the camera is on
| Too short. Please capture at least %d seconds | Too short. Please capture at least %d seconds | An error message that appears in the camera when the length of the recorded video is less than the minimum allowed duration
| Maximum %d seconds. | Maximum %d seconds. | An error message that appears in the camera if the recorded video is longer than the maximum allowed length
| Timer is off | Timer is off | Turning off the camera's auto timer
| Max length %d sec | Max length %d sec | 'Seconds' for maximum
| %d sec | %d sec | 'Seconds' for short
| Choose video | Choose video | Screen title when multi-select mode is enabled on the video gallery screen
| Choose | Choose | Name of the button in multi-select mode, which confirms the selection of user files and continues the process further
| Sound | Sound | Built-in track volume description
| Add | Add | Add extra audio track action
| %i seconds timer is on | %i seconds timer is on | Enabling the countdown timer to automatically start shooting in the camera
| Recording speed %@ | Recording speed %@ | Speed screen info
| com.banuba.recorder.sound.title | Music | Music button title
| com.banuba.recorder.beauty.title | Beauty | Beauty button title
| com.banuba.recorder.color.title | Filter | Filter button title
| com.banuba.recorder.masks.title | Masks | Masks button title
| com.banuba.recorder.toggle.title | Toggle | Toggle button title
| com.banuba.recorder.flashlight.title | Flashlight button title
| com.banuba.recorder.timer.title | Timer | Timer button title
| com.banuba.recorder.speed.title | Speed | Speed button title
| com.banuba.recorder.muteSound.title | Sound | Sound button title