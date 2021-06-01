# Banuba VideoEditor SDK
## Camera screen styles 

Here we set up the styles for the recording screen. These configs are for customizing action button icons, adjusting relative position and appearance of music, gallery, switching camera icons. Icons configurable using this style's custom attributes (for example, [icon_mask_on](/Example/Example/Extension/RecorderConfiguration.swift#L82) and [icon_mask_off](/Example/Example/Extension/RecorderConfiguration.swift#L81) setup drawings for icons associated with the applied AR mask effect)

   - [videoResolution: VideoResolutionConfiguration](/Example/Example/Extension/RecorderConfiguration.swift#L9)
   
  VideoResolutionConfiguration setups camera options for capturing and rendering video
  
  - [saveButton: SaveButtonConfiguration?](/Example/Example/Extension/RecorderConfiguration.swift#L41)
  
  SaveButtonConfiguration setups save button style

  - [backButton: BackButtonConfiguration](/Example/Example/Extension/RecorderConfiguration.swift#L52)
  
  BackButtonConfiguration setups back button style

  - [removeButtonImageName: String](/Example/Example/Extension/RecorderConfiguration.swift#L53)
  
  ImageName setups remove button UIImage
  
  - [сaptureButtonMode: CaptureButtonMode](/Example/Example/Extension/RecorderConfiguration.swift#L54)
  
  CaptureButtonMode contains two varieties:
  1. Mixed. Photo and video camera functionality.
  2. Video. Only photo camera functionality.
  
  - [recordButtonConfiguration: RecordButtonConfiguration](/Example/Example/Extension/RecorderConfiguration.swift#L55)
  
  RecordButtonConfiguration setups capture button style
  
  - [additionalEffectsButtons: [AdditionalEffectsButtonConfiguration]](/Example/Example/Extension/RecorderConfiguration.swift#L62)
  
   AdditionalEffectsButtonConfiguration array setups all of the camera screen control buttons' styles
  
  - [speedButton: SpeedButtonConfiguration](/Example/Example/Extension/RecorderConfiguration.swift#L111)
  
  SpeedButtonConfiguration setups speed button style
 
  - [galleryButton: RoundedButtonConfiguration](/Example/Example/Extension/RecorderConfiguration.swift#L129)
  
  RoundedButtonConfiguration setups gallery button style
  
  - [emptyGalleryImageName: String](/Example/Example/Extension/RecorderConfiguration.swift#L130)
 
  Image name setups gallery button image for empty gallery state
 
  - [timerConfiguration: TimerConfiguration](/Example/Example/Extension/RecorderConfiguration.swift#L132)
  
  TimerConfiguration setups timer functionality options
  
  - [timeLineConfiguration: TimeLineConfiguration](/Example/Example/Extension/RecorderConfiguration.swift#L141)
  
  TimeLineConfiguration setups progress bar style for sequences
  
  - [regularRecordButtonPosition: CGFloat](/Example/Example/Extension/RecorderConfiguration.swift#L144)
  
  Value setups capture button posttion according to the screen bottom
  
  - [recorderEffectsConfiguration: RecorderEffectsConfiguration](/Example/Example/Extension/RecorderConfiguration.swift#L145)
  
  RecorderEffectsConfiguration setups effects list style
  
  - [leftControlsBottomOffsetFromCaptureButton: CGFloat](/Example/Example/Extension/RecorderConfiguration.swift#L146)
  
  Value setups left controls posttions according to the capture button bottom
  
  - [leftControlsLeftOffset: CGFloat](/Example/Example/Extension/RecorderConfiguration.swift#L147)
  
  Value setups left controls posttions according to the capture button leading
  
  - [sequenceHeight: CGFloat](/Example/Example/Extension/RecorderConfiguration.swift#L148)
  
  Sequence bar height
  
  - [useHorizontalVersion: Bool](/Example/Example/Extension/RecorderConfiguration.swift#L149)
  
  How the buttons appears on the screen
  
  - [loopAudioWhileRecording: Bool](/Example/Example/Extension/RecorderConfiguration.swift#L150)
  
  Loop audio while recording video if music is selected
  
  - [takeAudioDurationAsMaximum: Bool](/Example/Example/Extension/RecorderConfiguration.swift#L151)
  
  This flag suggests that given audio duration setups maximum recording length
  
  - [isDynamicMusicTitle: Bool](/Example/Example/Extension/RecorderConfiguration.swift#L152)

   Spacing between button and circular timeline
    
   - [spacingBetweenButtonAndCircular: CGFloat](/Example/Example/Extension/RecorderConfiguration.swift#L153)
  
  Value provides the ability to dynamically changing the title of the song when new audio is adding
  
  - shouldUseImageEffect: Bool
  
  Value provides the ability for enabling animation for slideshow
  
  ![img](screenshots/RecorderConfiguration.png)
  
  You can change the position for the music button, for this you need:
  
  In the array with additionalEffectsButtons, for the button with the identifier **.sound**, set up the [position](/Example/Example/Extension/RecorderConfiguration.swift#L72) property
  
   - bottom
   - center
   - top
   
   <img src="screenshots/bottom.PNG" width="200" />  <img src="screenshots/center.PNG" width="200" />  <img src="screenshots/top.PNG" width="200" />
