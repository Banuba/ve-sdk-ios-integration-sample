## First of all make sure you are using the correct parameters for ExportVideoInfo entity initializer.

```
 /// ExportVideoInfo constructor.
  /// - Parameters:
  ///   - width: Specify output video width.
  ///   - height: Specify output video height.
  ///   - bitrate: Specify output video bitrate.
  ///   - frameRate: Specify specified output video frame rate.
  ///   - codecType: Specify the codec from AVVideoSettings like 'AVVideoCodecType.h264' etc. AVVideoCodecType.h264 is preferred as a hardware accelerated type
  ///   - scalingMode: Specify video scaling mode with required mode like 'AVVideoScalingModeResizeAspect'
```

## Implement your ExportVideoInfo instance.

```
 let exportVideoInfo = ExportVideoInfo(
      width: 640,
      height: 360,
      bitrate: 1000000,
      frameRate: 30,
      codecType: AVVideoCodecType.h264,
      scalingMode: AVVideoScalingModeResizeAspect
 )
 ```
 ## Create ExportVideoConfiguration with following properties.
 
 ```
 /// The video file URL.
  public let fileURL: URL
  /// The export video quality.
  public let quality: ExportQuality
  /// The watermark configuration. Optional.
  public let watermarkConfiguration: WatermarkConfiguration?
  ```
 
```
  let exportVideoConfigurations: [ExportVideoConfiguration] = [
      ExportVideoConfiguration(
        fileURL: firstFileURL,
        quality: .auto,
        watermarkConfiguration: watermarkConfiguration
      ),
      ExportVideoConfiguration(
        fileURL: secondFileURL,
        quality: .videoConfiguration(exportVideoInfo),
        watermarkConfiguration: watermarkConfiguration
      )
    ]
 ```

## Use our BanubaVideoEditor API func

```
/// Export several configurable video with cover image
  /// - Parameters:
  ///   - configurations: contains configurations for exporting videos such as file url,
  ///    watermark and video quality
  ///   - completion: completion: (success, error, image), execute on background thread.
  public func exportVideosWithCoverImage(
    using configurations: [ExportVideoConfiguration],
    completion: @escaping ((_ success: Bool, _ error: Error?, _ image: UIImage)->Void)
  )
```


