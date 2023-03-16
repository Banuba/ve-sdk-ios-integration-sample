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
Subsequent table describes video quality details used for video recording in various resolutions with h264 codec.
If h265(HEVC) is used for recording video the values listed below will be reduced 15% for better video performance.

| Recording speed | 360p(360 x 640) | 480p(480 x 854) | 540p(540 x 960) |  HD(720 x 1280) | FHD(1080 x 1920) |
| --------------- | --------------- | --------------- | --------------- | --------------- | ---------------- |
| 1x(Default)     | 1000             | 2500            | 3000            | 5000            | 8000             |
| 0.5x            | 1000             | 2500            | 3000            | 5000            | 8000             |
| 2x              | 1000             | 2500            | 3000            | 5000            | 8000             |
| 3x              | 1000             | 2500            | 3000            | 5000            | 8000             |  

## Implement configurations
```VideoEditorConfig``` is a main class used to customize features, behavior and user experience for video recording on camera screen i.e. set min/max recording duration, flashlight, etc. 
The class includes many internal config classes that can be used to customize specific feature.  

The SDK includes default implementations however you can customize configurations and provide your own implementations to meet your requirements in [VideoEditorModule](../Example/Example/VideoEditorModule.swift#L50).  

```VideoEditorDurationConfig``` is a class that is responsible for customizing video recording duration values.
:exclamation: Important    
All values are in seconds.

| Property |                           Values                            | Description |
| ------------- |:-----------------------------------------------------------:| :------------- |
| maximumVideoDuration |            TimeInterval > 0; Default ```120.0```            | the maximum allowed video duration
| videoDurations | [TimeInterval] not empty; Default  ```[60.0, 30.0, 15.0]``` | array of durations allowed to record video. The user sees a certain button and can change duration by tap. For example,  ```60.0``` means that the user can record multiple video sources with total duration no more than ```60.0``` seconds.
| minimumDurationFromCamera |             TimeInterval > 0; Default ```3.0```             | the minimum allowed video duration required to proceed and open next screen
| minimumDurationFromGallery |             TimeInterval > 0; Default ```0.3```             | the minimum allowed video duration displayed on gallery
| minimumVideoDuration |             TimeInterval > 0; Default ```1.0```             | the minimum allowed video source duration that can be recorded on camera
| minimumTrimmedPartDuration |             TimeInterval > 0; Default ```0.3```             | minimum video source duration that is allowed to trim
| slideshowDuration |             TimeInterval > 0; Default ```0.3```             | slideshow video duration produced by image

In this example, the maximum video recording duration is set to 30 seconds.
```swift
var config = VideoEditorConfig()
config.videoDurationConfiguration.maximumVideoDuration = 30.0
```

```FeatureConfiguration``` helps to customize features on Camera screen.

| Property |          Values           | Description |
| ------------- |:-------------------------:| :------------- |
| isDoubleTapForToggleCameraEnabled | Bool; Default ```false``` | enable switchicng between front and back camera facing by double tap on camera screen
| isMuteCameraAudioEnabled | Bool; Default ```false``` | indicates if mute microphone button is visible on camera screen   
| isSpeedBarEnabled | Bool; Default ```true```  | enables speed selection bar. If bar is disabled speed recording will iterativly switched by tapping
| openAutomaticallyPIPSettingsDropdown | Bool; Default ```false``` | if this property enabled the pip settings drop down view will be presented after opening camera screen


- [loopAudioWhileRecording: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L150) -Loop audio while recording video if music is selected
- [takeAudioDurationAsMaximum: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L151) -This flag suggests that the given audio duration determines the maximum recording length
- [isDynamicMusicTitle: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L152) - Spacing between button and circular timeline
- [isDefaultFrontCamera: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L7) - This value provides the ability to open the front camera by default
- [isMusicTitleFloatingLineEnabled: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L7) - This value sets up whether the music title floating view is enabled
- [useHEVCCodecIfPossible: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L7) - The intermediate video will encoded with HEVC (H.265) encoder if it is available on the current device. Better quality, smaller size, better performance
- [isPhotoSequenceAnimationEnabled: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L7) - Should use animation for photo sequences
- [muteMicrophoneForPIP: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L7) - Mute microphone on PIP screen. Default is false.
- [isAudioRateEqualsVideoSpeed: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L158) - Applies video speed to audio player rate. Default is false.
- [isGalleryButtonHidden: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L159) - Hide gallery button. Defaults is false.
- [supportMultiRecords: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L160) - If recorded video can consist of more than one sequence. Default is true.
- [isAudioRateEqualsVideoSpeed: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L7) - Applies video speed to audio player rate. Default is false.
- [isGalleryButtonHidden: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L7) - Hide gallery button. Default is false.
- [supportMultiRecords: Bool](../Example/Example/Extension/RecorderConfiguration.swift#L7) - If recorded video can consist of more than one sequence. Default is true.
- [recorderEffectsConfiguration: RecorderEffectsConfiguration](../Example/Example/Extension/RecorderConfiguration.swift#L145) - RecorderEffectsConfiguration sets up the effects list style


All you need is just to set ```useHEVCCodecIfPossible``` to ```true``` in ```VideoEditorConfig, ExportVideoInfo or ExportVideoConfiguration ``` entity.
The first one you need when you create ```BanubaVideoEditor```, two last ones - when you prepare a video to export.

```swift
  var config = VideoEditorConfig()
  config.recorderConfiguration.useHEVCCodecIfPossible = true

  let videoEditorSDK = BanubaVideoEditor(
    token: ...,
    configuration: config
  )

  let exportVideoInfo = ExportVideoInfo(
    resolution: ...,
    useHEVCCodecIfPossible: true
  )

  let configuration = ExportVideoConfiguration(
    fileURL: ...,
    quality: ...,
    useHEVCCodecIfPossible: true,
    watermarkConfiguration: ...
  )
```


## Configure microphone state
Class ```RecorderConfiguration``` includes ```muteMicrophoneForPIP``` property you can use to mute sound PIP mode. Default value is ```true```.

```swift
var config = VideoEditorConfig()
config.recorderConfiguration.muteMicrophoneForPIP = false
```

## Configure recording modes
Camera screen includes 3 modes for recording content implemented in ```captureButtonModes``` in ```RecorderConfiguration```
- ```Photo```
- ```Video```
- ```Photo``` and ```Video```;**Default**

In this example, recording mode is set to ```Video``` only.
```swift
var config = VideoEditorConfig()
config.recorderConfiguration.captureButtonModes = [.video]
```

## Configure timer
This feature allows to take a picture or record a video after some delay.
Use ```TimerConfiguration``` of ```RecorderConfiguration``` to customize timer functionality.
Implement ```TimerConfiguration.options``` property to provide custom list of timer options.  
In this example, the timer is configured with 2 options - 3 seconds and 5 seconds.
Please check out [implementation](../Example/Example/VideoEditorModule.swift#L1000) in the sample.
```swift
var config = VideoEditorConfig()
config.recorderConfiguration.timerConfiguration.options = [
  TimerOptionConfiguration(
    button: ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "camera.time_3")),
    startingTimerSeconds: 3,
    stoppingTimerSeconds: .zero,
    description: "3"
  ),
  TimerOptionConfiguration(
    button: ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "camera.time_5")),
    startingTimerSeconds: 5,
    stoppingTimerSeconds: .zero,
    description: "5"
  )
]
```

You can implement custom countdown animation for time feature as well. 
Set new [implementation](../Example/Example/Helpers/CountdownTimerViewControllerFactory.swift) to [ViewControllerFactory.countdownTimerViewFactory](../Example/Example/ViewController.swift#L111).

```swift
...
let viewControllerFactory = ViewControllerFactory()
viewControllerFactory.countdownTimerViewFactory = CountdownTimerViewControllerFactory()
    
videoEditorSDK = BanubaVideoEditor(
  token: AppDelegate.licenseToken,
  configuration: config,
  externalViewControllerFactory: viewControllerFactory
)
```

## Configure hands free
Hands Free is an advanced timer feature that allows to set up delay before starting of video recording and desired duration for video recording. See [customisation guide](handsFree_styles.md) for mode information.
The feature is enabled by default.  

Use  ```VideoEditorConfig.isHandfreeEnabled``` to control this feature.  
In this example, hands free is disabled.
```swift
var config = VideoEditorConfig()
config.isHandfreeEnabled = false
```

Hands free feature can be customized with a number of properties

- [selectorColor](../Example/Example/VideoEditorModule.swift#L831) - selector view color
- [selectorTextColor](../Example/Example/VideoEditorModule.swift#L832) - selector view text color
- [selectorTextFont](../Example/Example/VideoEditorModule.swift#L855) - selector view text font
- [selectorBorderWidth](../Example/Example/VideoEditorModule.swift#L856) - selector view border width
- [selectorBorderColor](../Example/Example/VideoEditorModule.swift#L857) - selector view border color
- [optionBackgroundColor](../Example/Example/VideoEditorModule.swift#L833) -The timer option selection view background color
- [optionCornerRadius](../Example/Example/VideoEditorModule.swift#L834) - The timer option selection view corner radius
- [optionTextColor](../Example/Example/VideoEditorModule.swift#L835) - The view text color
- [optionTextFont](../Example/Example/VideoEditorModule.swift#L858) - The view text font
- [backgroundColor](../Example/Example/VideoEditorModule.swift#L864) - The timer option view background color
- [cornerRadius](../Example/Example/VideoEditorModule.swift#L837) - The HandsFreeViewController corner radius
- [sliderCornerRadius](../Example/Example/VideoEditorModule.swift#L838) - The slider corner radius
- [barCornerRadius](../Example/Example/VideoEditorModule.swift#L839) - The bar corner radius
- [selectorEdgeInsets](../Example/Example/VideoEditorModule.swift#L840) - The selector views edge insets
- [activeThumbAndLineColor](../Example/Example/VideoEditorModule.swift#L841) - The color of the activated switch of active lines in slider
- [inactiveThumbAndLineColor](../Example/Example/VideoEditorModule.swift#L842) -The color of the inactivated switch of inactive lines in slider

![img](screenshots/HandsfreeConfiguration.png)

- [minVideoDuration](../Example/Example/VideoEditorModule.swift#L843) - The minimum value for video duration. Default 1.0
- [buttonCornerRadius](../Example/Example/VideoEditorModule.swift#L844) -The button corner radius
- [buttonBackgroundColor](../Example/Example/VideoEditorModule.swift#L845) -The button background color
- [switchOnTintColor](../Example/Example/VideoEditorModule.swift#L846) - The switch background color
- [modeTitleColor](../Example/Example/VideoEditorModule.swift#L848) - The mode title color
- [dragTitleColor](../Example/Example/VideoEditorModule.swift#L849) - The drag title color
- [buttonTitleColor](../Example/Example/VideoEditorModule.swift#L850) - The button title color
- [buttonTitleFont](../Example/Example/VideoEditorModule.swift#L860) - The button title font
- [dragTitleFont](../Example/Example/VideoEditorModule.swift#L859) - The drag title font
- [currentValueTextColor](../Example/Example/VideoEditorModule.swift#L851) - The current value text color
- [minimumValueTextColor](../Example/Example/VideoEditorModule.swift#L852) - The minimum value text color
- [maximumValueTextColor](../Example/Example/VideoEditorModule.swift#L852) - The maximum value text color
- [currentValueTextFont](../Example/Example/VideoEditorModule.swift#L861) - The current value text font
- [minimumValueTextFont](../Example/Example/VideoEditorModule.swift#L862) - The minimum value text font
- [maximumValueTextFont](../Example/Example/VideoEditorModule.swift#L863) - The maximum value text font
- [thumbLineViewBackgroundColor](../Example/Example/VideoEditorModule.swift#L864) - The thumb line view background color
- [cursorViewColor](../Example/Example/VideoEditorModule.swift#L865) - The cursor view color

![img](screenshots/timerOptionBarColorConfiguration.png)

Below are string resources are used for this feature and can be customized.
![img](screenshots/HandsFreeLocalization.png)

| Key        |      Value      |   Description |
| ------------- | :----------- | :------------- |
| hands.free.timer.title | Сountdown | Timer title text
| hands.free.video.mode.title | Hands-free video mode | Mode title text
| hands.free.video.drag.title | Drag to set video duration: | Drag title text
| hands.free.btn.title | START RECORDING | Start recording button title
| hands.free.seconds | %@ s | Seconds

## Configure record button appearance

- [videoResolution: VideoResolutionConfiguration](../Example/Example/Extension/RecorderConfiguration.swift#L9) - VideoResolutionConfiguration sets up the camera options for capturing and rendering video

The record button is a main control on the camera screen which you can fully customize along with animations playing on tap.
To customize record button use ```recordButton``` property of ```RecorderConfiguration```.
All available options of customization record button described [here](record_button_configuration.md).
If it still not suits your needs you can create your own view for more information look [here](record_button_provider.md).

You can customize default implementation of ```RecordButtonConfiguration``` in ```RecorderConfiguration```
```swift
var config = VideoEditorConfig()
config.recorderConfiguration.recordButtonConfiguration.idleStrokeColor = UIColor.white.cgColor
```

All available properties of ```RecordButtonConfiguration``` 
```swift
/// The Record button configuration
public struct RecordButtonConfiguration {
  /// Color setups record button round color for idle state
  public var idleStrokeColor: CGColor
  /// Color setups record button round color for capture state
  public var strokeColor: CGColor
  /// Colors setups record button gradient filling colors
  public var gradientColors: [CGColor]
  /// Round line width for idle state
  public var circularTimeLineIdleWidth: CGFloat
  /// Round line width for record state
  public var circularTimeLineCaptureWidth: CGFloat
  /// Image name setups core image for idle state
  public var normalImageName: String
  /// Image name setups core image for record state
  public var recordImageName: String
  /// Image name setups core image for photo state
  public var photoImageName: String
  /// Record button width
  public var width: CGFloat
  /// Record button height
  public var height: CGFloat
  /// Setup default color
  public var defaultColorButton: UIColor
  /// Setup color for video record state
  public var videoRecordColorButton: UIColor
  /// Setup color for take a photo state
  public var takePhotoColorButton: UIColor
  /// Setup full color for external circle
  public var externalCircleFullColor: CGColor
  /// Setup stroke color for external circle
  public var externalCircleStrokeColor: CGColor
}
```  
![img](screenshots/RecordButtonConfiguration.png)

Implement ```RecordButtonProvider```, ```RecordButton```, ```RecordButtonDelegate``` protocols to create your custom recording experience.

```swift
public protocol RecordButtonProvider {
  func getButton() -> RecordButton
}

public protocol RecordButton: UIView {
  var delegate: RecordButtonDelegate? { get set }
  var configuration: RecordButtonConfiguration? { get set }
  func changeViewToIdleState()
  func changeViewToRecordingState()
}

public protocol RecordButtonDelegate: AnyObject {
    var captureButtonMode: CaptureButtonViewMode { get }
  func recordButtonDidTakePhoto(_ recordButton: RecordButton)
  func recordButtonDidCancelTakePhoto(_ recordButton: RecordButton)
  func recordButtonDidStartVideoRecording(_ recordButton: RecordButton)
  func recordButtonDidStopVideoRecording(_ recordButton: RecordButton)
  func recordButtonDidZoomingVideoRecording(_ recordButton: RecordButton, recognizer: UILongPressGestureRecognizer)
}
``` 
Set new implementation of ```RecordButtonProvider``` to ```RecorderConfiguration.recordButtonProvider```.
```swift
var config = VideoEditorConfig()
config.recorderConfiguration.recordButtonProvider = ...
```

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
Picture in Picture or ```PIP``` is video editing technique that lets you overlay two videos in the same video.
The multi-layer editing effect is perfect for reaction videos, slideshows, product demos, and more. This feature is similar to TikTok duet feature.

<p align="center">
<img src="gif/pip_preview.gif"  width="33%" height="auto">
</p>

:exclamation: Important
The feature is disabled by default and can be enabled if the license supports it. Please ask Banuba business representatives to include the feature in your license.

The subsequent guide explains how to start and customize ```PIP```.

First, create ```VideoEditorLaunchConfig``` in [ViewController](../Example/Example/ViewController.swift#L301) 

```swift
let launchConfig = VideoEditorLaunchConfig(
        entryPoint: entryPoint,
        hostController: self,
        videoItems: resultUrls,
        pipVideoItem: resultUrls[.zero],
        animated: true
)
self.presentVideoEditor(with: launchConfig)
```

```PIP``` supports 4 modes that you can use.
- ```Floating```
- ```TopBottom```
- ```React```
- ```LeftRight```

Use ```PIPSettingsConfiguration``` to customize PIP implementation.
``` swift
/// The picture in picture mode configuration
public struct PIPSettingsConfiguration {
  /// BackgroundConfiguration setups background view style
  public var backgroundConfiguration: BackgroundConfiguration
  /// Cursor color
  public var dragIndicatorConfiguration: RoundedButtonConfiguration
  /// Title font for controls
  public var titleConfiguration: TextConfiguration
  /// Main settings buttons' configurations.
  /// Discussion: To launch some mode by default place it to the first position in the array
  public var layoutSettingsButtonsConfiguration: [PIPSelectableCellConfiguration]
}
``` 
In this example, 4 supported PIP modes are set.
``` swift
var config = VideoEditorConfig()
config.pipSettingsConfiguration?.layoutSettingsButtonsConfiguration = [
  PIPSelectableCellConfiguration(identifier: .floating),
  PIPSelectableCellConfiguration(identifier: .react),
  PIPSelectableCellConfiguration(identifier: .topBottom),
  PIPSelectableCellConfiguration(identifier: .leftRight)
]
``` 

```PIPSelectableCellConfiguration``` class can be used to change appearance of PIP cell.
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

## Configure camera screen appearance
Use these configs to customize action buttons, adjust some view relative positions etc.

- [saveButton](../Example/Example/VideoEditorModule.swift#L904) - save button configuration
- [backButton](../Example/Example/VideoEditorModule.swift#L915) - back button configuration
- [removeButtonImageName](../Example/Example/VideoEditorModule.swift#L916) - ImageName sets up the remove button UIImage
- [additionalEffectsButtons](../Example/Example/VideoEditorModule.swift#L924) - AdditionalEffectsButtonConfiguration array sets up all of the camera screen control buttons' styles
- [speedBarButtons](../Example/Example/VideoEditorModule.swift#L978) - SpeedButtonConfiguration sets up the speed button style
- [galleryButton](../Example/Example/VideoEditorModule.swift#L984) - RoundedButtonConfiguration sets up the gallery button style
- [emptyGalleryImageName](../Example/Example/VideoEditorModule.swift#L997) - Image name sets up the gallery button image for empty gallery state
- [regularRecordButtonPosition](../Example/Example/VideoEditorModule.swift#L1011) - This value sets up the capture button posttion according to the screen bottom
- [leftControlsBottomOffsetFromCaptureButton](../Example/Example/VideoEditorModule.swift#L1013) - This value sets up the left controls position according to the capture button bottom
- [leftControlsLeftOffset](../Example/Example/VideoEditorModule.swift#L1014) - This value sets up the left controls position according to the capture button leading edge
- [sequenceHeight](../Example/Example/VideoEditorModule.swift#L1015) - Sequence bar height
- [videoCaptureButtonConfiguration](../Example/Example/VideoEditorModule.swift#L1033) - Video capture button mode setup configuration
- [photoCaptureButtonConfiguration](../Example/Example/VideoEditorModule.swift#L1045) -Photo capture button mode setup configuration
- [backroundMusicContainerConfiguration](../Example/Example/VideoEditorModule.swift#L1051) - Special for top centered music button config
- [floatingViewSeparatedLines](../Example/Example/VideoEditorModule.swift#L1053) - Is floating view supports two lines
- [effectSelectorContainerCornerRadius](../Example/Example/VideoEditorModule.swift#L1054) - Effect selector container corner radius. Default is 8.0
- [preferredStatusBarStyle](../Example/Example/VideoEditorModule.swift#L1055) - The style of the status bar.

![img](screenshots/RecorderConfiguration.png)

You can change the position for the music button, for this you need:
In the array with additionalEffectsButtons, for the button with the identifier **.sound**, set up the [position](../Example/Example/Extension/RecorderConfiguration.swift#L72) property

- bottom - <img src="screenshots/bottom.PNG" width="200" />
- center - <img src="screenshots/center.PNG" width="200" />
- top -  <img src="screenshots/top.PNG" width="200" />
  To be able to change the location of the button, you need to set the desired value in the array with additionalEffectsButtons, for the button with the identifier ```.sound```, set up the ```position``` property.

```swift
let config = VideoEditorConfig()

config.recorderConfiguration.additionalEffectsButtons = [
  AdditionalEffectsButtonConfiguration(
    identifier: .sound,
    imageConfiguration: ImageConfiguration(imageName: ""),
    selectedImageConfiguration: ImageConfiguration(imageName: ""),
    titlePosition: .bottom,
    position: .top
  ),
] 
```


These string resources are used as default however you can customize them.

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

![img](screenshots/CameraScreenLocalizations.png)