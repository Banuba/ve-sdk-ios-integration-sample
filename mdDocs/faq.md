# FAQ  

These are the answers to the most common questions asked about our SDK.

### 1. How do I start/stop recording with a tap?
  
By default, the user must hold the “record” button to film and release it to stop filming. 

To change that, set the **captureButtonMode** property of the RecorderConfiguration entity to .video.

``` json
 var config = VideoEditorConfig()
 config.recorderConfiguration.captureButtonMode = .video
```

### 2.How do I add an AR mask to the app (without AR cloud)

If you don’t want to pull the masks from the backend, you can include them in the app itself. 

A mask is a bundle of files within a specific folder in the YourProject/bundleEffects/ directory. The preview.png file in the filter folder is used as an icon within the app, and the name of the directory is also the name of the mask.  

 **Note** Please, don’t change the name of the bundleEffects folder, otherwise, the app will not work. If it doesn’t exist already, create it manually.

### 3. How do I start the Video Editor with a preselected audio track?

To do so, add the MediaTrack instance as a parameter to the presentVideoEditor method.

```
videoEditorSDK?.presentVideoEditor(
      from: YourViewController,
      animated: true,
      musicTrack: MediaTrack(...),
      completion: {...}
    )
```

### 4. How do I use the Video Editor several times from different entry points?

Before you want to use VideoEditor again, you need to deinitialize your current editor instance in your [entry point class scope](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/d9733e78a6a752dd8fad849f6aa6d5553eb07f56/Example/Example/ViewController.swift#L675). You need to set 'yourVideoEditorSdkInstance' = nil after following funcs called([done](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/d9733e78a6a752dd8fad849f6aa6d5553eb07f56/Example/Example/ViewController.swift#L660) and [cancel](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/d9733e78a6a752dd8fad849f6aa6d5553eb07f56/Example/Example/ViewController.swift#L678)).

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

### 5. How do I add a color filter (LUT)?

Color filters (LUTs) are special graphic files placed into the /luts directory inside the host project folder.

To add your own icon that will be used to represent this particular effect in the list, you should place it into the /assets folder.

The name of the icon resource must be the same as the graphic file within the /luts directory.
As an example, check out how the black-and-white color filter is added:

[Here](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/luts/CF01.png) is a graphic file named C1.png within the /luts directory. It allows to turn the picture black-and-white.

[Here](https://github.com/Banuba/ve-sdk-ios-integration-sample/tree/main/Example/Example/Assets.xcassets/Filters%20Preview/CF01_preview.imageset) is an appropriate icon named CF01_preview.imageset within the drawable resource directory that is used as an icon within the list of effects

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

### 8. I want to change progress bar position

Progress bar position contains two types of layout:
- top
- bottom (**by default**)

To change progress bar position you need to modify **progressBarPosition** property of **RecorderConfiguration** entity.

```

let videoEditorConfig = VideoEditorConfig()
videoEditorConfig.recorderConfiguration.progressBarPosition = .top

```
