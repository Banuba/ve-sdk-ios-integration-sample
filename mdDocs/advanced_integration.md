# Advanced integration

This guide is aimed to help you complete advanced integration of Video Editor SDK.

- [Face AR SDK and AR Cloud](#Face-AR-SDK-and-AR-Cloud)
- [Video recording](#Video-recording)
- [Gallery](#Gallery)
- [Add audio content](#Add-audio-content)
- [Popups](#Popups)
- [Passing Apple Store review](#Passing-Apple-Store-review)
- [Launch methods](#Launch-methods)

## Face AR SDK and AR Cloud
[Banuba Face AR SDK](https://www.banuba.com/facear-sdk/face-filters) is used in Video Editor for applying AR effects in 2 use cases:
1. Camera screen  
   The user can record video content with various AR effects.
2. Editor screen  
   The user can apply various AR effects on existing video.

Video Editor SDK has built in integration with Banuba AR Cloud - remote storage for Banuba AR effects.

Please follow [Face AR and AR Cloud integration guide](guide_far_arcloud.md) if you are interested in disabling Face AR,
integrating AR Cloud, managing AR effects and many more.

## Video recording
Video editor supports functionality allowing to record video using iOS camera. There are many features, configurations and styles
that will help you to record video easily in an excellent quality.  
Please follow [video recording integration guide](guide_video_recording.md) to know more about available features.

## Gallery
Video editor includes gallery screen where the user is able to pick any video and image stored on the device.
Any video or image content is validated before using it in playback or export functionality. See [supported media formats](../README.md#Supported-media-formats).  
Visit [Gallery guide](guide_gallery.md) to get more details how to customize or replace with your own version.

## Add audio content
Video Editor has built in support and API for browsing, playing and applying audio while making video content on various screens.  
Follow [Video Editor audio content integration guide](guide_audio_content.md) to know more details about using audio and API in Video Editor.

## Launch methods
Video Editor supports multiple launch entry points that are declared in ```PresentEventOptions.EntryPoint``` to meet all your requirements.
``` swift
  public enum EntryPoint: String, Codable {
    case camera
    case pip
    case trimmer
    case editor
    case drafts
    case gallery
  }
```

To open Video Editor at desired screen use ```VideoEditorLaunchConfig``` that should be passed to ```presentVideoEditor``` method of ```BanubaVideoEditor``` class.
``` swift
  public func presentVideoEditor(
    withLaunchConfiguration configuration: VideoEditorLaunchConfig,
    completion: (() -> Void)?
  ) {}
```

1. Launch from Camera screen where the user can record video or take a picture.
``` swift
  let launchConfig = VideoEditorLaunchConfig(
    entryPoint: .camera,
    hostController: UIViewController,
    musicTrack: MediaTrack,
    animated: Bool
  )
  videoEditorSDK.presentVideoEditor(
    withLaunchConfiguration: launchConfig,
    completion: nil
  )
```

2. Launch from Camera screen in Picture-in-Picture(PIP) mode.  
:exclamation: Important  
Video editor will not open in PIP mode if your license token does not support PIP feature.
``` swift
  let launchConfig = VideoEditorLaunchConfig(
    entryPoint: .pip,
    hostController: UIViewController,
    pipVideoItem: URL,
    animated: Bool
  )
  videoEditorSDK.presentVideoEditor(
    withLaunchConfiguration: launchConfig,
    completion: nil
  )
```

3. Launch from Trimmer screen where the user can trim video, add transitions and move to editing screens for adding effects.
``` swift
  let launchConfig = VideoEditorLaunchConfig(
    entryPoint: .trimmer,
    hostController: UIViewController,
    videoItems: [URL],
    musicTrack: MediaTrack,
    animated: Bool
  )
  videoEditorSDK.presentVideoEditor(
    withLaunchConfiguration: launchConfig,
    completion: nil
  )
```

4. Launch from Editor screen where the user can add effects to video.
``` swift
  let launchConfig = VideoEditorLaunchConfig(
    entryPoint: .editor,
    hostController: UIViewController,
    videoItems: [URL],
    musicTrack: MediaTrack,
    animated: Bool
  )
  videoEditorSDK.presentVideoEditor(
    withLaunchConfiguration: launchConfig,
    completion: nil
  )
```

5. Launch from Drafts screen where the user can pick any non completed draft and proceed making video.
``` swift
  let launchConfig = VideoEditorLaunchConfig(
    entryPoint: .drafts,
    hostController: UIViewController,
    animated: Bool
  )
  videoEditorSDK.presentVideoEditor(
    withLaunchConfiguration: launchConfig,
    completion: nil
  )
```

6. Launch from Gallery screen where the user can select videos or photos and proceed to the Editor screen.
``` swift
  let launchConfig = VideoEditorLaunchConfig(
    entryPoint: .gallery,
    hostController: UIViewController,
    animated: Bool
  )
  videoEditorSDK.presentVideoEditor(
    withLaunchConfiguration: launchConfig,
    completion: nil
  )
```

## Configure screens
Each screen can be modified to your liking. You can change icons, colors, text and its font, button titles, and much more.

Note that layouts and screen order can't be changed. You can, however, [ask](https://www.banuba.com/faq/kb-tickets/new) us to customize the mobile video editor UI as a separate contract.

### Configure masks, video effects and filters order

The SDK allows to reorder masks and filters in the way you need. To achieve this use the property ```preferredLutsOrder``` and ```preferredMasksOrder```

``` swift
 let config = VideoEditorConfig()
 
 // Sorting for the record screen
 config.recorderConfiguration.recorderEffectsConfiguration.preferredLutsOrder = [
   "egypt",
   "norway",
   "japan"
   ...
 ]
 
 config.recorderConfiguration.recorderEffectsConfiguration.preferredMasksOrder = [
   "XYScanner",
   "Background"
   ...
 ]
 
 // Sorting for the post processing screen
 config.filterConfiguration.preferredLutsOrder = [
   "byers",
   "sunset",
   "vinyl"
   ...
 ]
 
 config.filterConfiguration.preferredMasksOrder = [
   "XYScanner",
   "Background"
   ...
 ]
 
 config.filterConfiguration.preferredVideoEffectOrderAndSet = [
  VisualEffectApplicatorType.acid,
  VisualEffectApplicatorType.dvCam
  ...
]
``` 

### Configure stickers content

Stickers are interactive objects (gif images) that can be added to the video recording to add more fun for users.

By default [**Giphy API**](https://developers.giphy.com/docs/api/) is used to load stickers. All you need is just to pass your personal Giphy Api Key into **giphyAPIKey** parameter in GifPickerConfiguration entity.

GIPHY doesn't charge for their content. The one thing they do require is attribution. Also, there is no commercial aspect to the current version of the product (no advertisements, etc.) To use it, please, add "Search GIPHY" text attribution to the search bar. The placeholder of the search bar is specified by com.banuba.searchGif.placeholder key in Localizable.strings file.

### Configure media content

AI Video Editor SDK is provided with its own solution for media content (i.e. images and videos) selection - the gallery screen. To use it as a part of SDK just add the ```BanubaVideoEditorGallerySDK``` pod to your podfile:
```diff
target 'Example' do
  pod 'BanubaVideoEditorSDK'
  ...
+  pod 'BanubaVideoEditorGallerySDK', '1.23.0'
}
```
The gallery provided by the SDK is fully customizable according to [this guide](guide_gallery.md).

Also there is an option to use **your own implementation of the gallery**. This is available according to this [step-by-step guide](guide_gallery.md).

### Configure additional Video Editor SDK features

1. [Transition effects](transitions_styles.md)

### Disable trim screen

For now, it's possible to turn off the trimmer screen after the camera screen.

The trimmer screen will still be accessible after importing media files from the gallery.

To disable it just change the property ```supportsTrimRecordedVideo``` to ```false``` in ```FeatureConfiguration``` entity.

``` swift
func createVideoEditorConfig() -> VideoEditorConfig {
  var config = VideoEditorConfig()
  ...
  // Default is false
  config.featureConfiguration.supportsTrimRecordedVideo = true
  ...
  return config
}

```

### Configure sharing screen

Sharing screen is an **optional** screen which can be added to the application in order to add Facebook sharing flow just after video export. 

It can be configured by `SharingScreenConfiguration` which is provided to the `presentSharingViewController` function that shows the screen.

```swift
  /// Modally presents Video editor's sharing video view controller
  /// - Parameters:
  ///   - hostController: The view controller to display over.
  ///   - configuration: Sharing view controller configuration.
  ///   - mainVideoUrl: Main video to share with facebook and instagram.
  ///   - videoUrls: Set of video urls to share with sharing iOS controller if needed.
  ///   - animated: Pass true to animate the presentation.
  ///   - completion: The block to execute after the feedback buttons tapped finishes.
  static public func presentSharingViewController(
    from hostController: UIViewController,
    configuration: SharingScreenConfiguration,
    mainVideoUrl: URL,
    videoUrls: [URL],
    previewImage: UIImage,
    animated: Bool,
    completion: (() -> Void)?
  )
```

`SharingScreenConfiguration.sharingModels` describes what kind of sharing services are available at sharing screen.

`SharingScreenConfiguration.facebookId` is a required option for Facebook reels and stories.

### Enabling/Disabling transition effects

Transitions are visual effects applying to the segue between two videos. They are provided with Banuba Video Editor SDK **by default**.

To disable or enable transitions set the flag ```useTransitions``` inside ```FeatureConfiguration``` class to false or true respectively. 
 
 ``` swift
  /// Allows you to use transition effects between videos
  /// Defaults is true
  public var useTransitions: Bool
 ```
 
Example:
 
 ``` swift
 let config = VideoEditorConfig()
 config.featureConfiguration.useTransitions = true
 ```

**Important Note!** 

Transition effects are not being played if the closest video (either to the left or to the right of transition icon) is very short.

### Icons

Any icon in the mobile video editor SDK can be replaced. This is how:

1. Load custom images to the Assets catalog
2. Locate the screen with an icon you want to change in the [VideoEditorConfig](/Example/Example/VideoEditorModule.swift#L75) entity
3. Find the specific element and override it with the resource name or use UIImage, if available.

### Localization

Any text in the mobile video editor SDK can be changed. To edit text resources, download the file with strings [here](/Example/Example/en.lproj/Localizable.strings), change whatever you need, and put the new file into your app.

Don't change the keys (values on the left), only the values on the right. Otherwise, the button names and other texts will not show.
