# Quickstart Guide

> [!CAUTION]
> This documentation is deprecated and no longer updated.
> Please check out our [new website](https://docs.banuba.com/ve-pe-sdk/docs/ios/requirements) with latest documentation.

- [Prerequisites](#Prerequisites)
- [Concepts](#Concepts)
- [Add dependencies](#Add-dependencies)
- [Add resources](#Add-resources)
- [Add module](#Add-module)
- [Implement export](#Implement-export)
- [Launch](#Launch)
- [Advanced integration](#Advanced-integration)
- [Dependencies and licenses](#Dependencies-and-licenses)

## Prerequisites
Complete [Installation](../README.md#Installation) before to proceed.

## Concepts
- Export - the process of making video in video editor.
- Slideshow - the feature that allows to create short video from single or multiple images.
- PIP - short Picture-in-Picture feature.
- Trimmer - trimmer screen where the user can trim, merge, change aspects
- Editor - editor the screen where the user can manage effects and audio. Normally the next screen after trimmer.

## Add dependencies
There are 2 options to get iOS Video Editor SDK dependencies
1. [CocoaPods](https://cocoapods.org)
2. [SwiftPackageManager](https://developer.apple.com/documentation/swift_packages)

### SPM
Learn [SPM Getting Started Guide](https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app) if you are new in SPM.

The integration with SPM is in [spm branch](https://github.com/Banuba/ve-sdk-ios-integration-sample/tree/spm)

Complete the following steps to get Video Editor SDK dependencies using SPM.

1. Add a [spm link](https://github.com/Banuba/spm) to the collection of packages
2. Open ```App project```  and navigate to ```Swift Packages``` tab.
3. Click the ```plus``` button and type package collections repo url https://github.com/Banuba/spm.
4. Choose ```Exact Version``` release version and type newest SDK version.
5. Select the necessary modules in a list and click the ```Add Package``` button.

### CocoaPods
Learn [CocoaPods Getting Started Guide](https://guides.cocoapods.org/using/getting-started.html) if you are new in CocoaPods.

:exclamation: Important  
It is required to have CocoaPods version ```1.12.1``` or newer.
Please check your version ```pod --version``` and upgrade.

The List of required Video Editor dependencies is in [Podfile](../Example/Podfile).

Complete the following steps to get Video Editor SDK dependencies using CocoaPods.
1. Install CocoaPods using Homebrew
   ```sh
   brew install cocoapods 
   ```
2. Initialize pods in your project folder
   ```sh
   pod init
   ```
3. Install Video Editor SDK pods
   ```sh
   pod install --repo-update
   ```
4. Open ```Example.xcworkspace``` in Xcode and run the project.

## Add resources
Video Editor SDK uses a lot of resources required for running.  
Please make sure all these resources are provided in your project.
1. [luts](../Example/Example/luts) - the folder where all color effects are stored.
2. [ColorEffectsPreview](../Example/Example/Assets.xcassets/ColorEffectsPreview) - preview images of color effects
3. [Effects Preview](../Example/Example/Assets.xcassets/Effects%20Preview) - preview images of visual effects.
4. [Localized Strings](../Example/Example/en.lproj/Localizable.strings)

[Assets.xcassets](../Example/Example/Assets.xcassets) contains other visual resources i.e. icons that are used in 
video editor. These icons were added to the sample to customize default video editor icons.
Feel free to copy all resources from [Assets.xcassets](../Example/Example/Assets.xcassets) if they meet your requirements.

>:exclamation: **Note:** Default video editor icons will be used in case if you copy only [luts](../Example/Example/luts), [ColorEffectsPreview](../Example/Example/Assets.xcassets/ColorEffectsPreview),
[Effects Preview](../Example/Example/Assets.xcassets/Effects%20Preview), [Localized Strings](../Example/Example/en.lproj/Localizable.strings) resources.

## Add module
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

## Implement export
Video Editor can export multiple media files to meet your requirements.  
Create instance of ```ExportConfiguration``` and provide ```Array<ExportVideoConfiguration>``` where every ```ExportVideoConfiguration``` is a media file i.e. video or audio. 
Next, use ```BanubaVideoEditor.export()``` method and pass instance of ```ExportConfiguration``` to start export.
Please check out [export implementation](../Example/Example/ViewController.swift#L209) in the sample.  

Learn [Export integration guide](guide_export.md) to know more about exporting media content features.

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

The following [implementation](../Example/Example/ViewController.swift#L48) starts Video Editor from camera screen.
```swift
 let cameraLaunchConfig = VideoEditorLaunchConfig(
        entryPoint: .camera,
        hostController: self,
        musicTrack: nil, // Paste a music track as a track preset at the camera screen to record video with music
        animated: true
)

videoEditorModule.presentVideoEditor(with: cameraLaunchConfig)
```

Video Editor supports multiple launch methods described in [this guide](faq.md#Launch-methods).

## Advanced integration
Video editor has built in UI/UX experience and provides a number of customizations you can use to meet your requirements.

**AVAILABLE**  
:white_check_mark: Use your branded icons, colors, and text styles. [See details](faq.md#i-want-to-use-custom-icons)  
:white_check_mark: Localize and change text resources. Default locale is :us:  
:white_check_mark: Make content you want i.e. a number of video with different resolutions  and durations, an audio file. [See details](guide_export.md)  
:white_check_mark: Masks and filters order. [See details](faq.md#i-want-to-change-the-order-of-masks-video-effects-or-filters)

NOT AVAILABLE  
:x: Change layout  
:x: Change order of screens after entry point

You can, however, [ask](https://www.banuba.com/support) us to customize the mobile video editor UI as a separate contract.

Check out the list of [Frequently Asked Questions](faq.md) to know more about features customizations and if you are experiencing any issues with an integration.

## Dependencies and licenses
1. [Banuba Face AR SDK](https://www.banuba.com/facear-sdk/face-filters) ```Optional```.
2. Foundation
3. AVFoundation
4. UIKit
5. AVKit
6. CoreMedia
7. CoreVideo
8. CoreGraphics
9. Photos
10. MetalKit
11. SystemConfiguration
12. OSLog
13. MediaPlayer
14. Accelerate

[See all dependencies and licenses](3rd_party_licences.md)
