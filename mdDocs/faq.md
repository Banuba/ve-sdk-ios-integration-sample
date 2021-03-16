# FAQ  
This page is aimed to explain the most frequent technical questions asked while integrating our SDK.

### 1. I want to start and stop video recording by short click.  
The user has to keep pressing recording button to record new video by default. Video recording stops when the user releases finger from recording button.  

Please set captureButtonMode property of RecorderConfiguration entity to .video to allow the user to start and stop recording new video by short click.

``` json
 var config = VideoEditorConfig()
 config.recorderConfiguration.captureButtonMode = .video
```
### 2. I want to add AR Mask to the Video Editor (without AR Cloud backend)

 Technically AR Mask is a bulk of files within the folder.

 You should place AR Masks to the YourProject/bundleEffects/ directory inside the host project directory (main bundle). Be sure that AR mask directory has a **preview.png** file. It is used as an icon of the AR mask in the app.

 **Note** that the name of directory will be used as a title of the AR mask within the app. 
 
 **Note** "bundleEffects" is the name for the folder in which the masks should be located. Do not change the name of this folder so that our modules can find the resources they need. If the folder doesn't exist, then create it.

### 3. I want to start VideoEditor with a preselected audio track

To start video editor with preselected music track input MediaTrack instance as parameter to presentVideoEditor method. 

```
videoEditorSDK?.presentVideoEditor(
      from: YourViewController,
      animated: true,
      musicTrack: MediaTrack(...),
      completion: {...}
    )
```
### 4. I want to use VideoEditor several times from different entry points.

Before you want to use VideoEditor again you need to deinitialize your current editor instanse in your entry point class scope. You need to set 'yourVideoEditorSdkInstance' = nil after following funcs called.

```

// Video Editor Delegate implementation example
extension ViewController: BanubaVideoEditorDelegate {
  func videoEditorDone(_ videoEditor: BanubaVideoEditor) {
    // User finished editing sessoin, need to dismiss video editor and export video
    videoEditorSDK?.dismissVideoEditor(
      animated: true
    ) { [weak self] in
      self?.exportVideo(...) { ... in
         self?.'yourVideoEditorSdkInstance' = nil
      }
    }
  }
  
  func videoEditorDidCancel(
    _ videoEditor: BanubaVideoEditor
  ) {
    // User canceled editing sessoin, need to dismiss video editor
    videoEditorSDK?.dismissVideoEditor(
      animated: true,
      completion: {
        self?.'yourVideoEditorSdkInstance' = nil
      }
    )
  }
}

```

Next time you want open VideoEditor flow you need to create BanubaVideoEditor instance. 

For example on your tap button action:

```

@IBAction func videoEditorButtonTapped(...) {
   if 'yourVideoEditorSdkInstance' = nil {
      'yourVideoEditorSdkInstance' = BanubaVideoEditor(...)
   }
}

```
