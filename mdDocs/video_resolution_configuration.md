# Export video functionality

### Using funcs with ExportVideoConfiguration entity you could specify resolution for exported video. 

Available resolutions:
- 360p
- 480p
- 720p
- 1080p

```
    /// Export video with default 1280x720 (or 1920x1080/480x854 on required devices) resolution
    /// - Parameters:
    ///   - fileUrl: url where exported video should be stored.
    ///   - completion: completion: (success, error), execute on background thread.
    public func exportVideo(
      fileURL: URL,
      completion: @escaping (Bool, Error?) -> Void
    )

    /// Export video with default 1280x720 (or 1920x1080/480x854 on required devices) resolution and cover image
    /// - Parameters:
    ///   - fileUrl: url where exported video should be stored.
    ///   - completion: completion: (success, error, image), execute on background thread.
    public func exportVideoWithCoverImage(
      fileURL: URL,
      completion: @escaping (Bool, Error?, UIImage) -> Void
    )

    /// Export several configurable video
    /// - Parameters:
    ///   - configurations: contains configurations for exporting videos such as file url,
    ///    watermark and video quality
    ///   - completion: completion: (success, error), execute on background thread.
    public func exportVideos(
      using configurations: [ExportVideoConfiguration],
      completion: @escaping (_ success: Bool, _ error: Error?) -> Void
    )

    /// Export several configurable video with cover image
    /// - Parameters:
    ///   - configurations: contains configurations for exporting videos such as file url,
    ///    watermark and video quality
    ///   - completion: completion: (success, error, image), execute on background thread.
    public func exportVideosWithCoverImage(
      using configurations: [ExportVideoConfiguration],
      completion: @escaping ((_ success: Bool, _ error: Error?, _ image: UIImage) -> Void)
    )
```
