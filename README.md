# Banuba Video Editor SDK Integration sample for iOS
[Banuba VE SDK](https://www.banuba.com/video-editor-sdk)
The Most Powerful Augmented Reality Video Editor SDK for Mobile

## Requirements
- Swift 5+
- Xcode 12+
- iOS 11.0+

## Dependencies
- [Banuba Face AR SDK](https://www.banuba.com/facear-sdk/face-filters). *Optional*

## Free Trial  
We offer а free 14-days trial, so you have the opportunity to thoroughly test and assess Video Editor SDK functionality in your app. To get access to your trial, please, get in touch with us via [sales@banuba.com](mailto:sales@banuba.com). They will send you the trial token. Put it into the app, as described below, to run the SDK.  

## Token
Banuba uses tokens for Face AR SDK to manange features and protect the technology. SDK usage requires up to date tokens (trial or commercial one). When tokens expires, the SDK features became not available. The token should be put [here](/Example/Example/ViewController.swift#L21)


## Getting Started
### Setup SSH key for GitHub
1. Paste provided Banuba ssh private key into .ssh folder on your Mac.
2. Add ssh private key to SSH authentication agent using `passphrase` provided by Banuba. Please make the following command in Terminal:
   ```sh
   sudo ssh-add <banuba-ssh-private-key-file>
   ```
### CocoaPods
VideoEditorSDK is available via CocoaPods. If you're new to CocoaPods, [this Getting Started Guide will help you](https://guides.cocoapods.org/using/getting-started.html). CocoaPods is the preferred and the simplest way get the VE SDK.

**Important**: Please make sure that you have installed CocoaPods version >= 1.9.0 installed. Please check your CocoaPods version using command `pod --version`.

The example of Podfile lines which you have to add you can find [here](Example/Podfile)

1. Make sure to have CocoaPods installed, e.g., via [Homebrew](https://brew.sh):
   ```sh
   brew install cocoapods 
   ```
1. Install VideoEditorSDK for the provided Xcode workspace with:
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
To export video after finishing editing use these several methods:
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
