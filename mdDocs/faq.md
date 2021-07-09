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

The name of the icon resource must be the same as the graphic file `ID` the / luts directory.

| Default image color filter | Name      | ID      |
| ---------- | ---------  | ----------- |
|<img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Filters%20Preview/glitch_preview.imageset/glitch-1.png" width="50"> | glitch | 101000
|  <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Filters%20Preview/instant_preview.imageset/instant-1.png" width="50"> | instant  | 101001
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Filters%20Preview/grunge_preview.imageset/grunge-1.png" width="50">  | grunge | 101002
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Filters%20Preview/retro_preview.imageset/retro-1.png" width="50">  |  retro | 101003
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Filters%20Preview/pinkvine_preview.imageset/pinkvine-1.png" width="50">  |  pinkvine | 101004
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Filters%20Preview/england_preview.imageset/england-1.png" width="50">  |  england | 101005
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Filters%20Preview/spark_preview.imageset/spark-1.png" width="50">  |  spark | 101006
|  <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Filters%20Preview/korben_preview.imageset/korben-1.png" width="50"> |  korben | 101007
|  <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Filters%20Preview/remy_preview.imageset/remy-1.png" width="50"> |  remy | 101008
|  <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Filters%20Preview/canada_preview.imageset/canada-1.png" width="50"> |  canada | 101009
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Filters%20Preview/sunny_preview.imageset/sunny-1.png" width="50">  |  sunny | 101010
|  <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Filters%20Preview/egypt_preview.imageset/egypt-1.png" width="50"> |  egypt | 101011
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Filters%20Preview/new_zeland_preview.imageset/new_zeland-1.png" width="50">  |  new_zeland | 101012
|  <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Filters%20Preview/chroma_preview.imageset/chroma-1.png" width="50"> |  chroma | 101013
|  <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Filters%20Preview/byers_preview.imageset/byers-1.png" width="50"> |  byers | 101014
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Filters%20Preview/lilac_preview.imageset/lilac-1.png" width="50">  |  lilac | 101015
|  <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Filters%20Preview/hyla_preview.imageset/hyla-1.png" width="50"> |  hyla | 101016
|  <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Filters%20Preview/bubblegum_preview.imageset/bubblegum-1.png" width="50"> |  bubblegum | 101017
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Filters%20Preview/vinyl_preview.imageset/vinyl-1.png" width="50">  | vinyl | 101018
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Filters%20Preview/lux_preview.imageset/lux-1.png" width="50">  |  lux | 101019
| <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Filters%20Preview/japan_preview.imageset/japan-1.png" width="50">  |  japan | 101020
|  <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Filters%20Preview/sunset_preview.imageset/sunset-1.png" width="50"> |  sunset | 101021
|  <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Filters%20Preview/neon_preview.imageset/neon-1.png" width="50"> |  neon | 101022
|  <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Filters%20Preview/chile_preview.imageset/chile-1.png" width="50"> |  chile | 101023
|  <img src="https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/Filters%20Preview/norway_preview.imageset/norway-1.png" width="50"> |  norway | 101024

If you want to change the name, you need to specify the new name in the string resources:
```swift
/* glitch filter name */
"com.banuba.filter.name.lux" = "lux";
/* remy filter name */
"com.banuba.filter.name.remy" = "remy";
/* hyla filter name */
"com.banuba.filter.name.hyla" = "hyla";
/* neon filter name */
"com.banuba.filter.name.neon" = "neon";
/* retro filter name */
"com.banuba.filter.name.retro" = "retro";
/* sunny filter name */
"com.banuba.filter.name.sunny" = "sunny";
/* egypt filter name */
"com.banuba.filter.name.egypt" = "egypt";
/* spark filter name */
"com.banuba.filter.name.spark" = "spark";
/* byers filter name */
"com.banuba.filter.name.byers" = "byers";
/* lilac filter name */
"com.banuba.filter.name.lilac" = "lilac";
/* vinyl filter name */
"com.banuba.filter.name.vinyl" = "vinyl";
/* japan filter name */
"com.banuba.filter.name.japan" = "japan";
/* chile filter name */
"com.banuba.filter.name.chile" = "chile";
/* glitch filter name */
"com.banuba.filter.name.glitch" = "glitch";
/* grunge filter name */
"com.banuba.filter.name.grunge" = "grunge";
/* canada filter name */
"com.banuba.filter.name.canada" = "canada";
/* chroma filter name */
"com.banuba.filter.name.chroma" = "chroma";
/* norway filter name */
"com.banuba.filter.name.norway" = "norway";
/* korben filter name */
"com.banuba.filter.name.korben" = "korben";
/* sunset filter name */
"com.banuba.filter.name.sunset" = "sunset";
/* instant filter name */
"com.banuba.filter.name.instant" = "instant";
/* england filter name */
"com.banuba.filter.name.england" = "england";
/* pinkvine filter name */
"com.banuba.filter.name.pinkvine" = "pinkvine";
/* bubblegum filter name */
"com.banuba.filter.name.bubblegum" = "bubblegum";
/* new zeland filter name */
"com.banuba.filter.name.new_zeland" = "new_zeland";
```

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

