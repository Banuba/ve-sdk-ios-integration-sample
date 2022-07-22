[![](https://www.banuba.com/hubfs/Banuba_November2018/Images/Banuba%20SDK.png)](https://www.banuba.com/video-editor-sdk)

# Banuba AI Video Editor SDK. Integration sample for iOS.
Banuba [AI Video Editor SDK](https://www.banuba.com/video-editor-sdk) allows you to quickly integrate short video functionality into your mobile app. On this page, we will explain how to do so on iOS.

<p align="center">
<img src="mdDocs/gif/gif_background.gif" alt="Screenshot" width="19%" height="auto">&nbsp;
<img src="mdDocs/gif/camera_preview.gif" alt="Screenshot" width="19%" height="auto">&nbsp;
<img src="mdDocs/gif/audio_browser.gif" alt="Screenshot" width="19%" height="auto"/>&nbsp;
<img src="mdDocs/gif/editor_timeline.gif" alt="Screenshot" width="19%" height="auto"/>&nbsp;
<img src="mdDocs/gif/pip_preview.gif" alt="Screenshot" width="19%" height="auto"/>&nbsp;
</p>

- [Requirements](#Requirements)
- [Framework dependencies](#Framework-dependencies)
- [Dependencies](#Dependencies)
- [SDKs size](#SDKs-size)
- [Starting a free trial](#Starting-a-free-trial)
- [Supported media formats](#Supported-media-formats)
- [Token](#Token)
- [Connecting with AR cloud](#Connecting-with-AR-cloud)
- [What can you customize?](#What-can-you-customize)
- [Face AR](#Face-AR)
- [Integration](#Integration)
    + [Step 1. Setup SDK dependencies with SPM or Cocoapods](#Step-1-Setup-SDK-dependencies-with-SPM-or-Cocoapods)
       + [SwiftPackageManager](#Swift-Package-Manager)
       + [CocoaPods](#CocoaPods)
    + [Step 2. Start Video Editor from ViewController](#Step-2-Start-Video-Editor-from-ViewController)  
 - [Customization](#Customization)
    + [Configure export flow](#Configure-export-flow)
    + [Configure audio content](#Configure-audio-content)
    + [Configure screens](#Configure-screens)
    + [Configure masks, video effects and filters order](#Configure-masks-video-effects-and-filters-order)
    + [Configure watermark](#Configure-watermark)
    + [Configure stickers content](#Configure-stickers-content)
    + [Configure additional Video Editor SDK features](#Configure-additional-Video-Editor-SDK-features)
    + [Icons](#Icons)
    + [Localization](#Localization)
- [Analytics](#Analytics)
- [FAQ](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/mdDocs/faq.md)
- [Third party libraries](#Third-party-libraries)

## Requirements
This is what you need to run the AI Video Editor SDK

- iPhone devices 6+
- Swift 5+
- Xcode 13.0+
- iOS 12.0+
Unfortunately, It isn't optimized for iPads.

## Framework dependencies

Our SDK contains dependencies on native libraries, as well as third-party ones.
Below are listed our native frameworks dependencies:

1. Foundation
1. AV Foundation
1. UI Kit
1. AV Kit
1. Core media
1. Core video
1. Core graphics
1. GL Kit
1. Photos
1. OpenGLES
1. MetalKit
1. SystemConfiguration
1. OSLog
1. GLProgram
1. MediaPlayer
1. Accelerate

Dependencies on third-party libraries and their licenses you could view [here](mdDocs/3rd_party_licences.md).

## Dependencies

To use the face masks, you will also need the [Face AR SDK](https://www.banuba.com/facear-sdk/face-filters). It is optional, however, the other features will work without it. 

## SDKs size

| Options | Mb      | Note |
| -------- | --------- | ----- |
| :white_check_mark: Face AR SDK + bitcode enabled  | 60 | AR effect sizes are not included. AR effect takes 1-3 MB in average.
| :x: Face AR SDK + bitcode enabled | 47 | no AR effects  |

|№ | Moduls | arm64. Mb| x86_64. Mb | CodeResources. Mb | assets. Mb | Total resources. Mb | xcframework. Mb | Size without resources. Mb | Approximate size in AppStore. Mb |
| -------- | --------- | ----- | -------- | --------- | ----- | -------- | --------- | ----- | -------- |
| 1 | BanubaARCloudSDK | 2,3 |	1,1 | 0,1 | 0 |	0,1 | 3,4 | 3,3 | 1,2 |
| 2 | BanubaAudioBrowserSDK | 6,9 | 8,1 | 7 | 0,367 | 7,367 | 15 | 7,633 | 1,61 |
| 3 | BanubaEffectPlayer | 108 | 58 | 70 | 0 | 70 | 166 | 96 | 37,45 |
| 4 | BanubaLicenseServicingSDK | 1,6 | 1,3 | 0,012 | 0 | 0,012 | 2,9 | 2,888 | 0,42 |
| 5 | BanubaMusicEditorSDK | 9,1 | 6,6 | 0,012 | 0,187 | 0,199 | 15,7 | 15,501 | 1,715 |
| 6 | BanubaOverlayEditorSDK | 17 | 7,5 | 0,014 | 0,88 | 0,894 | 24,5 |	23,606 | 2,003 |
| 7 | BanubsSDK | 6,6 |	4,8 | 0,006 | 0 | 0,006 | 11,4 | 11,394 | 1,225 |
| 8 | BanubaSDKServicing | 0,901 | 0,792 | 0,012 | 0 | 0,012 | 1,693 | 1,681 | 0,21 |
| 9 | BanubaSDKSimple |	5,8 | 4,2 | 0,03 | 0 | 0,03 | 10 | 9,97 | 1,085 |
| 10 | BanubaTokenStorageSDK | 0,73 | 0,65 | 0,012 | 0 | 0,012 | 1,38 |	1,368 |	0,175 |
| 11 | BanubaUtilities | 9,4 | 7,2 | 0,011 | 0 | 0,011 | 16,6 | 16,589 | 3,5 |
| 12 | VEEffectsSDK | 12,5 | 6,3 | 0,01 | 0 | 0,01 | 18,8 | 18,79 | 1,47 |
| 13 | BanubaVideoEditorGallerySDK | 3,3 | 2,5 | 0,016 | 0,087 | 0,103 | 5,8 | 5,697 | 0,595 |
| 14 | BanubaVideoEditorSDK | 48,3 | 31,7 | 2,8 | 2,9 | 5,7 | 80 | 74,3 | 8,715 |
| 15 | BanubaVideoEditorTrimSDK | 1,9 |	1,6 | 0,09 | 0 | 0,09 |	3,5 | 3,41 | 0,42 |
| 16 | BNBLicenseUtils | 3 | 3,5 | 3 | 0 | 3 | 6,5 | 3,5 | 1,005 |
| 17 | VEExportSDK | 1,5 | 1,2 | 0,09 | 0 | 0,09 | 2,7 | 2,61 |	1,22 |
| 18 | VEPlaybackSDK | 1,2 | 0,959 | 0,09 | 0 |	0,09 | 2,159 | 2,069 | 0,273 |
| 19 | VideoEditor | 6,1 | 4,2 | 0,06 | 0,128 |	0,188 |	10,3 | 10,112 |	1,4 |

You can either include the filters in the app or have users download them from the [AR cloud](https://www.banuba.com/facear-sdk/face-filters) to decrease the app size. 

## Supported media formats
| Audio      | Video      | Images      |
| ---------- | ---------  | ----------- |
|.mp3, .aac, .wav, <br>.m4a, .flac, .aiff |.mp4, .mov, .m4v| .bmp, .gif, .heic, <br>.jpeg, .jpg, .png, .tiff 

## Camera recording video quality params
To be able to use your own quality parametrs please follow this [guide](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/mdDocs/video_resolution_configuration.md).

| Recording speed | 360p(360 x 640) | 480p(480 x 854) | 540p(540 x 960) |  HD(720 x 1280) | FHD(1080 x 1920) |
| --------------- | --------------- | --------------- | --------------- | --------------- | ---------------- |
| 1x(Default)     | 800             | 2000            | 2000            | 4000            | 6400             |
| 0.5x            | 800             | 2000            | 2000            | 4000            | 6400             |
| 2x              | 800             | 2000            | 2000            | 4000            | 6400             |
| 3x              | 800             | 2000            | 2000            | 4000            | 6400             |  

## Export video quality params
Video Editor SDK classifies every device by its performance capabilities and uses the most suitable quality params for the exported video.

Nevertheless it is possible to customize it with `ExportVideoConfiguration`. Just put a required video quality into `ExportVideoInfo(resolution)` constructor. To be able to use your own quality parametrs please follow this [guide](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/mdDocs/video_resolution_configuration.md).

See the **default bitrate (kbps)** for exported video (without audio) in the table below:
| 360p(360 x 640) | 480p(480 x 854) | 540p(540 x 960) | HD(720 x 1280) | FHD(1080 x 1920) |
| --------------- | --------------- | ---------------- | -------------- | ---------------- |
|              800|             2000|              2000|            4000|              6400|

## Starting a free trial

You should start with getting a trial token. It will grant you **14 days** to freely play around with the AI Video Editor SDK and test its entire functionality the way you see fit.

There is nothing complicated about it - [contact us](https://www.banuba.com/video-editor-sdk) or send an email to sales@banuba.com and we will send it to you. We can also send you a sample app so you can see how it works “under the hood”.

## Token 
We offer а free 14-days trial for you could thoroughly test and assess Video Editor SDK functionality in your app. To get access to your trial, please, get in touch with us by [filling a form](https://www.banuba.com/video-editor-sdk) on our website. Our sales managers will send you the trial token.

There are three options where to put your token:
- Inside the app: [read here](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/97ebccf9e52b31db92586709cc6afa55decb9d75/Example/Example/ViewController.swift#L83).
- In the Firebase (what will allow your users not to update the app every time the token is updated): [Firebase setup guide](https://firebase.google.com/docs/database/android/start), [SDK configuration for Firebase](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/mdDocs/token_on_firebase.md).
- In the remote server: [SDK configuration for this case](https://github.com/Banuba/ve-sdk-ios-integration-sample/new/Update_token_configure/mdDocs). 

## Connecting with AR cloud

To decrease the app size, you can connect with our servers and pull AR filters from there. The effects will be downloaded whenever a user needs them. Please check out [step-by-step guide](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/mdDocs/ar_cloud.md) guide to configure AR Cloud in the Video Editor SDK.

## What can you customize?

We understand that the client should have options to brand video editor to bring its own experience to the market. Therefore we provide list of options to customize:

:white_check_mark: Use your branded icons. [See details](#Configure-screens)  
:white_check_mark: Use you branded colors. [See details](#Configure-screens)  
:white_check_mark: Change text styles i.e. font, color. [See details](#Configure-screens)  
:white_check_mark: Masks, video effects and filters order. [See details](#Configure-masks-video-effects-and-filters-order)  
:white_check_mark: Localize and change text resources. Default locale is :us:  
:white_check_mark: Make content you want i.e. a number of video with different resolutions and durations, an audio file. [See details](#Configure-export-flow)  
:white_check_mark: Customize video recording duration behavior. [See details](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/mdDocs/video_duration_configuration.md)   
:white_check_mark: Settings for the camera. [See details](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/Add_description_configs_for_camera/mdDocs/config_camera.md#camera-config)   
:x: Change layout **except** [Camera and Postprocessing screens](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/mdDocs/faq.md#10-i-want-to-change-screens-layout)

:x: Change screen order

:exclamation: We do custom UX/UI changes as a separate contract. Please contact our sales@banuba.com.

### Face AR 

Face AR SDK is optional for the video editor SDK and would be disabled if it is not included in your token. If you don't use Face AR SDK make the following changes in ```Podfile``` to remove it:

```diff
-  pod 'BanubaEffectPlayer', '1.24.0'
-  pod 'BanubaSDK', '1.24.0'
+  pod 'BanubaSDKSimple', '1.24.0'
```

## Integration

:exclamation: **Important:** Do not forget to copy all the resources that the sample contains, such as the **luts folder and etc**.

### Step 1. Setup SDK dependencies with SPM or Cocoapods

The easiest ways to integrate the Video Editor SDK in your mobile app are through [CocoaPods](https://cocoapods.org) or [SwiftPackageManager](https://developer.apple.com/documentation/swift_packages). If you haven’t used this dependency managers before, see the [Cocoapods Getting Started Guide](https://guides.cocoapods.org/using/getting-started.html) and [SPM Getting Started Guide](https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app).

### Swift Package Manager

Important: Sample intergration of SPM and VideoEditor is in [spm branch](https://github.com/Banuba/ve-sdk-ios-integration-sample/tree/spm)

Please add a [link](https://github.com/Banuba/spm) to the collection of packages:

1. Open App project -> navigate to SwiftPackages tab.
<p align="center">
<img src="mdDocs/SPMTab.png" alt="Screenshot" width="60%" height="auto">&nbsp;
</p>
2. Tap 'plus' button -> type package collections repo url.
<p align="center">
<img src="mdDocs/SDKUrl.png" alt="Screenshot" width="60%" height="auto">&nbsp;
</p>
3. Choose 'Exact Version' release version -> type newest SDK version.
<p align="center">
<img src="mdDocs/ExactVersion.png" alt="Screenshot" width="60%" height="auto">&nbsp;
</p>
4. Tap 'Add Package' button.
The lists with all available modules will appear in the displayed window. 

Please check the boxes for the modules you need to install and click the 'Add Package' button.
<p align="center">
<img src="mdDocs/screenshots/collectionSPM.png" alt="Screenshot" width="60%" height="auto">&nbsp;
</p>
5. Download the latest module version.

### CocoaPods

Important: Make sure that you have CocoaPods version >= 1.9.0 installed. Check your CocoaPods version using this command ```pod --version```

Please, refer to the example of [Podfile](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Podfile) lines which you need to add.

1. Make sure to have CocoaPods installed, e.g. via Homebrew:
   ```sh
   brew install cocoapods 
   ```
2. Initialize pods in your project folder (if you didn't do it before).
   ```sh
   pod init
   ```
3. Install the Video Editor SDK for the provided Xcode workspace with:
   ```sh
   pod install
   ```
4. Open Example.xcworkspace with Xcode and run the project.

### Step 2. Start Video Editor from ViewController

``` swift
import BanubaVideoEditorSDK

class ViewController: UIViewController {

  private var videoEditorSDK: BanubaVideoEditor?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    initVideoEditor()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    let launchConfig = VideoEditorLaunchConfig(
      entryPoint: .camera,
      hostController: self,
      animated: true
    )
    videoEditorSDK?.presentVideoEditor(
      withLaunchConfiguration: launchConfig,
      completion: nil
    )
  }
  
  private func initVideoEditor() {
    let configuration = VideoEditorConfig()
    videoEditorSDK = BanubaVideoEditor(
      token: "place client token here",
      configuration: configuration,
      externalViewControllerFactory: nil
    )
    videoEditorSDK?.delegate = self
  }
}

// MARK: - Handle Video Editor lifecycle
extension ViewController: BanubaVideoEditorDelegate {
  func videoEditorDidCancel(_ videoEditor: BanubaVideoEditor) {
    videoEditor.dismissVideoEditor(animated: true, completion: nil)
  }
  
  func videoEditorDone(_ videoEditor: BanubaVideoEditor) {
    videoEditor.dismissVideoEditor(animated: true, completion: nil)
  }
}

```  

The Video Editor has one entry point:

``` swift
/// Modally presents Video editor's  view controller with pre-defined configuration
  /// - Parameters:
  ///   - configuration: contains configurations for launching Video editor's screen
  ///   - completion: The block to execute after the presentation finishes.
func presentVideoEditor(
  withLaunchConfiguration configuration: VideoEditorLaunchConfig,
  completion: (() -> Void)?
)
```  

`VideoEditorLaunchConfig` contains the following fields:
``` swift
/// The video editor launch configuration
@objc public class VideoEditorLaunchConfig: NSObject {
  /// Setups VE start screen.
  public var entryPoint: PresentEventOptions.EntryPoint
  /// The view controller to display over.
  public var hostController: UIViewController
  /// An array with urls to videos located on a phone.
  public var videoItems: [URL]?
  /// Drafted launch config
  public var draftedLaunchConfig: DraftedLaunchConfig?
  /// A url to video located on a phone.
  public var pipVideoItem: URL?
  /// Music track which will be played on camera recording.
  public var musicTrack: MediaTrack?
  /// Pass true to animate the presentation.
  public var animated: Bool
  
  /// Describes config from drafts launching
  public struct DraftedLaunchConfig {
    /// Drafted video sequence
    public var draftedVideoSequence: VideoSequence
    /// Drafts feature config
    public var draftsConfig: DraftsFeatureConfig
    // MARK: - Init
    public init(
      draftedVideoSequence: VideoSequence,
      draftsConfig: DraftsFeatureConfig
    ) {
      ...
    }
  }
  
  // MARK: - Init
  public init(
    entryPoint: PresentEventOptions.EntryPoint,
    hostController: UIViewController,
    videoItems: [URL]? = nil,
    pipVideoItem: URL? = nil,
    draftedLaunchConfig: DraftedLaunchConfig? = nil,
    musicTrack: MediaTrack? = nil,
    animated: Bool
  ) {
    ...
  }
}

/// EntryPoint describes what kind of entry point is used in video editor navigation flow
public enum EntryPoint: String, Codable {
  case camera
  case pip
  case trimmer
  case editor
  case drafts
}
``` 

## Customization

### Configure export flow

To export video after the editing is complete use these method:

``` swift
  /// Export several configurable video
  /// - Parameters:
  ///   - configuration: contains configurations for exporting videos such as file url,
  ///    watermark and video quality and etc.
  ///   - completion: completion: (success, error, exportCoverImages), execute on background thread.
  public func export(
    using configuration: ExportConfiguration,
    completion: @escaping ((_ success: Bool, _ error: Error?, _ exportCoverImages: ExportCoverImages?)->Void)
  )
```  
See the sample export video flow [here](/Example/Example/ViewController.swift#L177). You can find the detailed video export features [here](export_flow.md).

### Configure audio content

Banuba Video Editor SDK can trim audio tracks, merge them, and apply them to a video. It doesn’t include music or sounds. However, it can be integrated with [Mubert](https://mubert.com/) and get music from it (requires additional contract with them). Moreover, the users can add audio files from internal memory (downloaded library) from the phone. 

Integrating audio content is simple. See this [guide](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/mdDocs/audio_content.md#step-1).

### Configure screens  

Each screen can be modified to your liking. You can change icons, colors, text and its font, button titles, and much more. 

Note that layouts and screen order can’t be changed. You can, however, [ask](https://www.banuba.com/video-editor-sdk#form) us to customize the mobile video editor UI as a separate contract. 

Below see the list of screens with links to their detailed description and notes on modifying them

1. [Camera screen](mdDocs/camera_styles.md)
1. [Editor screen](mdDocs/editor_styles.md)
1. [Trim screens](mdDocs/trim_styles.md)
1. [Overlay screens](mdDocs/overlayEditor_styles.md)
1. [Music editor screen](mdDocs/musicEditor_styles.md)
1. [Gallery screen](mdDocs/gallery_styles.md)
1. [Alert screens](mdDocs/alert_styles.md)
1. [Cover screen](mdDocs/cover_style.md)
1. [Hands Free screen](mdDocs/handsFree_styles.md)
1. [Audio Browser screen](mdDocs/audioBrowser.md)
1. [Picture in picture](mdDocs/pip_configuration.md)

The SDK allows overriding icons, colors, typefaces and many more configuration entities. Every SDK screen has its own set of styles.

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

### Configure watermark

You can add a branded image that would appear on videos that users export. 

To do so, create and configure the WatermarkConfiguration structure, then add it to the ExportVideoConfiguration entity. 

See this [example](/Example/Example/ViewController.swift#L629) for details.

### Configure stickers content

Stickers are interactive objects (gif images) that can be added to the video recording to add more fun for users. 

By default [**Giphy API**](https://developers.giphy.com/docs/api/) is used to load stickers. All you need is just to pass your personal Giphy Api Key into **giphyAPIKey** parameter in GifPickerConfiguration entity.

GIPHY doesn't charge for their content. The one thing they do require is attribution. Also, there is no commercial aspect to the current version of the product (no advertisements, etc.) To use it, please, [add "Search GIPHY" text attribution](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/update_placeholder_for_search_gif/mdDocs/overlayEditor_styles.md#string-resources) to the search bar.

### Configure the record button
The record button is a main control on the camera screen which you can fully customize along with animations playing on tap.

First of all look at [RecordButtonConfiguration](mdDocs/record_button_configuration.md) entity which you can customize in [Camera screen configuration quide](mdDocs/camera_styles.md). If it still not suits your needs you can create your own view for more information look [here](mdDocs/record_button_provider.md)

### Configure media content

AI Video Editor SDK is provided with its own solution for media content (i.e. images and videos) selection - the gallery screen. To use it as a part of SDK just add the ```BanubaVideoEditorGallerySDK``` pod to your podfile:
```diff
target 'Example' do
  pod 'BanubaVideoEditorSDK'
  ...
+  pod 'BanubaVideoEditorGallerySDK', '1.23.0'
}
```
The gallery provided by the SDK is fully customizable according to [this guide](mdDocs/gallery_styles.md). 

Also there is an option to use **your own implementation of the gallery**. This is available according to this [step-by-step guide](mdDocs/configure_external_gallery.md). 

### Configure additional Video Editor SDK features

1. [Transition effects](mdDocs/transitions_styles.md)

### Icons

Any icon in the mobile video editor SDK can be replaced. This is how:

1. Load custom images to the Assets catalog
2. Locate the screen with an icon you want to change in the [VideoEditorConfig](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/ViewController.swift#L70) entity
3. Find the specific element and override it with the resource name or use UIImage, if available.

For [example](/Example/Example/ViewController.swift#L123), this is how you change a mask icon on the camera screen.

### Localization

Any text in the mobile video editor SDK can be changed. To edit text resources, download the file with strings [here](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/en.lproj/Localizable.strings), change whatever you need, and put the new file into your app.

Don’t change the keys (values on the left), only the values on the right. Otherwise, the button names and other texts will not show.

## Analytics

The SDK generates simple metadata analytics in JSON file that you can use in your application. 
You need to make sure that analytics collection is enabled in your token. 

After export, the analytics as a row is available in the entity:
```swift
let analytics: String? = videoEditorSDK?.metadata?.analyticsMetadataJSON
```
Output example:
```JSON
{
  "export_duration": 18.613733167,
  "export_success": true,
  "camera_effects": [
    "mask:Beauty",
    "mask:HairGradient_Avocado",
    "neon.png"
  ],
  "video_resolutions": [
    "default854x480"
  ],
  "os_version": "12.4.7",
  "video_count": 1,
  "post_processing_effects": [
    "101",
    "202",
    "mask:2_5D_HeadphoneMusic"
  ],
  "token": "commercial",
  "video_duration": 19.433333333333334,
  "sdk_version": "1.22.0",
  "video_sources": [
    {
      "startTime": "0.0",
      "title": "3CE046B1-9308-44A5-8AC4-E14B5C273F1D",
      "endTime": "3.0",
      "type": "camera"
    },
    {
      "startTime": "3.0",
      "title": "1120F49A-F04C-49BF-B586-0307897B9E74",
      "endTime": "12.8",
      "type": "gallery"
    },
    {
      "startTime": "12.8",
      "title": "82A8C971-04D0-4677-BA3C-61DD2EFB6BAD",
      "endTime": "15.8",
      "type": "camera"
    },
    {
      "startTime": "15.8",
      "title": "D1B9EC82-02BB-4052-B97E-1CFA3489BC3B",
      "endTime": "18.458333333333336",
      "type": "camera"
    }
  ]
}
```


## FAQ  
Please visit our [FAQ page](mdDocs/faq.md) to find more technical answers to your questions.

## Third party libraries
[View](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/mdDocs/3rd_party_licences.md) information about third party libraries.

## Migration guides

[1.0.15](https://www.notion.so/vebanuba/1-0-15-c871422c06254f5f955952d1ffa5a51b)  
[1.0.16](https://www.notion.so/vebanuba/1-0-16-4dff1bb8bde2433697860ad77e17215c)  
[1.0.17](https://www.notion.so/vebanuba/1-0-17-24148881b66d48a5a7daa0a891a4cc3f)  
[1.0.18](https://www.notion.so/vebanuba/1-0-18-d30441bdb9c44bfcb7f12d20b69a9977)  
[1.0.19](https://www.notion.so/vebanuba/1-19-0-7954637332964fc6ba87f477db112fdf)  
[1.20.0](https://www.notion.so/vebanuba/1-20-0-39fe7f401a4b49ce9697e3abb8bf56b7)  
[1.21.0](https://www.notion.so/vebanuba/1-21-0-6220edd4fd244cf28a997825a369203b)  
[1.22.0](https://www.notion.so/vebanuba/1-22-0-f1256f7ede8a4595a0a8c82b75cc98f8)  
[1.23.0](https://www.notion.so/vebanuba/1-23-4db3e390e3e54b93b54514ca6ea5a7b4)
[1.24.0](https://www.notion.so/vebanuba/1-24-53aa73ae3d3b4c268e5865a4523f8965)
