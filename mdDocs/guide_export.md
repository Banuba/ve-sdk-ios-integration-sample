# Export guide

- [Overview](#Overview)
- [Video codecs](#Video-codecs)
- [Video quality](#Video-quality)
- [Export storage](#Export-storage)
- [Implement export flow](#Implement-export-flow)
- [Handle export result](#Handle-export-result)
- [Progress screen](#Progress-screen)
- [Add watermark](#Add-watermark)
- [Export GIF preview](#Export-GIF-preview)
- [Get audio used in export](#Get-audio-used-in-export)
- [Export metadata analytics](#Export-metadata-analytics)

## Overview
You can export a number of media files i.e. video and audio with various resolutions and other configurations using.
Video Editor export video as ```.mp4``` file.

:exclamation: Important  
Export is a very heavy computational task that takes time and the user has to wait.
Execution time depends on
1. Video duration - the longer video the longer execution time.
2. Number of video sources - the many sources the longer execution time.
3. Number of effects and their usage in video - the more effects and their usage the longer execution time.
4. Number of exported video - the more video and audio you want to export the longer execution time.
5. Device hardware - the most powerful devices can execute export much quicker.

Export supports only ```Foreground``` mode where the user has to wait on progress screen until processing is done.  
:exclamation: Important
```Background``` export is not allowed on iOS due to [iOS Restrictions](https://developer.apple.com/documentation/metal/gpu_devices_and_work_submission/preparing_your_metal_app_to_run_in_the_background)

Here is a screen that is shown in ```Foreground``` mode.
<p align="center">
<img src="screenshots/export_media_progress.png"  width="33%" height="33%">
</p>

## Video codecs
Video Editor supports video codec options:
1. ```HEVC``` - H265 codec. Enabled by **default**
2. ```AVC_PROFILES``` - H264 codec with High Profile

You can change video codec for export by using ```ExportVideoConfiguration.useHEVCCodecIfPossible``` property. 
In this example, the H264 is set in [VideoEditorModule](../Example/Example/VideoEditorModule.swift#L26).

```diff
    let exportConfiguration = ExportVideoConfiguration(
          fileURL: destFile,
          quality: .auto,
+          useHEVCCodecIfPossible: false,
          watermarkConfiguration: watermarkConfiguration
        )
```

## Video quality

| 360p(360x640) | 480p(480x854) | QHD540(540x960) | HD(720x1280) | FHD(1080x1920) | QHD(1440x2560) | UHD(2160x3840) |
|----|---------------|-----------------|--------------|----------------|----------------|----------------|
| 1000  kb/s    | 2500 kb/s     | 3000  kb/s      | 5000   kb/s  | 8000 kb/s      | 16000    kb/s  | 36000  kb/s    |

Video Editor has built-in feature for detecting device performance capabilities and finding optimal video quality params for export.
You can provide custom video resolution for exported video by using ```ExportVideoConfiguration.quality``` property.
```diff
  let hdExportConfiguration = ExportVideoConfiguration(
    fileURL: destFile,
+    quality: .videoConfiguration(ExportVideoInfo(resolution: .hd1280x720, useHEVCCodecIfPossible: true)),
    useHEVCCodecIfPossible: true,
    watermarkConfiguration: watermarkConfiguration
)
```

## Export storage
Video Editor export method requires file destination where exported video will be stored.
First, create destination file
```swift
let manager = FileManager.default
let destFile = manager.temporaryDirectory.appendingPathComponent("tmp.mov")
```
and use it in ```ExportVideoConfiguration```
```diff
  let hdExportConfiguration = ExportVideoConfiguration(
+    fileURL: destFile,
    quality: .videoConfiguration(ExportVideoInfo(resolution: .hd1280x720, useHEVCCodecIfPossible: true)),
    useHEVCCodecIfPossible: true,
    watermarkConfiguration: watermarkConfiguration
)
```

## Implement export flow
You can create your own flow for exporting media files for your application.

Use ```ExportConfiguration``` to create instance with configurations that meet your product requirements.

Below is a sample that export 2 video files:
1. video with auto resolution without watermark
2. video with HD resolution with watermark

```swift
let watermarkConfiguration = WatermarkConfiguration(
    watermark: ImageConfiguration(imageName: "Common.Banuba.Watermark"),
    size: CGSize(width: 204, height: 52),
    sharedOffset: 20,
    position: .rightBottom
)
        
let autoExportConfiguration = ExportVideoConfiguration(
    fileURL: destFile1,
    quality: .auto,
    useHEVCCodecIfPossible: true,
    watermarkConfiguration: nil
)

let hdExportConfiguration = ExportVideoConfiguration(
    fileURL: destFile2,
    quality: .videoConfiguration(ExportVideoInfo(resolution: .hd1280x720, useHEVCCodecIfPossible: true)),
    useHEVCCodecIfPossible: true,
    watermarkConfiguration: watermarkConfiguration
)
        
let exportConfig = ExportConfiguration(
    videoConfigurations: [autoExportConfiguration, hdExportConfiguration],
    isCoverEnabled: true,
    gifSettings: nil
)
```

## Handle export result
IN PROGRESS
```swift
videoEditorSDK?.export(
      using: exportConfiguration,
      exportProgress: { progress in
        DispatchQueue.main.async {
          // Export is in progress. You can show progress view 
          ...
        }
      },
      completion: { [weak self] success, error, exportCoverImages in
      DispatchQueue.main.async {
        // Hide progress view
        progressViewController.dismiss(animated: true) {
          // Clear video editor session data
          self?.videoEditorSDK?.clearSessionData()
          if success {
            /// If you want to play exported video
//          self.playVideoAtURL(videoURL)
            
            /// If you want to share exported video
            if let self = self, let config = self.videoEditorSDK?.currentConfiguration.sharingScreenConfiguration {
              BanubaVideoEditor.presentSharingViewController(
                from: self,
                configuration: config,
                mainVideoUrl: videoURL,
                videoUrls: [videoURL],
                previewImage: exportCoverImages?.coverImage ?? UIImage(),
                animated: true,
                completion: nil
              )
            }
          }
          self?.videoEditorSDK = nil
        }
      }
```

## Progress screen

```ProgressViewController``` is shown while exporting media files.

![img](screenshots/ProgressViewConfiguration.png)

You can change appearance of this screen by overriding these styles and resources.

```ProgressViewConfiguration``` has the following parameters

| Property |           Values           | Description |
| ------------- |:--------------------------:| :------------- |
| messageConfiguration |     TextConfiguration      | Setups configuration for message
| tooltipMessageConfiguration |     TextConfiguration      | Setups configuration for tooltip message
| cancelButtonTextConfiguration |  TextButtonConfiguration   | Setups cancel button text configuration
| cancelButtonBorderConfiguration | BorderButtonConfiguration  | Setups cancel button border configuration
| cancelButtonBackgroundConfiguration |  BackgroundConfiguration   | Setups cancel button background configuration
| backgroundConfiguration |  BackgroundConfiguration   | Background configuration
| backgroundViewBlurStyle |     UIBlurEffect.Style     | Background view blur style. Default is .dark
| progressBarColor |          UIColor           | Setups progress bar color
| progressBarHeight | CGFloat; Default ```4.0``` | Setups progress bar height
| progressBarCornerRadius | CGFloat; Default ```1.0``` | Setups progress bar corner radius
 

The following string resources are used however you can customize them.

| Key        |      Value      |   Description |
| ------------- | :----------- | :------------- |
| com.banuba.alert.progressView.disagreeButtonTitle | Cancel | Ability to cancel
| com.banuba.alert.progressView.exportingVideo | Exporting video | Exporting video message
| com.banuba.alert.progressView.tooltipMessage | Please, don't lock your screen or switch to other apps | Tooltip message for a user
| com.banuba.alert.progressView.exportVideoInterrupted | Export interrupted | Message about error interrupting export process


## Add watermark
:exclamation: Important  
Watermark is not added to exported video by default.

You can use your custom watermark for a video. First, create instance of ```WatermarkConfiguration``` to
```swift
    let watermarkConfiguration = WatermarkConfiguration(
         watermark: ImageConfiguration(imageName: "Common.Banuba.Watermark"),
         size: CGSize(width: 204, height: 52),
         sharedOffset: 20,
         position: .rightBottom)
```
where ```position``` is used where for locating watermark image in a video
```swfit
     public enum WatermarkPosition {
            case leftTop
            case leftBottom
            case rightTop
            case rightBottom
    }
```
Next, set ```watermarkConfiguration``` to every instance of ```ExportVideoConfiguration``` where you want to add watermark 
in [VideoEditorModule](../Example/Example/VideoEditorModule.swift#L30).
```diff
    let hdExportConfiguration = ExportVideoConfiguration(
          fileURL: destFile,
          quality: .hd1280x720,
          useHEVCCodecIfPossible: true,
+          watermarkConfiguration: watermarkConfiguration
    )
```

## Export GIF preview
Video Editor allows to export preview of a video as a GIF file.  
Instance of ```GifSettings``` is required in ```ExportConfiguration``` to export  preview 
in export. You can specify this property in [VideoEditorModule](../Example/Example/VideoEditorModule.swift#L43)

```diff
 let exportConfig = ExportConfiguration(
    videoConfigurations: [exportConfiguration],
    isCoverEnabled: true,
+    gifSettings: GifSettings(duration: 0.3)
 )
```

## Get audio used in export
IN PROGRESS...
You can get all audio used in exported video when export finished successfully.  

There are 2 options to export audio file
1. Using ```BanubaVideoEditor.exportAudio()``` method
2. Using ```ExportVideoConfiguration``` by passing ```audioSettings```

## Export metadata analytics
Video Editor generates simple metadata analytics while exporting media content that you can use to analyze what media content your users make.
 
Metadata is a JSON string and can be once export finishes successfully.
```swift
let metadataJson: String? = videoEditorSDK?.metadata?.analyticsMetadataJSON
```
Sample JSON
```JSON
{
  "export_success": true, // defines if the export finished succesffully
  "aspect_ratio": "original", // aspect ration used in exported video
  "video_resolutions": ["1080x1920"], // list of video resolutions used in export
  "camera_effects": [], // list of effects of features used on camera screen while recording video
  "ppt_effects": {
    "visual": 2, // num of visual effects i.e. Glitch, VHS used in exported video
    "speed": 1, //  num of speed effects used in exported video
    "mask": 6, // num of AR masks used in exported video
    "color": 3, // num of color effects used in exported video
    "text": 1, // num of text effects used in exported video
    "sticker": 1, // num of sticker effects used in exported video
    "blur": 1 // num of blur effects used in exported video
  },
  "sources": {
    "camera": 0, // num of video sources recorded on camera screen(not PIP)
    "gallery": 1, // num of video sources selected in the gallery
    "pip": 0, // num of video recorded with PIP
    "slideshow": 0, // num of video exported as slideshow
    "audio": 0 // num of audi tracks
  },
  "export_duration": 12.645, // export processing duration
  "video_duration": 20.11, // exported video duration
  "video_count": 1, // num of exported video files
  "os_version": "11", // OS version
  "sdk_version": "1.26.6" // VE SDK version
}
```
