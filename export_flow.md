# Export flow

Please consider the following examples to configure your export flow.
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

## Export video configuration
Below is the sample with available configurations for export video.
``` swift
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
        case ld360
        case md480
        case hd720
        case fullHd1080
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