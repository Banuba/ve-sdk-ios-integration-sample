# FAQ  
This page is aimed to explain the most frequent technical questions asked while integrating our SDK.

### 1. I want to start and stop video recording by short click.  
The user has to keep pressing recording button to record new video by default. Video recording stops when the user releases finger from recording button.  

Please set captureButtonMode property of RecorderConfiguration entity to .video to allow the user to start and stop recording new video by short click.

``` json
 var config = VideoEditorConfig()
 config.recorderConfiguration.captureButtonMode = .video
```
