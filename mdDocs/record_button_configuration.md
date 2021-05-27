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
  /// Record button width
  public var width: CGFloat
  /// Record button height
  public var height: CGFloat
  /// Button resize scale for capture state
  public var recordingScale: CGFloat
}
```  