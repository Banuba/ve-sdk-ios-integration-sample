# Export flow

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

An example of this controller implementation is in the [sample](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/ViewController.swift#L200).

You just need to transfer the [URL](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/ViewController.swift#L167) of the exported video there.
