# Banuba VideoEditor SDK
##  RecordButtonConfiguration

``` swift
/// The Record button configuration
public struct RecordButtonConfiguration {
  /// Color setups record button round color for idle state
  public var idleStrokeColor: CGColor
  /// Color setups record button round color for capture state
  public var strokeColor: CGColor
  /// Colors setups record button gradient filling colors
  public var gradientColors: [CGColor]
  /// Round line width for idle state
  public var circularTimeLineIdleWidth: CGFloat
  /// Round line width for record state
  public var circularTimeLineCaptureWidth: CGFloat
  /// Image name setups core image for idle state
  public var normalImageName: String
  /// Image name setups core image for record state
  public var recordImageName: String
  /// Image name setups core image for photo state
  public var photoImageName: String
  /// Record button width
  public var width: CGFloat
  /// Record button height
  public var height: CGFloat
  /// Setup default color
  public var defaultColorButton: UIColor
  /// Setup color for video record state
  public var videoRecordColorButton: UIColor
  /// Setup color for take a photo state
  public var takePhotoColorButton: UIColor
  /// Setup full color for external circle
  public var externalCircleFullColor: CGColor
  /// Setup stroke color for external circle
  public var externalCircleStrokeColor: CGColor
}
```  
