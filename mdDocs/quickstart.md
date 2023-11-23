# Quickstart Guide

- [Prerequisites](#Prerequisites)
- [Concepts](#Concepts)
- [Add dependencies](#Add-dependencies)
- [Add resources](#Add-resources)
- [Add module](#Add-module)
- [Implement export](#Implement-export)
- [Launch](#Launch)
- [Advanced integration](#Advanced-integration)
- [Dependencies and licenses](#Dependencies-and-licenses)
- [Releases](#Releases)

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

You can, however, [ask](https://www.banuba.com/faq/kb-tickets/new) us to customize the mobile video editor UI as a separate contract.

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

## Latest Releases  
[1.30.2](https://vebanuba.notion.site/1-30-2-a0ec2ae1eeea42a59c629834f6ec6f7a)  
[1.30.1](https://vebanuba.notion.site/1-30-1-6b90d19271b741b0b8353f7a1b92d061)  
[1.30.0](https://vebanuba.notion.site/1-30-0-35e745d478b648199e38e86c432486e4)  
[1.29.2](https://vebanuba.notion.site/1-29-2-d44fcd46e81c4916a13bc5fc3eb5fb4b)  
[1.29.1](https://vebanuba.notion.site/1-29-1-e06a110ac0314b2e937adbb5621efee0)  
[1.29.0](https://vebanuba.notion.site/1-29-0-95c88eeb25074e19ba9b11796e845432)  
[1.28.5](https://vebanuba.notion.site/1-28-5-d64de053cf1b44ea81adb88c29b9996a)  
[1.28.0](https://vebanuba.notion.site/1-28-0-ac7b1a919eb7443ea7caef9eae22d2a3)  
[1.27.0](https://vebanuba.notion.site/1-27-0-591e38e8166c4833b96f96db05ead258)  
[1.26.9](https://vebanuba.notion.site/1-26-9-73460541f0c1414ab67073e07b866e4f)  
[1.26.8](https://vebanuba.notion.site/1-26-8-9ca76f004afc4d38a481ba8e44826713)  
[1.26.7](https://vebanuba.notion.site/1-26-7-8653533d4ce64203ad04159d942212f6)  
[1.26.6](https://vebanuba.notion.site/1-26-6-4c17e9a765934c2ba7da3440b1cfbe8b)  
[1.26.5](https://vebanuba.notion.site/1-26-5-91785d18a6c64c6e86dc48ca06e3d458)  
[1.26.4](https://vebanuba.notion.site/1-26-4-294c72f4be5944938a4e506c65435333)  
[1.26.3](https://vebanuba.notion.site/1-26-3-8c4fb0d732eb4f2582b3aaeab28ef399)  
[1.26.2](https://vebanuba.notion.site/1-26-2-2aa271695c974ac7b90799a0b2a108d9)   
[1.26.1](https://vebanuba.notion.site/1-26-1-0edacf053a88499cbb51e6f065274dd3)   
[1.26.0](https://vebanuba.notion.site/1-26-0-5e65daee7e8c41e2bebbf4d8a50e1cc4)    
