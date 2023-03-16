# Audio integration guide

- [Overview](#Overview)
- [Audio Browser](#Audio-Browser)
- [Mubert integration](#Mubert-integration)
- [External API](#External-API)
- [Music Editor screen](#Music-Editor-screen)

## Overview
Audio is a key part of making awesome video content.

Video Editor SDK can play, trim, merge and apply audio content to a video.

:exclamation: Important
1. Banuba does not provide any audio content for Video Editor SDK.
2. Video Editor can apply audio file stored on the device. The SDK is not responsible for downloading audio content except [Mubert](https://mubert.com/)

There are 2 approaches of providing audio content:
1. ```AudioBrowser``` - specific module and a set of screens that includes built in support of browsing and applying audio content within video editor. The user does not leave the sdk while using audio.
2. ```External API``` - the client implements specific API for managing audio content. The user is taken on client's screen when audio is requested.

## Audio Browser
Audio Browser is a specific Android module that allows to browse, play and apply audio content within video editor.  
It supports 2 sources for audio content:
1. ```My Library``` - includes audio content available on the user's device
2. ```Mubert``` - includes built in integration with [Mubert](https://mubert.com/) API.

<p align="center">
<img src="gif/audio_browser.gif" alt="Screenshot" width="30%" height="auto" class="docs-screenshot"/>&nbsp;
</p>

Add  ```BanubaAudioBrowserSDK``` dependency into your [Podfile](../Example/Podfile#L13)
```swift
pod 'BanubaAudioBrowserSDK', banuba_sdk_version
```

![img](screenshots/AudioBrowserLocalizations.png)

| Key        |      Value      |   Description |
| ------------- | :----------- | :------------- |
| AudioBrowser.noInternetConnection | No internet connection | No internet connection title in alert
| AudioBrowser.checkConnectionMessage | Please, check your connection and try again | Message for user if No internet connection
| AudioBrowser.retry | Retry | Retry button title
| AudioBrowser.allowAccessMessage | To use your own music, allow access to Apple Music library, please. | Allow access message
| AudioBrowser.allowAccess | Allow Access | Allow button title
| AudioBrowser.myFiles | My Files | My files button title
| audioBrowser.search.by.categories | Search by categories | Search by category placeholder text
| audioBrowser.search.by.groups | Search by groups | Search by groups placeholder text
| audioBrowser.search.by.tracks | Search by tracks | Search by tracks placeholder text
| audioBrowser.use | Use | Use button title
| audioBrowser.show.more | Show more | Show more button title
| audioBrowser.stop.using | Stop using | Stop using button title
| audioBrowser.my.library | My library | My library button title
| audioBrowser.no.matches | No matches | No matches placeholder text
| audioBrowser.no.tracks | No tracks | No tracks placeholder text

## Mubert integration
Audio Browser has built in integration with [Mubert](https://mubert.com/) API.  
Please contact Mubert representatives to request API KEY.

Set Mubert API key by using ```BanubaAudioBrowser.setMubertPat``` method. For example in [VideoEditorModule](../Example/Example/VideoEditorModule.swift#L53).
```Swift
BanubaAudioBrowser.setMubertPat("SET MUBERT API KEY")
```

IN PROGRESS... Describe how to change configs for Mubert and customize UI

## External API
Video Editor includes special API for integrating your custom audio content provider and applying this content in video editor.   
The user will be taken to your app specific screen when audio is requested on video editor screen i.e. camera or editor.
Next, once the user picks audio content on your app screen you need to follow API and return the user to video editor.  
Any audio file should stored on the device before applying.

IN PROGRESS...
To pass audio content to Video Editor SDK you have to implement a factory that conforms ```MusicEditorExternalViewControllerFactory``` protocol. And put it to ```musicEditorFactory``` property in [ExternalViewControllerFactory](../Example/Example/ViewController.swift#L24). Your factory should contain the following methods:

```swift
// MARK: - External Audio Browser Factory
protocol MusicEditorExternalViewControllerFactory: AnyObject {
  /// contoller which will be used for presenting otherwise makeTrackSelectionViewController will be used
  var audioBrowserController: TrackSelectionViewController? { get set }

  /// should returns controller which provides audio content for Video Editor SDK
  /// - selectedAudioItem is currently selected audio item
  func makeTrackSelectionViewController(selectedAudioItem: AudioItem?) -> TrackSelectionViewController?
  /// should returns controller which provides effects audio content for Video Editor SDK
  /// Note: MainMusicViewControllerConfig should contains editButton with type .effect
  func makeEffectSelectionViewController(selectedAudioItem: AudioItem?) -> EffectSelectionViewController?
  /// should returns view for countdown animation in record button at music editor
  func makeRecorderCountdownAnimatableView() -> MusicEditorCountdownAnimatableView?
}
```
Where ```AudioItem``` is entity contains information about selected audio item in Video Editor SDK:
```swift
// MARK: - AudioItem protocol
protocol AudioItem {
  var id: Int64 { get }
  var url: URL { get }
  var title: String? { get set }
  /// True - display track with which the video was recorded and allow users to edit it.
  /// False - track will be playing but not displayed.
  var isEditable: Bool { get set }
}
```

Your custom audio browser should conforms the following protocol:
```swift
protocol TrackSelectionViewController: UIViewController {
  var trackSelectionDelegate: TrackSelectionViewControllerDelegate? { get set }
}
```
Using ```trackSelectionDelegate``` you can notify Video Editor SDK about actions at audio browser with following methods:
```swift
// MARK: - TrackSelectionViewController
protocol TrackSelectionViewControllerDelegate: AnyObject {
  func trackSelectionViewController(
    viewController: TrackSelectionViewController,
    didSelectFile url: URL,
    isEditable: Bool,
    title: String,
    /// The id parameter should be a Int32 number from 6 to it's maximum value
    id: Int32
  )
  
  func trackSelectionViewControllerDidCancel(
    viewController: TrackSelectionViewController
  )
  
  func trackSelectionViewController(
    viewController: TrackSelectionViewController,
    didStopUsingTrackWithId trackId: Int32
  )
}
```

**NOTE: The Video Editor SDK is not responsible for providing audio content. The client has to implement an integration with an audio content provider.
The Video Editor SDK can't download music from external storage and import music tracks from Apple Music.**

If you want to pass music from Apple Music to Video Editor SDK you have to export media to temporary directory then pass music url to Video Editor SDK using ```trackSelectionDelegate```. There is example how to export music from Apple Music:
```swift
let asset = AVURLAsset(url: url)
let destination = FileManager.default
  .temporaryDirectory
  .appendingPathComponent("\(NSUUID().uuidString).caf")
let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetPassthrough)
exportSession?.outputURL = destination
exportSession?.outputFileType = AVFileType.caf
exportSession?.exportAsynchronously() {
  if let error = exportSession?.error {
    completion(nil, error as NSError)
  } else {
    completion(destination, nil)
  }
}
```


## Music Editor screen
Video Editor includes Music Editor screens. These are screens where the user can adjust usage of audio in video editor i.e. trim, add new, delete.
Music Editor includes voice recording feature as well. 

Below is a list of styles and attributes you can customize to meet your requirements.

### MusicEditorConfig

- [mainMusicViewControllerConfig: MainMusicViewControllerConfig](/Example/Example/Extension/MusicEditorConfig.swift#L8)

MainMusicViewControllerConfig setups main screen style

- [videoTrackLineEditControllerConfig: VideoTrackLineEditViewControllerConfig](/Example/Example/Extension/MusicEditorConfig.swift#L9)

VideoTrackLineEditViewControllerConfig setups video track line editing screen style

- [audioTrackLineEditControllerConfig: AudioTrackLineEditViewControllerConfig](/Example/Example/Extension/MusicEditorConfig.swift#L10)

VideoTrackLineEditViewControllerConfig setups audio track line editing screen style

- [audioRecorderViewControllerConfig: AudioRecorderViewControllerConfig](/Example/Example/Extension/MusicEditorConfig.swift#L11)

AudioRecorderViewControllerConfig setups audio recorder style

### MainMusicViewControllerConfig

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

### AudioRecorderViewControllerConfig

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

### VideoTrackLineEditViewControllerConfig

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

### AudioTrackLineEditViewControllerConfig

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

### AudioWaveConfiguration
 
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

And you can customize string resources as well.

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
