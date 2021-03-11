# Banuba VideoEditor SDK
##  RecordButtonProvider

To implement your own custom record button you should create a new provider witсh returning your view. And put it to [recordButtonProvider](mdDocs/camera_styles.md#L30) property.
``` swift
/// The record button view provider.
public protocol RecordButtonProvider {
  func getButton() -> RecordButton?
}
``` 
Then make a new class implements ``RecordButton`` protocol
``` swift
public protocol RecordButton: UIView {
  var delegate: RecordButtonDelegate? { get set }
  var configuration: RecordButtonConfiguration? { get set }
  func updateVideoRecordingProgress(_ captureProgress: Double)
  func changeViewToIdleState()
  func changeViewToCaptureState()
  func reset()
}

public protocol RecordButtonDelegate: AnyObject {
  func recordButtonDidTakePhoto(_ recordButton: RecordButton)
  func recordButtonDidStartVideoRecording(_ recordButton: RecordButton)
  func recordButtonDidStopVideoRecording(_ recordButton: RecordButton)
}
``` 

