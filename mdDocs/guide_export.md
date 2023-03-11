# Export flow

## Export video quality params
Video Editor SDK classifies every device by its performance capabilities and uses the most suitable quality params for the exported video.

Nevertheless it is possible to customize it with `ExportVideoConfiguration`. Just put a required video quality into `ExportVideoInfo(resolution)` constructor. To be able to use your own quality parametrs please follow this [guide](video_resolution_configuration.md).

See the **default bitrate (kbps)** for exported video (without audio) in the table below:
| 360p(360 x 640) | 480p(480 x 854) | 540p(540 x 960) | HD(720 x 1280) | FHD(1080 x 1920) |
| --------------- | --------------- | ---------------- | -------------- | ---------------- |
|              800|             2000|              2000|            4000|              6400|




Please consider the following examples to configure your export flow.
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

## Export video configuration
Below is the sample with available configurations for export video.
``` swift
public struct ExportConfiguration {
    /// Export Video Configuration
    public let videoConfigurations: [ExportVideoConfiguration]
    /// Is cover image/gif exporting enabled
    public let isCoverEnabled: Bool
    /// The configuration for gif
    public var gifSettings: GifSettings?
    /// ExportVideoConfiguration constructor.
    public init(
      videoConfigurations: [ExportVideoConfiguration],
      isCoverEnabled: Bool,
      gifSettings: GifSettings?
    )
}

/// Export Video Configuration
public struct ExportVideoConfiguration {
  /// The video file URL.
  public let fileURL: URL
  /// The export video quality.
  public let quality: ExportQuality
  /// The watermark configuration. Optional.
  public let watermarkConfiguration: WatermarkConfiguration?
  /// Use HEVC (H.265) encoder for the exported video if it is available on the current device. Better quality, low size, better performance
  public let useHEVCCodecIfPossible: Bool
}
```
  :exclamation: **We recommend using standard resolution, shush is set up by default. We understand your requirements might be different, so we give you an option to manage the resolution.
Doing that make sure the devices that exports video does support such a resolution. On a low device high resolution may cause crashes and freezes.**
  
  Export Quality has to configured by ExportQuality enumeration:
``` swift
/// Export video quality.
public enum ExportQuality {
    /// Specify export video quality with configurable parameters.
    /// To more information look ExportVideoInfo params.
    case videoConfiguration(VideoEditor.ExportVideoInfo)
    /// Let SDK select the most suitable quality for a device.
    case auto
}
/// Create configurable export video parameters.
public class ExportVideoInfo {
    /// Specifid quality for exporting video.
    public enum Resolution : String {
      /// 1440p 
      case qhd1440
      /// 1080p
      case fullHd1080
      /// 720p
      case hd720
      /// 540p
      case md540
      /// 480p
      case md480
      /// 360p
      case ld360
      /// original
      case original
    }

    /// Specified video quality.
    public let resolution: VideoEditor.ExportVideoInfo.Resolution

    /// ExportVideoInfo constructor.
    /// - Parameters:
    ///   - resolution: Specify quality for exporting video.
    ///   - useHEVCCodecIfPossible: Use HEVC (H.265) encoder if it is available on the current device
    public init(
      resolution: VideoEditor.ExportVideoInfo.Resolution, useHEVCCodecIfPossible: Bool
    )
}
```
  
## Configure a watermark on exported video
``` swift
/// The watermark configuration.
public struct WatermarkConfiguration {
  /// The watermark image configuration
  public var watermark: ImageConfiguration
  /// The watermark size configuration.
  public var size: CGSize
  /// The watermark offset from edges.
  public var sharedOffset: CGFloat
  /// The watermark position.
  public var position: WatermarkPosition
  /// The watermark possible positions.
  public enum WatermarkPosition {
    case leftTop
    case leftBottom
    case rightTop
    case rightBottom
  }

  ...

}
```

## Save video to gallery

To save the exported video to the gallery or share it, use ```UIActivityViewController```.
You can learn more about this controller in [apple documentation](https://developer.apple.com/documentation/uikit/uiactivityviewcontroller).

An example of this controller implementation is in the [sample](../Example/Example/ViewController.swift#L200).

You just need to transfer the [URL](../Example/Example/ViewController.swift#L167) of the exported video there.


### Add watermark

You can add a branded image that would appear on videos that users export.

To do so, create and configure the WatermarkConfiguration structure, then add it to the ExportVideoConfiguration entity.

See this [example](/Example/Example/ViewController.swift#L184) for details.

## Export metadata Analytics

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
