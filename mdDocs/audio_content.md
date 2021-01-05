# API for using client's audio content in the SDK
[comment]: <> (This file was created by exporting notion page from here: https://www.notion.so/vebanuba/API-for-using-client-s-audio-content-in-the-SDK-9a0e03dd3ad04962a2cbadebe5c73c19)
## Overview

The user can apply audio tracks on camera and audio editor screens.

The SDK can apply an audio track to a video, trim an audio track before applying, create new audio track as a composition of several applied audio tracks on video.

**NOTE: the VE SDK is not responsible for providing audio content. The client has to implement an integration with audio content provider.**

### Step 1

Add a dependency into your pod file containing other VE SDK dependencies and setup its version (the latest is 0.0.13):

```swift
pod 'BanubaAudioBrowserSDK', '0.0.13'

```

### Step 2

Add the Audio Browser Adaptor entity to the host. 

```swift
import BanubaAudioBrowserSDK
import BanubaMusicEditorSDK

// Adapt audio browser to TrackSelectionViewController
extension EditorNavigationController: TrackSelectionViewController {
  private static var trackSelectionDelegateProxy = TrackSelectionDelegateProxy()
  public var trackSelectionDelegate: TrackSelectionViewControllerDelegate? {
    get {
      return EditorNavigationController.trackSelectionDelegateProxy.trackSelectionDelegate
    }
    set {
      EditorNavigationController.trackSelectionDelegateProxy.trackSelectionDelegate = newValue
      EditorNavigationController.trackSelectionDelegateProxy.editorController = self
      navigationDelegate = EditorNavigationController.trackSelectionDelegateProxy
    }
  }
  
  class TrackSelectionDelegateProxy: UIViewController, TrackSelectionViewController, AudioBrowserSelectionViewControllerDelegate {
    
    public var trackSelectionDelegate: TrackSelectionViewControllerDelegate?
    weak var editorController: EditorNavigationController?
    
    func audioBrowserSelectionViewController(
      viewController: AudioBrowserSelectionViewController,
      didSelectFile url: URL,
      title: String,
      id: Int32
    ) {
      guard let editorController = editorController else {
        return
      }
      trackSelectionDelegate?.trackSelectionViewController(
        viewController: editorController,
        didSelectFile: url,
        title: title,
        id: Int64(id)
      )
    }
    
    func audioBrowserSelectionViewControllerDidCancel(viewController: AudioBrowserSelectionViewController) {
      guard let editorController = editorController else {
        return
      }
      trackSelectionDelegate?.trackSelectionViewControllerDidCancel(viewController: editorController)
    }
    
    func audioBrowserSelectionViewController(
      viewController: AudioBrowserSelectionViewController,
      didStopUsingTrackWithId trackId: Int32
    ) {
      guard let editorController = editorController else {
        return
      }
      trackSelectionDelegate?.trackSelectionViewController(
        viewController: editorController,
        didStopUsingTrackWithId: trackId
      )
    }
  }
}
```

Create entity of your own MusicEditorViewControllerFactory.

```swift
/// Example video editor view controller factory
class ViewControllerFactory: ExternalViewControllerFactory {
  var musicEditorFactory: MusicEditorExternalViewControllerFactory?
  var countdownTimerViewFactory: CountdownTimerViewFactory?
  var exposureViewFactory: AnimatableViewFactory?
}

/// Music editor view controller factory example
class MusicEditorViewControllerFactory: MusicEditorExternalViewControllerFactory {

  // Track audio browser feature enabled
  weak var videoEditorSDK: BanubaVideoEditor?
  
  private var isAudioBrowserEnabled: Bool {
    return videoEditorSDK?.currentConfiguration.featureConfiguration.isAudioBrowserEnabled ?? false
  }
  
  func makeTrackSelectionViewController(selectedAudioItem: AudioItem?) -> TrackSelectionViewController? {
    return nil
  }
  
  private func makeAudioBrowserViewController(selectedAudioItem: AudioItem?) -> EditorNavigationController {
    var selectedAudioBrowserTrack: AudioBrowserTrack?
    
    if let selectedAudioItem = selectedAudioItem {
      selectedAudioBrowserTrack = AudioBrowserTrack(
        id: Int32(truncating: NSNumber(value: selectedAudioItem.id)),
        name: selectedAudioItem.title ?? "",
        url: selectedAudioItem.url
      )
    }
    
    let browser = BanubaAudioBrowser(
      audioService: AudioBrowserService(),
      audioBrowserConfig: AudioBrowserConfig(),
      slideInTransitioningDelegate: SlideInPresentationManager(
        coverPercentage: 0.8, panToDismiss: true
      ),
      selectedTrack: selectedAudioBrowserTrack
    )
    
    let browserController = browser.getAudioBrowserController()
    return browserController
  }
  
  func makeEffectSelectionViewController(selectedAudioItem: AudioItem?) -> EffectSelectionViewController? {
    return nil
  }
...
}
```

Pass factory instance that mentioned above to BanubaVideoEditor initializer.

```swift
func createVideoEditorSDK() {
    let viewControllerFactory = ViewControllerFactory()
    let musicEditorFactory = MusicEditorViewControllerFactory()
    viewControllerFactory.musicEditorFactory = musicEditorFactory
        
    videoEditorSDK = BanubaVideoEditor(
      token: clientToken,
      effectsToken: effectsToken,
      configuration: config,
      analytics: Analytics(),
      externalViewControllerFactory: viewControllerFactory
    )
    videoEditorSDK?.delegate = self
    
    musicEditorViewControllerFactory.videoEditorSDK = videoEditorSDK
}
```
Then update configuration to be able to open Audio Browser.

**NOTE: BanubaVideoEditor entity should be already initialized before your configuration updating.**

```swift
guard var currentConfig = videoEditorSDK?.currentConfiguration else {
   return 
}
var featureConfiguration = currentConfig.featureConfiguration
featureConfiguration.isAudioBrowserEnabled = true
currentConfig.updateFeatureConfiguration(featureConfiguration: featureConfiguration)
videoEditorSDK?.updateVideoEditorConfig(currentConfig)

```