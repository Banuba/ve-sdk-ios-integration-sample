# API for using client's audio content in the SDK
## Overview

## Integration
### External Audio browser

### Step 4

Your class should implement ```MusicEditorExternalViewControllerFactory``` protocol.
```swift
public protocol MusicEditorExternalViewControllerFactory: AnyObject {
  var audioBrowserController: TrackSelectionViewController? { get set }
  func makeTrackSelectionViewController(selectedAudioItem: AudioItem?) -> TrackSelectionViewController?
  func makeEffectSelectionViewController(selectedAudioItem: AudioItem?) -> EffectSelectionViewController?
  func makeRecorderCountdownAnimatableView() -> MusicEditorCountdownAnimatableView?
}
```
Here's the example of the methods implementation for using Banuba Audio Browser:
```swift
  var audioBrowserController: TrackSelectionViewController?
  
  func makeTrackSelectionViewController(selectedAudioItem: AudioItem?) -> TrackSelectionViewController? {
    return nil
  }
  
  func makeEffectSelectionViewController(selectedAudioItem: AudioItem?) -> EffectSelectionViewController? {
    return nil
  }
  
  func makeRecorderCountdownAnimatableView() -> MusicEditorCountdownAnimatableView? {
    return nil
  }
```

### Step 5

The class in which you have implemented the ``` MusicEditorExternalViewControllerFactory ``` protocol must be passed to ```musicEditorFactory```.

See an example [here](../Example/Example/VideoEditorModule.swift#L1112).

### Step 6

Banuba Audiobrowser can be configured to work with online music providers, local audio files or with all sources. To control this behaviour customize ```musicSource``` property:
```swift

AudioBrowserConfig.shared.musicSource = .mubert

// Available options
@objc public enum AudioBrowserMusicSource: Int, CaseIterable {
  /// enables only Mubert music in AudioBrowser
  case mubert = 1
  /// disables Mubert music. Only local music with my files will be available
  case localStorageWithMyFiles = 2
  /// all sources are enabled
  case allSources = 3
}
```
