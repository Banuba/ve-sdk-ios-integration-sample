# Quickstart Guide

- [Installation](#Installation)
- [Info.plist Updates](#Info.plist-Updates)
- [Localization](#Localization)
- [Video Editor Module Setup](#Video-Editor-Module-Setup)
- [Launch](#Launch)
- [Implement export](#Implement-export)
- [Advanced integration](#Advanced-integration)

## Installation

### CocoaPods
:exclamation: Important
Requires CocoaPods 1.12.1+. Check with pod --version and upgrade if needed.

1. Add sources and pods to your Podfile:

```ruby
source 'https://cdn.cocoapods.org/'
source 'https://github.com/Banuba/specs.git'
source 'https://github.com/sdk-banuba/banuba-sdk-podspecs.git'

banuba_sdk_version = '1.50.1'

pod 'BanubaVideoEditorSDK', banuba_sdk_version
pod 'BanubaSDKSimple', banuba_sdk_version
pod 'BanubaSDK', banuba_sdk_version
pod 'BanubaARCloudSDK', banuba_sdk_version      # optional
pod 'BanubaAudioBrowserSDK', banuba_sdk_version # optional
```
2. Install the pods:

```sh
pod install --repo-update
```

3. Open the generated ```.xcworkspace``` in Xcode and run the project.

### SPM

SPM integration is available in the [spm branch](https://github.com/Banuba/ve-sdk-ios-integration-sample/tree/spm).

1. Add the required packages using the URLs:
https://github.com/Banuba/BanubaVideoEditorSDK-iOS
https://github.com/Banuba/BanubaSDK-iOS

2. Use Exact Version mode and specify the 1.50.1 version.

:exclamation: Info
For more details, refer to the [SPM installation guide](https://docs.banuba.com/ve-pe-sdk/docs/ios/spm-installation).

## Info.plist Updates

Add the iOS permissions required by the SDK (camera, microphone, photo library, media library) to your [Info.plist](../example/ios/Runner/Info.plist):

```xml
<key>NSAppleMusicUsageDescription</key>
<string>This app requires access to the media library</string>
<key>NSCameraUsageDescription</key>
<string>This app requires access to the camera.</string>
<key>NSMicrophoneUsageDescription</key>
<string>This app requires access to the microphone.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>This app requires access to the photo library.</string>
```

## Localization

Add [English Localized Strings](../Example/Example/en.lproj/Localizable.strings) file to the project.

## Video Editor Module Setup

1. Create [VideoEditorModule](../Example/Example/VideoEditorModule.swift) to initialize and customize the Video Editor SDK.
2. Inside it, add [method](../Example/Example/VideoEditorModule.swift#L73) with your customizations:
```swift
class VideoEditorModule {
  ... 
  func createConfiguration() -> VideoEditorConfig {
      var config = VideoEditorConfig()
      ...
      return config
  }
}
```

## Launch
Create instance of ```BanubaVideoEditor```  by using the license token.
```swift
let videoEditorSDK = BanubaVideoEditor(
      token: AppDelegate.licenseToken,
      configuration: config,
      externalViewControllerFactory: viewControllerFactory
    )
```

:exclamation: Important
1. Returns ```nil``` if the license token is invalid – verify your token
2. [Check license activation](../Example/Example/ViewController.swift#L217) before starting the editor.
3. Expired/revoked licenses show a "Video content unavailable" screen
<p align="center">
<img src="screenshots/screen_expired.png"  width="25%" height="auto">
</p>

This [example](../Example/Example/ViewController.swift#L45) launches from camera:
```swift
 let cameraLaunchConfig = VideoEditorLaunchConfig(
        entryPoint: .camera,
        hostController: self,
        musicTrack: nil, // Paste a music track as a track preset at the camera screen to record video with music
        animated: true
)

videoEditorModule.presentVideoEditor(with: cameraLaunchConfig)
```

## Implement export

The Video Editor SDK can export multiple files at once.
To set up export:

1. Make an ExportConfiguration object. Add one or more ExportVideoConfiguration objects to it. Each one stands for a video or audio file.

2. Call BanubaVideoEditor.export() and pass your ExportConfiguration to start.

Check the [export implementation](../Example/Example/ViewController.swift#L250) in the sample.

Read the [Export integration guide](https://docs.banuba.com/ve-pe-sdk/docs/ios/guide_export) for more details.

## Advanced integration

Explore [advanced setup and customization](https://docs.banuba.com/ve-pe-sdk/docs/ios/adv-integration-overview/) in our documentation.