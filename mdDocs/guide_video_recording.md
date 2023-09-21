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
If h265(HEVC) codec is used for recording video the values listed below will be reduced by approximately 34%.

| Recording speed            | 360p(360 x 640) | 480p(480 x 854) | 540p(540 x 960) |  HD(720 x 1280) | FHD(1080 x 1920) | QHD(2560 x 1440) | 4K(3860 x 2160) |
| -------------------------- | --------------- | --------------- | --------------- | --------------- | ---------------- | ---------------- | --------------- |
| 0.5x, 1x (Default), 2x, 3x | 1.2 Mbits       | 2 Mbits         | 2.4 Mbits       | 3.6 Mbits       | 5.8 Mbits        | 16 Mbits         | 36 Mbits        |

## Implement configurations
```VideoEditorConfig``` is the core class used for customizing all features in Video Editor SDK.
The class includes many internal config classes that are very useful if you want to create your custom experience.  

```RecorderConfiguration``` is the main configuration class in ```VideoEditorConfig``` and is used for video recording functionality.

| Property |               Values                | Description |
| ------------- |:-----------------------------------:| :------------- |
| videoResolution |    VideoResolutionConfiguration     | defines resolution configuration for video recording
| loopAudioWhileRecording |      Bool; Default  ```true```      | defines if audio used in video recording should be looped
| isDynamicMusicTitle |      Bool; Default ```false```      | defines if the music title on the screen changes when new track is applied
| isDefaultFrontCamera |      Bool; Default ```false```      | set ```true``` if you want to open camera in front mode
| useHEVCCodecIfPossible |      Bool; Default ```true```       | enables H265 codec for recording if it is available on the device
| isPhotoSequenceAnimationEnabled |      Bool; Default ```false```      | Should use animation for photo sequences
| isAudioRateEqualsVideoSpeed |      Bool; Default ```false```      | Applies selected by the user video speed to audio
| isGalleryButtonHidden |      Bool; Default ```false```      | defines if gallery button located at bottom-right should be hidden. ```true``` will hide the button. 
| supportMultiRecords |      Bool; Default ```true```       | defines if the user can record multiple video files

Next very handy config class is ```VideoEditorDurationConfig``` that is responsible for customizing video recording durations.

:exclamation: Important. All values are in seconds.

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

And ```FeatureConfiguration``` that helps to customize use of some specific features on camera screen where 
video recording happen.

| Property |          Values           | Description |
| ------------- |:-------------------------:| :------------- |
| isDoubleTapForToggleCameraEnabled | Bool; Default ```false``` | enable switchicng between front and back camera facing by double tap on camera screen
| isMuteCameraAudioEnabled | Bool; Default ```false``` | indicates if mute microphone button is visible on camera screen   
| isSpeedBarEnabled | Bool; Default ```true```  | enables speed selection bar. If bar is disabled speed recording will iterativly switched by tapping
| openAutomaticallyPIPSettingsDropdown | Bool; Default ```false``` | if this property enabled the pip settings drop down view will be presented after opening camera screen


## Configure microphone state
Class ```RecorderConfiguration``` includes ```muteMicrophoneForPIP``` property you can use to mute sound in PIP mode. Default value is ```true```.

```swift
var config = VideoEditorConfig()
config.recorderConfiguration.muteMicrophoneForPIP = false
```

## Configure recording modes
Recording includes 3 modes for recording content implemented in ```captureButtonModes``` in ```RecorderConfiguration``` class.
- ```Photo```
- ```Video```
- ```Photo``` and ```Video```; **Default**

In this example, recording mode is set to ```Video``` only.
```swift
var config = VideoEditorConfig()
config.recorderConfiguration.captureButtonModes = [.video]
```

## Configure timer
This feature allows to take a picture or record a video after some delay.  

```TimerConfiguration``` is the main class used in  ```RecorderConfiguration``` to customize timer functionality.
Implement ```TimerConfiguration.options``` property to provide custom list of timer options.  

In this example, the timer uses 2 options - 3 seconds and 5 seconds delay before to start recording.
Please check out [implementation](../Example/Example/VideoEditorModule.swift#L1045) in the sample.
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

Moreover, you can implement custom countdown animation for time feature as well. 

```diff
...
let viewControllerFactory = ViewControllerFactory()
+ viewControllerFactory.countdownTimerViewFactory = CountdownTimerViewControllerFactory()
    
videoEditorSDK = BanubaVideoEditor(
  token: AppDelegate.licenseToken,
  configuration: config,
+  externalViewControllerFactory: viewControllerFactory
)
```

## Configure hands free
Hands Free is an advanced timer feature that allows to set up delay before starting of video recording and desired duration for video recording.
The feature is enabled by default.  

Use  ```VideoEditorConfig.isHandfreeEnabled``` property to enable or disable.  
In this example, hands free is disabled.
```swift
var config = VideoEditorConfig()
config.isHandfreeEnabled = false
```

## Configure record button appearance

The record button is a main UI control on the camera screen which you can fully customize along with animation that is playing on tap.

Implement ```RecordButtonProvider```, ```RecordButton```, ```RecordButtonDelegate``` protocols to create your custom recording button experience.

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

Picture in Picture or ```PIP``` is video editing technique that lets you overlay two videos in the same video.
The multi-layer editing effect is perfect for reaction videos, slideshows, product demos, and more. This feature is similar to TikTok duet feature.

<p align="center">
<img src="gif/pip_preview.gif"  width="33%" height="auto">
</p>

:exclamation: Important
The feature is disabled by default and can be enabled if the license supports it. Please ask Banuba business representatives to include the feature in your license.

The subsequent guide explains how to start and customize ```PIP```.

First, create ```VideoEditorLaunchConfig``` in [ViewController](../Example/Example/ViewController.swift#L79) 
and provide video content for the feature.

```diff
let launchConfig = VideoEditorLaunchConfig(
        entryPoint: entryPoint,
        hostController: self,
        videoItems: resultUrls,
+        pipVideoItem: resultUrls[.zero],
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

| Property |          Values           | Description |
| ------------- |:-------------------------:| :------------- |
| backgroundConfiguration | BackgroundConfiguration | BackgroundConfiguration setups background view style
| dragIndicatorConfiguration | RoundedButtonConfiguration | Cursor color
| titleConfiguration | TextConfiguration | Title font for controls
| layoutSettingsButtonsConfiguration | [PIPSelectableCellConfiguration] | Array of pip cell configurations


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

You can also change the position of the music button.
Use ```additionalEffectsButtons``` and provide custom ```AdditionalEffectsButtonConfiguration``` with identifier  ```.sound```.
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
  ...
] 
```

Video Editor supports 3 options for positioning music button: ```bottom```, ```center```, ```top```.
