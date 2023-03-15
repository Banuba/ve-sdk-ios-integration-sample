# Banuba VideoEditor SDK
##  RecordButtonProvider

To implement your own custom record button you should create a new provider witсh returning your view. And put it to ```recordButtonProvider``` property of ```RecorderConfiguration```.
``` swift
/// The record button view provider.
public protocol RecordButtonProvider {
  func getButton() -> RecordButton
}
``` 
Then make a new class implements ``RecordButton`` protocol
``` swift
public protocol RecordButton: UIView {
  var delegate: RecordButtonDelegate? { get set }
  var configuration: RecordButtonConfiguration? { get set }
  func changeViewToIdleState()
  func changeViewToRecordingState()
  func reset()
}

public protocol RecordButtonDelegate: AnyObject {
   var captureButtonMode: CaptureButtonViewMode { get }
  func recordButtonDidTakePhoto(_ recordButton: RecordButton)
  func recordButtonDidCancelTakePhoto(_ recordButton: RecordButton)
  func recordButtonDidStartVideoRecording(_ recordButton: RecordButton)
  func recordButtonDidZoomingVideoRecording(_ recordButton: RecordButton, recognizer: UILongPressGestureRecognizer)
  func recordButtonDidStopVideoRecording(_ recordButton: RecordButton)
}
``` 