### 9. How does video editor work when token expires?

[Token](https://github.com/Banuba/ve-sdk-android-integration-sample#token) provided by sales managers has an expiration term to protect Video Editor SDK from malicious access. When the token expires the following happens:
 - video resolution will be lowered to 360p on camera, after trimmer and after export
 - Banuba watermark is applied to every exported video

 Also [FaceAR SDK](https://docs.banuba.com/face-ar-sdk/overview/token_management) you may expect the following actions if the token expires:
 - on the first expired month a watermark with "Powered by Banuba" label will be added on the top of both recorded and exported videos
 - after the first month the camera screen will be blurred and a full-screen watermark will be displayed

 Please keep your licence up to date to avoid unwanted behavior.
 
 ### 10. Which buttons available if Face AR disabled?
 
 AdditionalEffectsButtons contains options set which describes buttons' identifiers. 
 
 Without Face AR you could use buttons with following identifiers. 
 
 **Camera Screen**:
 - sound
 - toggle
 - flashlight
 - timer
 - speed
 - muteSound
 
 **Postprocessing Screen**:
 - sticker
 - sound
 - text
 - effects
 - time
 - color

 ### 11. I want to change screens' layout.
 
 There are two screens which could be modified with additional layout:
 
 - Camera
 - Postprocessing

To be able to change layout you need to set **useHorizontalVersion** equals true. This properties are parts of RecorderConfiguration and EditorConfiguration entities.

### 12. I want to change music button position.

The music button consists of three positions:

  - bottom
  - center
  - top

<img src="screenshots/bottom.PNG" width="150" /> <img src="screenshots/center.PNG" width="150" /> <img src="screenshots/top.PNG" width="150" />


To be able to change the location of the button, you need to set the desired value in the array with additionalEffectsButtons, for the button with the identifier **.sound**, set up the [position](/Example/Example/Extension/RecorderConfiguration.swift#L72) property. 

### 13. How can I get a track name of the audio used in my video after export?
```swift
/// Video Editor main entity and entry point.
/// Can present and hide root view controller.
/// Has default export method.
public class BanubaVideoEditor {
/// Simple metadata of music composition settings
public var musicMetadata: MusicEditorMetadata? { get }
...
}
```
`MusicEditorMetadata` contains the array of `MusicEditorTrack` which contains the following fields: 

```swift
// MARK: - MusicEditorTrack
public struct MusicEditorTrack: Codable {
///Track URL
public var url: URL
///Track original URL
public var originalURL: URL
///Track title
public var title: String
///Track id
public var id: Int32
...
}
```
or if you want to know what track was played on the camera screen you can use:

```swift
/// Video Editor main entity and entry point.
/// Can present and hide root view controller.
/// Has default export method.
public class BanubaVideoEditor {
/// Music track which will be played on camera recording
public var musicTrack: MediaTrack? { get }
...
}
```

### 15. I want to check whether my token is expired.

Available from **'1.0.18'** version

```swift
  /// Check whether token is expired
  /// - Parameters:
  ///   - token: your token that you want to verify.
  public func checkTokenExpiration(
    token: String
  ) -> Bool 
```
For this you need to initialize `BanubaVideoEditor`and call the method `
checkTokenExpiration(token: token)`
, for example:
```swift
    let token: String = "Put token"
    let result: Bool = videoEditorSDK.checkTokenExpiration(token: token)
```

if you are using `BanubaTokenStorageSDK` here is a usage example:

```swift
self.loadToken { token in
      if let ve = self.videoEditorSDK {
        _ = ve.checkTokenExpiration(token: token)
      } else {
        self.createVideoEditorSDK {
          _ = self.videoEditorSDK?.checkTokenExpiration(token: token)
        }
      }
    }
```
