# Banuba Video Editor SDK Integration sample for iOS

## Export video ways
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
  public func exportVideos(using configurations: [ExportVideoConfiguration], completion: (Bool,Error?)->Void)
  
  /// Export several configurable video with cover image
  /// - Parameters:
  ///   - configurations: contains configurations for exporting videos such as file url,
  ///    watermark and video quality
  ///   - completion: completion: (success, error, image), execute on the background thread.
  public func exportVideosWithCoverImage(using configurations: [ExportVideoConfiguration], completion: (_Bool, Error?, UIImage)->Void)
```  

## Export video customization
To setup export video parameters use ExportVideoConfiguration:
``` swift
/// Export Video Configuration
struct ExportVideoConfiguration {

  /// The video file URL.
  let fileURL: URL

  /// The export video quality.
  let quality: ExportQuality

  /// The watermark configuration. Optional.
  let watermarkConfiguration: WatermarkConfiguration?
}
```

  Export Quality has to configured by ExportQuality enumeration:
``` swift
  /*!
   Available export preset names:

   Export Preset Names for QuickTime Files of a Given Size:
    - AVAssetExportPreset640x480 - The output uses H.264 video compression at 640 x 480 pixels.
    - AVAssetExportPreset960x540 - The output uses H.264 video compression at 960 x 540 pixels.
    - AVAssetExportPreset1280x720 - The output uses H.264 video compression at 1280 x 720 pixels.
    - AVAssetExportPreset1920x1080 - The output uses H.264 video compression at 1920 x 1080 pixels.
    - AVAssetExportPreset3840x2160 - The output uses H.264 video compression at 3840 x 2160 pixels.
    - AVAssetExportPresetHEVC1920x1080 - The output uses HEVC video compression at 1920 x 1080 pixels.
    - AVAssetExportPresetHEVC3840x2160 - The output uses HEVC video compression at 3840 x 2160 pixels.
    - AVAssetExportPresetHEVC1920x1080WithAlpha - The output uses HEVC video compression at 1920 x 1080 pixels with alpha.
    - AVAssetExportPresetHEVC3840x2160WithAlpha - The output uses HEVC video compression at 3840 x 2160 pixels with alpha.
    - AVAssetExportPresetHEVCHighestQuality - The output uses the highest applicable video quality and HEVC video compression.
    - AVAssetExportPresetHEVCHighestQualityWithAlpha - The output uses the highest applicable video quality and HEVC video compression with alpha.
    - AVAssetExportPresetAppleProRes4444LPCM - A QuickTime movie with Apple ProRes 4444 video and LPCM audio.

   Export Preset Names for Device-Appropriate QuickTime Files:
    - AVAssetExportPresetLowQuality - A low-quality QuickTime file.
    - AVAssetExportPresetMediumQuality - A medium-quality QuickTime file.
    - AVAssetExportPresetHighestQuality - A high-quality QuickTime file.
  */

  /// Specify export video quality with AVAssetExportPreset name string.
  case preset(AVAssetExportPreset)

  /// Specify export video quality with configurable parameters.
  /// To more information look ExportVideoInfo params.

  case videoConfiguration(ExportVideoInfo)

  /// Let SDK select the most suitable quality for a device
  case auto
}

/// Create configurable export video parameters.
class ExportVideoInfo {
    ...

  /// ExportVideoInfo constructor.
  /// - Parameters:
  ///   - width: Specify output video width.
  ///   - height: Specify output video height.
  ///   - bitrate: Specify output video bitrate.
  ///   - frameRate: Specify specified output video frame rate.
  ///   - codecType: Specify the codec from AVVideoSettings like 'AVVideoCodecType.h264' etc. AVVideoCodecType.h264 is preferred as a hardware accelerated type
  ///   - scalingMode: Specify video scaling mode with required mode like 'AVVideoScalingModeResizeAspect'.
  init(
    width: Int,
    height: Int,
    bitrate: Int,
    frameRate: Int,
    codecType: AVVideoCodecType,
    scalingMode: String
  ) {
      ...
  }
}
```
  
## Configure video watermark
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