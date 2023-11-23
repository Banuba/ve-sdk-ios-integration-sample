# FAQ  
These are the answers to the most common questions asked about our SDK.

- [What is the size of Video Editor SDK size?](#what-is-the-size-of-video-editor-sdk-size)
- [How do I start the Video Editor with a preselected audio track?](#how-do-i-start-the-video-editor-with-a-preselected-audio-track)
- [How do I use the Video Editor several times from different entry points?](#how-do-i-use-the-video-editor-several-times-from-different-entry-points)
- [How do I add a color filter (LUT)?](#how-do-i-add-a-color-filter-lut)
- [I want to enabled slideshow animation.](#i-want-to-enable-slideshow-animation)
- [I want to change cursor color.](#i-want-to-change-cursor-color)
- [I want to change progress bar position.](#i-want-to-change-progress-bar-position)
- [How can I get a track name of the audio used in my video after export?](#how-can-i-get-a-track-name-of-the-audio-used-in-my-video-after-export)
- [I want to change the font.](#i-want-to-change-the-font)
- [I want to use custom icons.](faq.md#i-want-to-use-custom-icons)
- [The file “luts” couldn’t be opened because there is no such file.](#the-file-luts-couldnt-be-opened-because-there-is-no-such-file)
- [I want to add audio filters.](#i-want-to-add-audio-filters)
- [I want to change icons and name for effects.](#i-want-to-change-icons-and-name-for-effects)
- [I want to turn off Drafts feature.](#i-want-to-turn-off-drafts-feature)
- [I want to turn off Cover screen.](#i-want-to-turn-off-cover-screen)
- [I want to change visible tabs in gallery.](#i-want-to-change-visible-tabs-in-gallery)
- [I want to get exported video metadata.](#i-want-to-get-exported-video-metadata)
- [I want to change codec type from h264 to h265.](#i-want-to-change-codec-type-from-h264-to-h265)
- [How do I specify the video file saving directory?](#how-do-i-specify-the-video-file-saving-directory)
- [How do I change the language (how do I add new locale support)?](#how-do-i-change-the-language-how-do-i-add-new-locale-support)
- [How can I change the extension of the exported video?](#how-can-i-change-the-extension-of-the-exported-video)
- [What's Face AR and AR Cloud and how can I use them?](#whats-face-ar-and-ar-cloud-and-how-can-i-use-them)
- [How can I customize the video recording?](#how-can-i-customize-the-video-recording)
- [How can I customize the built-in gallery and is there a way to use a completely custom implementation instead?](#how-can-i-customize-the-built-in-gallery-and-is-there-a-way-to-use-a-completely-custom-implementation-instead)
- [What are the ways of adding the audio content to edited video?](#what-are-the-ways-of-adding-the-audio-content-to-edited-video)
- [I want to change the order of masks, video effects or filters](#i-want-to-change-the-order-of-masks-video-effects-or-filters)
- [How can I setup the stickers picker?](#how-can-i-setup-the-stickers-picker)
- [Is it possible to disable the Trim screen?](#is-it-possible-to-disable-the-trim-screen)
- [What are the options of configuring the Sharing screen?](#what-are-the-options-of-configuring-the-sharing-screen)
- [Is it possible to disable the transition effects?](#is-it-possible-to-disable-the-transition-effects)

### What is the size of Video Editor SDK size?
| Options | MB      | Note |
| -------- | --------- | ----- |
| :white_check_mark: Face AR SDK  | 65 | AR effect sizes are not included. AR effect takes 1-3 MB in average.
| :x: Face AR SDK | 23 | no AR effects  |

You can either include the AR filters in the app or have users download them from the [AR cloud](#Configure-AR-cloud) to dramatically decrease the app size.


### How do I start the Video Editor with a preselected audio track?

To do so, add the MediaTrack instance as a parameter to the  `VideoEditorLaunchConfig` which used for starting video editor method.

```swift
let cameraLaunchConfig = VideoEditorLaunchConfig(
  entryPoint: .camera,
  hostController: self,
  musicTrack: MediaTrack(...),
  animated: true
)

videoEditorSDK?.presentVideoEditor(
  withLaunchConfiguration: cameraLaunchConfig,
  completion: nil
)
```

### What are the available entry points of Video Editor?

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

### How do I use the Video Editor several times from different entry points?

Before you want to use VideoEditor again, you need to deinitialize your current editor instance in your [entry point class scope](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/d9733e78a6a752dd8fad849f6aa6d5553eb07f56/Example/Example/ViewController.swift#L675). You need to set 'yourVideoEditorSdkInstance' = nil after following funcs called([done](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/d9733e78a6a752dd8fad849f6aa6d5553eb07f56/Example/Example/ViewController.swift#L660) and [cancel](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/d9733e78a6a752dd8fad849f6aa6d5553eb07f56/Example/Example/ViewController.swift#L678)).

```swift
// Video Editor Delegate implementation example
extension ViewController: BanubaVideoEditorDelegate {
  func videoEditorDone(_ videoEditor: BanubaVideoEditor) {
    // User finished editing sessoin, need to dismiss video editor and export video
    videoEditorSDK?.dismissVideoEditor(
      animated: true
    ) { [weak self] in
      self?.exportVideo(...) { ... in
         self?.'yourVideoEditorSdkInstance' = nil
      }
    }
  }
  
  func videoEditorDidCancel(
    _ videoEditor: BanubaVideoEditor
  ) {
    // User canceled editing sessoin, need to dismiss video editor
    videoEditorSDK?.dismissVideoEditor(
      animated: true,
      completion: {
        self?.'yourVideoEditorSdkInstance' = nil
      }
    )
  }
}
```

Use the following approach if you want to [create BanubaVideoEditor instance](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/d9733e78a6a752dd8fad849f6aa6d5553eb07f56/Example/Example/ViewController.swift#L42) again. 

For example on your tap button action:

```swift
@IBAction func videoEditorButtonTapped(_ sender: UIButton) {
   if 'yourVideoEditorSdkInstance' = nil {
      'yourVideoEditorSdkInstance' = BanubaVideoEditor(...)
   }
}
```

### How do I add a color filter (LUT)?

Color Filters (LUTs) are special graphics files that are placed in the / [luts directory](https://github.com/Banuba/ve-sdk-ios-integration-sample/tree/main/Example/Example/luts) inside the main project folder.

To add your own icon to be used to represent that specific effect in the list, you must place it in the / [assets folder](https://github.com/Banuba/ve-sdk-ios-integration-sample/tree/main/Example/Example/Assets.xcassets/ColorEffectsPreview).

The icon resource name must match the image file name in the / luts directory and end with ```_preview```.

The display name for the resource is set in the [localization files](../Example/Example/en.lproj/Localizable.strings#L275).

The key for the translation string must start with ```com.banuba.filter.name.{lut file name}``` and end with the name of the lut file.

### I want to enable slideshow animation 

To be able to turn off slideshow animation use following property of ```RecorderConfiguration``` and ```CombinedGalleryConfiguration``` entities.

```swift
let config = VideoEditorConfig()

config.combinedGalleryConfiguration.isPhotoSequenceAnimationEnabled = true
config.recorderConfiguration.isPhotoSequenceAnimationEnabled = true
```
### I want to change cursor color

All you need is just to set your color into ```cursorColor``` parameter in ```MainOverlayViewControllerConfig``` entity.

```swift
let config = VideoEditorConfig()

config.overlayEditorConfiguration.mainOverlayViewControllerConfig.cursorColor = .white
```

### I want to change progress bar position

Progress bar position contains two types of layout:
- top
- bottom (**by default**)

To change progress bar position you need to modify ```progressBarPosition``` property of ```RecorderConfiguration``` entity.

```swift
let config = VideoEditorConfig()

config.recorderConfiguration.progressBarPosition = .top
```

### How can I get a track name of the audio used in my video after export?
```swift
/// Video Editor main entity and entry point.
/// Can present and hide root view controller.
/// Has default export method.
public class BanubaVideoEditor {
  /// Simple metadata of music composition settings
  public var musicMetadata: MusicEditorMetadata? { get }
  ...
}
```
`MusicEditorMetadata` contains the array of `MusicEditorTrack` which contains the following fields: 

```swift
// MARK: - MusicEditorTrack
public struct MusicEditorTrack: Codable {
  ///Track URL
  public var url: URL
  ///Track original URL
  public var originalURL: URL
  ///Track title
  public var title: String
  ///Track id
  public var id: Int32
  /// Track volume
  public var volume: Float
  ...
}
```
or if you want to know what track was played on the camera screen you can use:

```swift
/// Video Editor main entity and entry point.
/// Can present and hide root view controller.
/// Has default export method.
public class BanubaVideoEditor {
  /// Music track which will be played on camera recording
  public var musicTrack: MediaTrack? { get }
  ...
}
```
### I want to change the font

You can change the font for the whole video editor by calling in `VideoEditorConfig` this method:
 
```swift
  func applyFont(_ font: UIFont)
```
or change for each screen separately by calling the appropriate methods:
```swift
  func updateFullScreenActivityFonts(_ font: UIFont)
  
  func updateRecorderFonts(_ font: UIFont)
  
  func updateAlbumsFonts(_ font: UIFont)
  
  func updateEditorFonts(_ font: UIFont)
  
  func updateToastFonts(_ font: UIFont)
  
  func updateTextEditorFonts(_ font: UIFont)
  
  func updateSlideShowFonts(_ font: UIFont)
  
  func updateTrimVideoFonts(_ font: UIFont)
  
  func updateTrimVideosFonts(_ font: UIFont)
  
  func updateFilterFonts(_ font: UIFont)
  
  func updateExtendedVideoCoverSelectionFonts(_ font: UIFont)
  
  func updateAlertFonts(_ font: UIFont)
```

Changing the font does not affect its size. The font size will be taken by default or specified by you in the entity configuration.

### I want to use custom icons

Any icon in the mobile video editor SDK can be replaced. This is how:

1. Load custom images to the Assets catalog
2. Locate the screen with an icon you want to change in the [VideoEditorConfig](/Example/Example/VideoEditorModule.swift#L75) entity
3. Find the specific element and override it with the resource name or use UIImage, if available.

### The file “luts” couldn’t be opened because there is no such file.

This error occurs because your application bundle doesn't contains required luts folder.

You need to copy [luts](https://github.com/Banuba/ve-sdk-ios-integration-sample/tree/main/Example/Example/luts) folder to your project.

### I want to add audio filters 

Filters availability depends on the token. However, in order for them to be available, you need to add an implementation of the ```VoiceFilterProvider``` entity.

Example how to inherit ```VoiceFilterProvider``` to your own entity:

```swift
import BanubaMusicEditorSDK
import UIKit

/// Example voice filter provider
struct ExampleVoiceFilterProvider: VoiceFilterProvider {
  private let filters: [VoiceFilter]
  
  // MARK: - VoiceFilterProvider
  
  func provideFilters() -> [VoiceFilter] {
    return filters
  }
  
  init() {
    filters = [
      VoiceFilter(
        type: .elf,
        title: NSLocalizedString("com.banuba.musicEditor.elf", comment: "Elf filter title"),
        image: UIImage(named:"elf")
      ),
      VoiceFilter(
        type: .baritone,
        title: NSLocalizedString("com.banuba.musicEditor.baritone", comment: "Baritone filter title"),
        image: UIImage(named:"baritone")
      ),
      VoiceFilter(
        type: .echo,
        title: NSLocalizedString("com.banuba.musicEditor.echo", comment: "Echo filter title"),
        image: UIImage(named:"echo")
      ),
      VoiceFilter(
        type: .giant,
        title: NSLocalizedString("com.banuba.musicEditor.giant", comment: "Giant filter title"),
        image: UIImage(named:"giant")
      ),
      VoiceFilter(
        type: .robot,
        title: NSLocalizedString("com.banuba.musicEditor.robot", comment: "Robot filter title"),
        image: UIImage(named:"robot")
      ),
      VoiceFilter(
        type: .squirrel,
        title: NSLocalizedString("com.banuba.musicEditor.squirrel", comment: "Squirrel filter title"),
        image: UIImage(named:"squirrel")
      )
    ]
  }
}
```

Then the instance of the ExampleVoiceFilterProvider needs to be passed to the configuration.

```swift
  var config = VideoEditorConfig()
  
  config.musicEditorConfiguration.audioTrackLineEditControllerConfig.voiceFilterProvider = ExampleVoiceFilterProvider()
```

### I want to change icons and name for effects.

The name of the icon for the effect must match the identifier of the effect.
Below is a table with the name, ID and icon of the default effect.

| Default image effect | Name      | ID      |
| ---------- | ---------  | ----------- |
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Effects%20Preview/102000_preview.imageset/Acid-whip.png" width="50"> | Acid whip | 102000
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Effects%20Preview/102001_preview.imageset/cathode.png" width="50"> | Cathode | 102001
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Effects%20Preview/102002_preview.imageset/ic_dv_cam.png" width="50"> | DV Cam | 102002
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Effects%20Preview/102003_preview.imageset/btn_flash2.png" width="50"> | Flash | 102003
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Effects%20Preview/102004_preview.imageset/glitch.png" width="50"> | Glitch | 102004
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Effects%20Preview/102005_preview.imageset/ic_glitch2.png" width="50"> | Glitch 2 | 102005
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Effects%20Preview/102006_preview.imageset/ic_heatmap.png" width="50"> | Heat Map | 102006
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Effects%20Preview/102007_preview.imageset/ic_lumiere.png" width="50"> | Lumiere | 102007
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Effects%20Preview/102008_preview.imageset/ic_Kaleidoscope.png" width="50"> | Mirror | 102008
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Effects%20Preview/102009_preview.imageset/ic_dslrkaleidoscope.png" width="50"> | Mirror 2 | 102009
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Effects%20Preview/102010_preview.imageset/ic_pixeldynamics.png" width="50"> | Pixel Dynamic | 102010
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Effects%20Preview/102011_preview.imageset/ic_pixelstatics.png" width="50"> | Pixel Static | 102011
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Effects%20Preview/102012_preview.imageset/polaroid.png" width="50"> | Polaroid | 102012
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Effects%20Preview/102013_preview.imageset/btn_rave2.png" width="50"> | Rave | 102013
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Effects%20Preview/102014_preview.imageset/btn_soul2.png" width="50"> | Soul | 102014
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Effects%20Preview/102015_preview.imageset/ic_stars.png" width="50"> | Stars | 102015
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Effects%20Preview/102016_preview.imageset/btn_foamtv2.png" width="50"> | TV-Foam | 102016
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Effects%20Preview/102017_preview.imageset/ic_transition1.png" width="50"> | Transition | 102017
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Effects%20Preview/102018_preview.imageset/ic_transition4.png" width="50"> | Transition 2 | 102018
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Effects%20Preview/102019_preview.imageset/btn_vhs2.png" width="50"> | VHS | 102019
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Effects%20Preview/102020_preview.imageset/ic_vhs2.png" width="50"> | VHS 2 | 102020
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Effects%20Preview/102021_preview.imageset/zoom.png" width="50"> | Zoom | 102021
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Effects%20Preview/102022_preview.imageset/ic_zoom2.png" width="50"> | Zoom 2 | 102022
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Effects%20Preview/104000_preview.imageset/btn_slowmotion2.png" width="50"> | 0.5x | 104000
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Effects%20Preview/104001_preview.imageset/btn_rapid2.png" width="50"> | 2x | 104001

In order to change the name of the effect, you need to do it in the [localization file](../Example/Example/en.lproj/Localizable.strings#L254).

### I want to turn off Drafts feature.

To turn off Drafts feature just disable it in ```FeatureConfiguration``` entity:

```swift
  var config = VideoEditorConfig()
  
  config.featureConfiguration.draftsConfig = .disabled
```

### I want to turn off Cover screen.

To turn off Cover screen just disable it in ```FeatureConfiguration``` entity:

```swift
  var config = VideoEditorConfig()
  
  config.featureConfiguration.isVideoCoverSelectionEnabled = false
```

### I want to change visible tabs in gallery

To setup visible tabs for gallery just configure it in ```CombinedGalleryConfiguration``` entity:

```swift
  var config = VideoEditorConfig()
  
  config.combinedGalleryConfiguration.visibleTabsInGallery = [.video, .photo]
```

### I want to get exported video metadata

In order to find out which filter, effects, masks and music was applied to the video, you need to refer to the instance of the entity ```BanubaVideoEditor```.

Instance:
```swift

let videoEditorSDK = BanubaVideoEditor(
  ...
)

// to get color filter
let videoFilter = videoEditorSDK?.metadata?.colorOnVideoMetadata
// to get effects
let videoEffects = videoEditorSDK?.metadata?.effectsOnVideoMetadata
// to get gifs
let videoGif = videoEditorSDK?.metadata?.gifOnVideoMetadata
// to get texts
let videoText = videoEditorSDK?.metadata?.textOnVideoMetadata
// to get music track from record screen
let videoMusicTrack = videoEditorSDK?.musicTrack
// to get music tracks from editor screen
let videoTracks = videoEditorSDK?.musicMetadata?.tracks
```
### I want to change codec type from h264 to h265.

All you need is just to set ```useHEVCCodecIfPossible``` to ```true``` in ```VideoEditorConfig, ExportVideoInfo or ExportVideoConfiguration ``` entity.
The first one you need when you create ```BanubaVideoEditor```, two last ones - when you prepare a video to export.

```swift
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

### How do I specify the video file saving directory?

In ```ExportVideoConfiguration``` set the desired path in fileURL parameter.

```swift
  let exportVideoConfigurations: [ExportVideoConfiguration] = [
    ExportVideoConfiguration(
      fileURL: fileURL,
      quality: .auto,
      useHEVCCodecIfPossible: true,
      watermarkConfiguration: watermarkConfiguration
  )
]
```

### How do I change the language (how do I add new locale support)?

There is no special language switching mechanism in the Video Editor SDK (VE SDK).

Out of the box, the VE SDK includes support for two locales: English (default) and Russian. If you need to support any other locales, you can do it according to the standard iOS way. See how [Create locale directories and resource files](https://developer.apple.com/documentation/xcode/localization) for more details. After adding a new locale resource file into your application with integrated VE SDK, you need to re-define the VE SDK strings keys with new locale string values.
To do that you need to add all needed string keys in the new locale `Localizable.strings` file. You can find the main VE SDK string keys you need in the [Localizable.strings](/Example/Example/en.lproj/Localizable.strings) file.
The newly added locale will be applied after the device language is changed by system settings.

### How can I change the extension of the exported video?

To save the video in the format you want, you just need to add the appropriate ```PathComponent``` when creating the video URL.
```swift
let videoURL = manager.temporaryDirectory.appendingPathComponent("tmp.mov")
```

See example in [sample](../Example/Example/ViewController.swift#L203).

See all formats supported for video export [here](guide_export.md).

### What's Face AR and AR Cloud and how can I use them?

[Banuba Face AR SDK](https://www.banuba.com/facear-sdk/face-filters) is used in Video Editor for applying AR effects in 2 use cases:
1. Camera screen  
   The user can record video content with various AR effects.
2. Editor screen  
   The user can apply various AR effects on existing video.

Video Editor SDK has built in integration with Banuba AR Cloud - remote storage for Banuba AR effects.

Please follow [Face AR and AR Cloud integration guide](guide_far_arcloud.md) if you are interested in disabling Face AR, integrating AR Cloud, managing AR effects and many more.

### How can I customize the video recording?

Video editor supports functionality allowing to record video using iOS camera. There are many features, configurations and styles that will help you to record video easily in an excellent quality.  
Please follow [video recording integration guide](guide_video_recording.md) to know more about available features.

### How can I customize the built-in gallery and is there a way to use a completely custom implementation instead?

Video Editor SDK is provided with its own solution for media content (i.e. images and videos) selection - the gallery screen. To use it as a part of SDK just add the ```BanubaVideoEditorGallerySDK``` pod to your podfile:
```diff
target 'Example' do
  pod 'BanubaVideoEditorSDK'
  ...
+  pod 'BanubaVideoEditorGallerySDK', '1.23.0'
}
```
The gallery provided by the SDK is fully customizable according to [this guide](guide_gallery.md).

Also there is an option to use **your own implementation of the gallery**. This is available according to this [step-by-step guide](guide_gallery.md).

### What are the ways of adding the audio content to edited video?

Video Editor has built in support and API for browsing, playing and applying audio while making video content on various screens.  
Follow [Video Editor audio content integration guide](guide_audio_content.md) to know more details about using audio and API in Video Editor.

### I want to change the order of masks, video effects or filters

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

### How can I setup the stickers picker?

Stickers are interactive objects (gif images) that can be added to the video recording to add more fun for users.

By default [**Giphy API**](https://developers.giphy.com/docs/api/) is used to load stickers. All you need is just to pass your personal Giphy Api Key into **giphyAPIKey** parameter in GifPickerConfiguration entity.

GIPHY doesn't charge for their content. The one thing they do require is attribution. Also, there is no commercial aspect to the current version of the product (no advertisements, etc.) To use it, please, add "Search GIPHY" text attribution to the search bar. The placeholder of the search bar is specified by com.banuba.searchGif.placeholder key in Localizable.strings file.

### Is it possible to disable the Trim screen?

It is possible to turn off the trimmer screen after the camera screen.

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

### What are the options of configuring the Sharing screen?

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

### Is it possible to disable the transition effects?

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
