# Quickstart Guide

- [Installation](#Installation)
- [Info.plist Updates](#Info.plist-Updates)
- [Video Editor Module Setup](#Video-Editor-Module-Setup)
- [Launch](#Launch)
- [Implement export](#Implement-export)
- [Localization](#Localization)
- [Advanced integration](#Advanced-integration)

## Installation

There are 2 options to get iOS Video Editor SDK dependencies
1. [Swift Package Manager](https://developer.apple.com/documentation/swift_packages) 
2. [CocoaPods](https://cocoapods.org)

### SPM

The integration with SPM is in [spm branch](https://github.com/Banuba/ve-sdk-ios-integration-sample/tree/spm)

Complete the following steps to get Video Editor SDK dependencies using SPM.

1. Open ```App project```  and navigate to ```Swift Packages``` tab.
2. Click the ```plus``` button and add the necessary packages via links: https://github.com/Banuba/BanubaVideoEditorSDK-iOS, https://github.com/Banuba/BanubaSDK-iOS.
3. Choose ```Exact Version``` release version and type newest SDK version.
4. Select the necessary modules in a list and click the ```Add Package``` button.

:exclamation: Info
Refer to [main docs](https://docs.banuba.com/ve-pe-sdk/docs/ios/spm-installation) for more detailed information about SPM installation

### CocoaPods

:exclamation: Important  
It is required to have CocoaPods version ```1.12.1``` or newer.
Please check your version ```pod --version``` and upgrade.

Complete the following steps to get Video Editor SDK dependencies using CocoaPods.
1. Install CocoaPods using Homebrew
   ```sh
   brew install cocoapods 
   ```
2. Initialize pods in your project folder
   ```sh
   pod init
   ```
3. Add the necessary frameworks and podspec sources to the Podfile of your project:
   ```sh
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
4. Install Video Editor SDK pods
   ```sh
   pod install --repo-update
   ```
5. Open ```Example.xcworkspace``` in Xcode and run the project.

:exclamation: Info
Refer to [main docs](https://docs.banuba.com/ve-pe-sdk/docs/ios/cocapods-installation) for more detailed information about SPM installation

## Info.plist Updates

Add the following iOS permissions used by the SDK in your [Info.plist](../example/ios/Runner/Info.plist)
```
<key>NSAppleMusicUsageDescription</key>
<string>This app requires access to the media library</string>
<key>NSCameraUsageDescription</key>
<string>This app requires access to the camera.</string>
<key>NSMicrophoneUsageDescription</key>
<string>This app requires access to the microphone.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>This app requires access to the photo library.</string>
```

## Video Editor Module Setup
Custom behavior of Video Editor SDK in your app is implemented by using a number of configuration classes in the SDK.

First, create new class [VideoEditorModule](../Example/Example/VideoEditorModule.swift) for implementing configurations.
```swift
class VideoEditorModule {
  
}
```
Next, create ```VideoEditorConfig``` for implementing custom video editor configurations.
```swift
class VideoEditorModule {
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
```videoEditorSDK``` is ```nil``` when the license token is incorrect i.e. empty, truncated.
If ```videoEditorSDK``` is not ```nil``` you can proceed and start video editor.

Next, we strongly recommend checking your license state before starting video editor
```swift
videoEditorSDK?.getLicenseState(completion: { [weak self] isValid in
      if isValid {
        print("✅ License is active, all good")
      } else {
        print("❌ License is either revoked or expired")
      }
      ...
      completion(isValid)
    })
```
:exclamation: Video content unavailable screen will appear if you start Video Editor SDK with revoked or expired license.
<p align="center">
<img src="screenshots/screen_expired.png"  width="25%" height="auto">
</p>

The following [implementation](../Example/Example/ViewController.swift#L45) starts Video Editor from camera screen.
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

Video Editor can export multiple media files to meet your requirements.  
Create instance of ```ExportConfiguration``` and provide ```Array<ExportVideoConfiguration>``` where every ```ExportVideoConfiguration``` is a media file i.e. video or audio. 
Next, use ```BanubaVideoEditor.export()``` method and pass instance of ```ExportConfiguration``` to start export.
Please check out [export implementation](../Example/Example/ViewController.swift#L250) in the sample.  

Learn [Export integration guide](https://docs.banuba.com/ve-pe-sdk/docs/ios/guide_export) to know more about exporting media content features.

## Localization

Add [Localized Strings](../Example/Example/en.lproj/Localizable.strings) file with English localization to the project.

## Advanced integration

Explore [advanced setup and customization](https://docs.banuba.com/ve-pe-sdk/docs/ios/adv-integration-overview/) in our documentation.