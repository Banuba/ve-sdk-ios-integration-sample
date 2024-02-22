# Audio integration guide

> [!CAUTION]
> This documentation is deprecated and no longer updated.
> Please check out our [new website](https://docs.banuba.com/ve-pe-sdk/docs/ios/guide_audio_content) with latest documentation.

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

Set Mubert license and token keys by using ```BanubaAudioBrowser.setMubertKeys``` method. For example in [VideoEditorModule](../Example/Example/VideoEditorModule.swift#L96).
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

## External API
Video Editor includes special API for integrating your custom audio content provider and applying this content in video editor.   
The user will be taken to your app specific screen when audio is requested on video editor screen i.e. camera or editor.
Next, once the user picks audio content on your app screen you need to follow API and return the user to video editor.  
Any audio file should be stored on the device before applying.

To pass audio content to Video Editor you need to implement a factory that conforms ```MusicEditorExternalViewControllerFactory``` protocol.
And put it to ```musicEditorFactory``` property in ExternalViewControllerFactory.
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
To present your custom audio browser in video editor you need to set created ```ExternalViewControllerFactory``` to [externalViewControllerFactory](../Example/Example/VideoEditorModule.swift#L29)
