# Banuba AI Video Editor SDK. Integration sample for iOS.
Banuba [Video Editor SDK](https://www.banuba.com/video-editor-sdk) allows you to add a fully-functional video editor with Tiktok-like features, AR filters and effects in your app. The following guide explains how you can integrate our SDK into your iOS project. 

## Requirements
- Swift 5+
- Xcode 12+
- iOS 11.0+

## Dependencies
- [Banuba Face AR SDK](https://www.banuba.com/facear-sdk/face-filters). *Optional*

## Free Trial  
We offer а free 14-days trial for you could thoroughly test and assess Video Editor SDK functionality in your app. To get access to your trial, please, get in touch with us by [filling a form](https://www.banuba.com/video-editor-sdk) on our website. Our sales managers will send you the trial token. Put it into the app, as described below, to run the SDK.  

## Token
To integrate the Video Editor SDK in your project, you need to have the client token. It helps us to prevent our software from inappropriate and unconditioned usage. The token is unique to each client and valid for a specific time. Once it expires, the access to SDK features will be blocked automatically. The token should be put [here](/Example/Example/ViewController.swift#L21)


## Getting Started
### Setup SSH key for GitHub
1. Paste Banuba ssh private key into .ssh folder on your Mac.
2. Add ssh private key to SSH authentication agent using `passphrase` provided by Banuba. Please, use the following command in Terminal:
   ```sh
   sudo ssh-add <banuba-ssh-private-key-file>
   ```
### CocoaPods
Video Editor SDK is available via CocoaPods. If you're new to CocoaPods, refer to the [Getting Started Guide](https://guides.cocoapods.org/using/getting-started.html). CocoaPods is the preferred and the simplest way to get the SDK.

**Important**: Make sure that you have installed CocoaPods version >= 1.9.0 installed. Check your CocoaPods version using command `pod --version`.

Please, refer to the [example of Podfile](Example/Podfile) lines which you need to add.

1. Make sure to have CocoaPods installed, e.g. via [Homebrew](https://brew.sh):
   ```sh
   brew install cocoapods 
   ```
1. Install Video Editor SDK for the provided Xcode workspace with:
   ```sh
   pod install
   ```
1. Open `Example.xcworkspace` with Xcode and run the project.

### Start Video Editor from ViewController
``` swift
import BanubaVideoEditorSDK

class ViewController: UIViewController {

    private var videoEditorSDK: BanubaVideoEditorSDK?

    override func viewDidLoad() {
        super.viewDidLoad()
    
        initVideoEditor()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        videoEditorSDK?.presentVideoEditor(
            from: self,
            animated: true,
            completion: nil
        )
    }
  
    private func initVideoEditor() {
        let configuration = VideoEditorConfig()
        videoEditorSDK = BanubaVideoEditorSDK(
            token: "place client token here",
            effectsToken: "place effects token here",
            configuration: configuration,
            analytics: nil,
            externalViewControllerFactory: nil
        )
        videoEditorSDK?.delegate = self
    }
    ...
}

// MARK: - Handle Video Editor lifecycle
extension ViewController: BanubaVideoEditorSDKDelegate {
  func videoEditorDidCancel(_ videoEditor: BanubaVideoEditorSDK) {
    videoEditor.dismissVideoEditor(animated: true, completion: nil)
  }
  
  func videoEditorDone(_ videoEditor: BanubaVideoEditorSDK) {
    videoEditor.dismissVideoEditor(animated: true, completion: nil)
  }
}

```  

### Configure export flow
To export video after the editing is complete use these several methods:
``` swift
 /// Export video with default 1280x720 (or 1920x1080 on required devices) resolution
  /// - Parameters:
  ///   - fileUrl: url where exported video should be stored.
  ///   - completion: completion: (success, error), execute on background thread.
  func exportVideo(fileUrl: URL, completion: @escaping (Bool, Error?) -> Void)
  
  /// Export video with default 1280x720 (or 1920x1080 on required devices) resolution and cover image
  /// - Parameters:
  ///   - fileUrl: url where exported video should be stored.
  ///   - completion: completion: (success, error, image), execute on background thread.
  /// Preconfigue WatermarkConfiguration in configuration file otherwise will be used default configuration. Default cover image video indent is 0.5 second.
  func exportVideoWithCoverImage(fileUrl: URL, completion: @escaping (Bool, Error?, UIImage) -> Void)
  
  /// Export several configurable video
  /// - Parameters:
  ///   - configurations: contains configurations for exporting videos such as file url,
  ///    watermark and video quality
  ///   - completion: completion: (success, error), execute on the background thread.
  func exportVideos(using configurations: [ExportVideoConfiguration], completion: (Bool,Error?)->Void)
  
  /// Export several configurable video with cover image
  /// - Parameters:
  ///   - configurations: contains configurations for exporting videos such as file url,
  ///    watermark and video quality
  ///   - completion: completion: (success, error, image), execute on the background thread.
  func exportVideosWithCoverImage(using configurations: [ExportVideoConfiguration], completion: (_Bool, Error?, UIImage)->Void)
```  
Example export video flow see [here](/Example/Example/ViewController.swift#L599).
Detailed export video features you can find [here](export_flow.md)

### Configure screens  
The SDK allows to override icons, colors, typefaces and many more configuration entities. Every SDK screen has its own set of styles.
Below you can find how to customize VE SDK to bring your experience.

1.[Camera screen](mdDocs/camera_styles.md)

2.[Editor screen](mdDocs/editor_styles.md)

3.[Trim screens](mdDocs/trim_styles.md)

The SDK allows overriding icons, colors, typefaces and many more configuration entities. Every SDK screen has its own set of styles.

#### Icons
1. Load icons to the Assets catalog.
1. Find the desired screen for an icon in [VideoEditroConfig](/Example/Example/ViewController.swift#L35) entity.
1. Find the desired UI element in the configuration entity and override the icon with the resource name or put UIImage if an option available.

### Localization
To localize video editor strings resources download [Localized.strings](/Example/Example/en.lproj/Localizable.strings) the most recent for the current release. And make your own localization! We will inform you if any keys will be changed or added.
**Important**: Do not change keys (left values), override only right values.

Below you can find how to customize our Video Editor SDK to get your branded experience.
