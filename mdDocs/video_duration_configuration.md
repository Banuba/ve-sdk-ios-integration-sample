# Export video functionality

### Video duration configuration

To customize recording video durations use **VideoEditorDurationConfig**:
```swift
/// The video duration configuration.
public struct VideoEditorDurationConfig {
  /// The video maximum duration
  /// Default is 60.0.
  public var maximumVideoDuration: TimeInterval
  /// The video minimum duration captured from a camera
  /// Default is 3.0.
  public var minimumDurationFromCamera: TimeInterval
  /// The video minimum duration from a gallery
  /// Default is 3.0.
  public var minimumDurationFromGallery: TimeInterval
  /// The video minimum duration
  /// Default is 3.0.
  public var minimumVideoDuration: TimeInterval
  /// The video part minimum duration at trimmer
  /// Default is 2.0.
  public var minimumTrimmedPartDuration: TimeInterval
}
```

### Example

```swift
var config = VideoEditorConfig()
// Reduce maximum video duration to 30 seconds
config.videoDurationConfiguration.maximumVideoDuration = 30.0
```