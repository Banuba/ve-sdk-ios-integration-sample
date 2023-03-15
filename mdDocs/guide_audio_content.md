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

IN PROGRESS...