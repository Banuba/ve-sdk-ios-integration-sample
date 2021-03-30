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

Before you want to use VideoEditor again you need to deinitialize your current editor instanse in your [entry point class scope](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/d9733e78a6a752dd8fad849f6aa6d5553eb07f56/Example/Example/ViewController.swift#L675). You need to set 'yourVideoEditorSdkInstance' = nil after following funcs called([done](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/d9733e78a6a752dd8fad849f6aa6d5553eb07f56/Example/Example/ViewController.swift#L660) and [cancel](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/d9733e78a6a752dd8fad849f6aa6d5553eb07f56/Example/Example/ViewController.swift#L678)).

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

Use the following approach if you want to [create BanubaVideoEditor instance](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/d9733e78a6a752dd8fad849f6aa6d5553eb07f56/Example/Example/ViewController.swift#L42) again. 

For example on your tap button action:

```

@IBAction func videoEditorButtonTapped(...) {
   if 'yourVideoEditorSdkInstance' = nil {
      'yourVideoEditorSdkInstance' = BanubaVideoEditor(...)
   }
}

```

### 5. I want to add color filters

Color filters (luts) are special graphic files placed into **luts** directory inside the host project folder.

To add your own color filter icon you should place it into **assets** folder that will be used as an icon for this particular color effect within the list of effects.

The name of the icon resource must be **the same** as the graphic file within luts directory.

As an example, check out how the black-and-white color filter is added: 

[**Here**](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/luts/CF01.png) is a graphic file named C1.png within luts directory that allows to achieve black-and-white picture

[**Here**](https://github.com/Banuba/ve-sdk-ios-integration-sample/tree/main/Example/Example/Assets.xcassets/Filters%20Preview/CF01_preview.imageset) is an appropriate icon named CF01_preview.imageset within drawable resource directory that is used as an icon within the list of effects

### 6. I want to enabled slideshow animation 

To be able to turn off slideshow animation use following property of RecorderConfiguration and CombinedGalleryConfiguration entities.

```
let videoEditorConfig = VideoEditorConfig()

videoEditorConfig.recorderConfiguration.shouldUseImageEffect = true
videoEditorConfig.combinedGalleryConfiguration.shouldUseImageEffect = true

```
### 7. I want to change cursor color

All you need is just to set your color into **cursorColor: UIColor** parameter in MainOverlayViewControllerConfig entity.

Default flag is false.
