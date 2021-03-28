# Banuba VideoEditor SDK
## Camera config

| Property | Available values | Description |
| ------------- | :------------: | :------------- |
| **minimumDurationFromCamera** | Double > 0 | for the minimum recording duration *in seconds* that is allowed to proceed with Editor screen (i.e. 3.0 for 3 seconds)
| **maximumVideoDuration** | Double > 0 | for the maximum video duration *in seconds* available to record on the camera (i.e. 60.0 for 1 minute)
| **minimumDurationFromGallery** | Double > 0 | for the maximum video duration *in seconds*  available to Duration video from Gallery (i.e. 3.0 for 3 seconds)
| **minimumTrimmedPartDuration** | Double > 0 | for the maximum video duration *in seconds*  available to video part minimum duration at trimmer (i.e. 2.0 for 2 seconds)
| **isDefaultFrontCamera** | true/false | defines which camera will open by default on your device(*true* means the front camera opens by default, *false* means the main camera opens by default
| **captureButtonMode** | .video/.mixed | defines if it is available to capture photos on the camera (*.mixed* means that by tap on the record button the photo will be created, and to make a video recording you should long press the record button, *.video* means that by tap on the record button the video recording starts)
| **loopAudioWhileRecording** | true/false | defines whether to loop the selected track during video recording (*true* means that the track will be repeated while recording is in progress, *false* means that the track will play once)
| **takeAudioDurationAsMaximum** | true/false | determines what maximum recording duration to take if a track is installed (*true* set the maximum duration equal to the duration of the selected track, *false* take the maximum recording duration from ***maximumVideoDuration***
| **isMuteCameraAudioEnabled** | true/false | setups the mute icon on the camera overlay and possibility to make video recording without capturing sound
| **useHEVCCodecIfPossible** | true/false | intermediate video will be encoded using the HEVC (H.265) encoder if available on the current device.
