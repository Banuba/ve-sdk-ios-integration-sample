# Audio integration guide

- [Overview](#Overview)
- [Audio Browser](#Audio-Browser)
- [Mubert integration](#Mubert-integration)
- [External API](#External-API)
- [Export from Apple Music](#Export-from-Apple-Music)
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
Audio Browser is a specific iOS module that allows to browse, play and apply audio content within video editor.  
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

Finally, you can customize Audio Browser appearance with ```AudioBrowserConfig.shared``` configuration

## Mubert integration
Audio Browser has built in integration with [Mubert](https://mubert.com/) API.  
Please contact Mubert representatives to request API LICENSE with API TOKEN.

Set Mubert API key by using ```BanubaAudioBrowser.setMubertKeys``` method. For example in [VideoEditorModule](../Example/Example/VideoEditorModule.swift#L84).
```Swift
BanubaAudioBrowser.setMubertKeys(
  license: "SET MUBERT API LICENSE",
  token: "SET MUBERT API TOKEN"
)
```

You can use ```AudioBrowserConfig.shared.mubertAudioConfig``` to customize network requests to Mubert as well.

| Property |                                 Values                                  | Description |
| ----------- |:-----------------------------------------------------------------------:| :------------- |
| trackDuration |                       String,   Default ```30```                        | Mubert will generate track with exactly this duration in seconds
| trackBitrate | allowed: ```32```, ```96```, ```128```, ```192```, ```256```, ```320``` | audio quality in kbps
| trackIntencity |  allowed: ```low```, ```medium```, ```high```; Recommended ```high```   | instrumental saturation (number of stems) for generated tracks
| trackFormat |      allowed: ```mp3```, ```wav```, ```flac```; Default ```mp3```       | audio format of generated tracks
| categoryTracksAmount |                               Number > 0                                | amount of tracks to generate for selected category

These string resources are used however you can override them.

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


## External API
Video Editor includes special API for integrating your custom audio content provider and applying this content in video editor.   
The user will be taken to your app specific screen when audio is requested on video editor screen i.e. camera or editor.
Next, once the user picks audio content on your app screen you need to follow API and return the user to video editor.  
Any audio file should be stored on the device before applying.

To pass audio content to Video Editor you need to implement a factory that conforms ```MusicEditorExternalViewControllerFactory``` protocol.
And put it to ```musicEditorFactory``` property in [ExternalViewControllerFactory](../Example/Example/VideoEditorModule.swift#L1112).
Your factory should implement the following methods:

```swift
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
Where ```AudioItem``` is entity includes information about selected audio item in Video Editor:
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

Your custom audio browser implementation should conform to ```TrackSelectionViewController``` protocol
```swift
class YourCustomAudioBrowser: UIViewController, TrackSelectionViewController {
  weak var trackSelectionDelegate: TrackSelectionViewControllerDelegate?
}
```
Using ```trackSelectionDelegate``` you can notify Video Editor about actions in audio browser with the following methods:
```swift
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

## Export from Apple Music

You can pass music from Apple Music to Video Editor SDK.  
You should export media to temporary directory and then
pass music url to Video Editor SDK using ```trackSelectionDelegate```.  

In this sample, we show how to implement it
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
To present your custom audio browser in video editor you need to set created ```ExternalViewControllerFactory``` to [externalViewControllerFactory](../Example/Example/VideoEditorModule.swift#L33)

## Music Editor screen
Video Editor includes Music Editor screens. These are screens where the user can adjust usage of audio in video editor i.e. trim, add new, delete.
Music Editor includes voice recording feature as well. 

Below is a list of styles and attributes you can customize to meet your requirements.

- [mainMusicViewControllerConfig](../Example/Example/VideoEditorModule.swift#L471) - configuration for ```MainMusicViewControllerConfig```
- [videoTrackLineEditControllerConfig](/Example/Example/VideoEditorModule.swift#L474) - configuration for ```VideoTrackLineEditViewControllerConfig```
- [audioTrackLineEditControllerConfig](../Example/Example/VideoEditorModule.swift#L473) - configuration for ```VideoTrackLineEditViewControllerConfig```
- [audioRecorderViewControllerConfig](../Example/Example/VideoEditorModule.swift#L472) - configuration for ```AudioRecorderViewControllerConfig```
- [editButtons](../Example/Example/VideoEditorModule.swift#L482) - array of editing buttons
- [editButtonsHeight](../Example/Example/VideoEditorModule.swift#L513) - height of editing buttons container
- [editCompositionButtons](../Example/Example/VideoEditorModule.swift#L515) - array of editing composition buttons
- [controlButtons](../Example/Example/VideoEditorModule.swift#L164) - array of control buttons
- [playerControlsHeight](../Example/Example/VideoEditorModule.swift#L202) - height of control buttons container
- [audioWaveConfiguration](../Example/Example/VideoEditorModule.swift#L207) - configuration for ```AudioWaveConfiguration```
- [mainLabelColors](../Example/Example/VideoEditorModule.swift#L562) - color for main titles
- [additionalLabelColors](../Example/Example/VideoEditorModule.swift#L563) - color for additional titles
- [tracksLimit](../Example/Example/VideoEditorModule.swift#L566) - number of maximum tracks
- [cursorColor](../Example/Example/VideoEditorModule.swift#L567) - cursor color
- [timelineCornerRadius](../Example/Example/VideoEditorModule.swift#L570) - corner radius of timeline

![img](screenshots/MusicEditorMainScreen.png)

- [rewindToStartButton?](../Example/Example/VideoEditorModule.swift#L576) - rewind button configuration as ```ControlButtonConfig```
- [playPauseButton](../Example/Example/VideoEditorModule.swift#L582) - play button configuration as ```ControlButtonConfig```
- [playerControlsHeight](../Example/Example/VideoEditorModule.swift#L588) - height of player controls
- [recordButton](../Example/Example/VideoEditorModule.swift#L590) - record button configuration as ```ControlButtonConfig```
- [backButtonImage](../Example/Example/VideoEditorModule.swift#L596) - image name for back button
- [doneButtonImage](../Example/Example/VideoEditorModule.swift#L597) - image name for done button
- [dimViewColor](../Example/Example/VideoEditorModule.swift#L598) - dim view color
- [additionalLabelColors](../Example/Example/VideoEditorModule.swift#L599) - additional labels color
- [startingRecordingTimerSeconds](../Example/Example/VideoEditorModule.swift#L600) - countdown to start recording
- [timerColor](../Example/Example/VideoEditorModule.swift#L601) - timer color
- [cursorColor](../Example/Example/VideoEditorModule.swift#L602) - cursor color
- [timelineCornerRadius](../Example/Example/VideoEditorModule.swift#L605) - corner radius for timeline


![img](screenshots/AudioRecorderScreen.png)

- [doneButtonImageName](../Example/Example/VideoEditorModule.swift#L613) - image name for done button
- [doneButtonTintColor](../Example/Example/VideoEditorModule.swift#L614) - tint color for done button
- [sliderTintColor](../Example/Example/VideoEditorModule.swift#L615) - tint color for slider
- [mainLabelColors](../Example/Example/VideoEditorModule.swift#L616) - main labels color
- [additionalLabelColors](../Example/Example/VideoEditorModule.swift#L617) - additional labels colors
- [backgroundConfiguration](../Example/Example/VideoEditorModule.swift#L618) - configuration for background view ```BackgroundConfiguration```

![img](screenshots/VideoEditScreen.png)

- [audioWaveConfiguration](../Example/Example/VideoEditorModule.swift#L626) - configuration for ```AudioWaveConfiguration``` to customize wave style
- [doneButtonImageName](../Example/Example/VideoEditorModule.swift#L628) - image name for done button
- [doneButtonTintColor](../Example/Example/VideoEditorModule.swift#L629) - tint color for done button
- [sliderTintColor](../Example/Example/VideoEditorModule.swift#L630) - tint color for slider
- [draggersColor](../Example/Example/VideoEditorModule.swift#L631) - background color for dragger
- [draggerImageName](../Example/Example/VideoEditorModule.swift#L632) - image name of dragger
- [trimHeight](../Example/Example/VideoEditorModule.swift#L633) - height of trim container
- [trimBorderColor](../Example/Example/VideoEditorModule.swift#L634) - border line color of trim container
- [trimBorderWidth](../Example/Example/VideoEditorModule.swift#L635) - border line width of trim container
- [cursorHeight](../Example/Example/VideoEditorModule.swift#L636) - cursor height
- [dimViewColor](../Example/Example/VideoEditorModule.swift#L637) - dim view background color
- [mainLabelColors](../Example/Example/VideoEditorModule.swift#L638) - color of main label title
- [additionalLabelColors](../Example/Example/VideoEditorModule.swift#L640) - color of additional label
- [cursorColor](../Example/Example/VideoEditorModule.swift#L640) - cursor background color
- [draggersWidth](../Example/Example/VideoEditorModule.swift#L643) - draggers view width
- [draggersLineColor](../Example/Example/VideoEditorModule.swift#L167) - draggers central line view color
- [draggersCornerRadius](../Example/Example/VideoEditorModule.swift#L644) - draggers view corner radius
- [draggersLineWidth](../Example/Example/VideoEditorModule.swift#L646) - draggers central line view width
- [draggersLineHeight](../Example/Example/VideoEditorModule.swift#L647) - draggers central line view height
- [numberOfLinesInDraggers](../Example/Example/VideoEditorModule.swift#L648) - number of draggers central lines
- [draggerLinesSpacing](../Example/Example/VideoEditorModule.swift#L649) - draggers central lines spacing
- [draggersLineCornerRadius](../Example/Example/VideoEditorModule.swift#L649) - draggers central lines corner radius
- [backgroundConfiguration](../Example/Example/VideoEditorModule.swift#L651) - ```BackgroundConfiguration``` setups common container view background style
- [voiceFilterConfiguration](../Example/Example/VideoEditorModule.swift#L652) - ```VoiceFilterConfiguration``` setups voice filter container view item style
- [voiceFilterProvider](../Example/Example/VideoEditorModule.swift#L475) - ```VoiceFilterProvider``` setups voice filters provider
- [isVoiceFilterHidden](../Example/Example/VideoEditorModule.swift#L476) - voice Filter will be hidden if voiceFilterProvider is nil
- [isRandomWaveColor](../Example/Example/VideoEditorModule.swift#L628) - if random wave color enabled
- [backgroundColor](../Example/Example/VideoEditorModule.swift#L628) - background color view
- [waveBorderColor](../Example/Example/VideoEditorModule.swift#L628) - time line border color
- [waveCornerRadius](../Example/Example/VideoEditorModule.swift#L628) - time lime corner radius
- [waveLinesColor](../Example/Example/VideoEditorModule.swift#L628) - audio wave lines color
- [borderWidth](../Example/Example/VideoEditorModule.swift#L628) - time line border width
- [height](../Example/Example/VideoEditorModule.swift#L628) - time line height
- [maxWaveHeight](../Example/Example/VideoEditorModule.swift#L628) -max audio wave height
- [audioTitleFont](../Example/Example/VideoEditorModule.swift#L628) - audio title font
- [audioTitleColor](../Example/Example/VideoEditorModule.swift#L628) - audio title color
- [bottomOffset](../Example/Example/VideoEditorModule.swift#L628) - time line bottom offset

![img](screenshots/AudioEditScreen.png)

The following string resources are used by default, however you can customize them.

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
