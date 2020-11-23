# Banuba VideoEditor SDK
## Camera screen styles  

   - [videoResolution: VideoResolutionConfiguration]()
   
  VideoResolutionConfiguration setups camera options for capturing and rendering video
  
  - [saveButton: SaveButtonConfiguration?]()
  
  SaveButtonConfiguration setups save button style

  - [backButton: BackButtonConfiguration]()
  
  BackButtonConfiguration setups back button style

  - [removeButtonImageName: String]()
  
  ImageName setups remove button UIImage
  
  - [сaptureButtonMode: CaptureButtonMode]()
  
  CaptureButtonMode contains two varieties:
  1. Mixed. Photo and video camera functionality.
  2. Video. Only photo camera functionality.
  
  - [recordButtonConfiguration: RecordButtonConfiguration]()
  
  RecordButtonConfiguration setups capture button style
  
  - [recordButtonProvider: VideoEditorCaptureButtonProvider?]()
  
  VideoEditorCaptureButtonProvider provides access to the possibility for creating capture button
  
  - [additionalEffectsButtons: [AdditionalEffectsButtonConfiguration]]()
  
   AdditionalEffectsButtonConfiguration array setups all of the camera screen control buttons' styles
  
  - [speedButton: SpeedButtonConfiguration]()
  
  SpeedButtonConfiguration setups speed button style
 
  - [galleryButton: RoundedButtonConfiguration]()
  
  RoundedButtonConfiguration setups gallery button style
  
  - [emptyGalleryImageName: String]()
  
  Image name setups gallery button image for empty gallery state
 
  - [timerConfiguration: TimerConfiguration]()
  
  TimerConfiguration setups timer functionality options
  
  - [timeLineConfiguration: TimeLineConfiguration]()
  
  TimeLineConfiguration setups progress bar style for sequences
  
  - [scrollBarConfiguration: ScrollBarConfiguration]()
  
  ScrollBarConfiguration setups bottom scroll bar style
  
  - [regularRecordButtonPosition: CGFloat]()
  
  Value setups capture button posttion according to the screen bottom
  
  - [recorderEffectsConfiguration: RecorderEffectsConfiguration]()
  
  RecorderEffectsConfiguration setups effects list style
  
  - [leftControlsBottomOffsetFromCaptureButton: CGFloat]()
  
  Value setups left controls posttions according to the capture button bottom
  
  - [leftControlsLeftOffset: CGFloat]()
  
  Value setups left controls posttions according to the capture button leading
  
  - [sequenceHeight: CGFloat]()
  
  Sequence bar height
  
  - [useHorizontalVersion: Bool]()
  
  How the buttons appears on the screen
  
  - [loopAudioWhileRecording: Bool]()
  
  Loop audio while recording video if music is selected
  
  - [takeAudioDurationAsMaximum: Bool]()
  
  This flag suggests that given audio duration setups maximum recording length
  
  - [isDynamicMusicTitle: Bool]()
  
  Value provides the ability to dynamically changing the title of the song when new audio is adding
