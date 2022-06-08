# Export video functionality

### Using funcs with ExportVideoConfiguration entity you could specify resolution for exported video. 

Available resolutions:
- 360p
- 480p
- 720p
- 1080p
- 1440p

``` swift
    /// Export video with default 1280x720 (or 1920x1080/480x854 on required devices) resolution
    /// - Parameters:
    ///   - fileURL: destination file url.
    ///   - exportVideoInfo: Describes exporting video editor params.
    ///   - watermarkFilterModel: Watermark effect.
    ///   - completion: completion creation - (isSuccess,  error)
    public func exportVideo(
      to fileURL: URL,
      using exportVideoInfo: ExportVideoInfo,
      watermarkFilterModel: VideoEditorFilterModel?,
      completion: ((_ isSuccess: Bool, _ error: Error?)-> Void)?
    )
```
