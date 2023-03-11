# Advanced integration

This guide is aimed to help you complete advanced integration of Video Editor SDK.

- [Face AR SDK and AR Cloud](#Face-AR-SDK-and-AR-Cloud)
- [Video recording](#Video-recording)
- [Passing Apple Store review](#Passing-Apple-Store-review)
- [Launch methods](#Launch-methods)

## Face AR SDK and AR Cloud
[Banuba Face AR SDK](https://www.banuba.com/facear-sdk/face-filters) is used in Video Editor for applying AR effects in 2 use cases:
1. Camera screen  
   The user can record video content with various AR effects.
2. Editor screen  
   The user can apply various AR effects on existing video.

Video Editor SDK has built in integration with Banuba AR Cloud - remote storage for Banuba AR effects.

Please follow [Face AR and AR Cloud integration guide](guide_far_arcloud.md) if you are interested in disabling Face AR,
integrating AR Cloud, managing AR effects and many more.

## Video recording
Video editor supports functionality allowing to record video using iOS camera. There are many features, configurations and styles
that will help you to record video easily in an excellent quality.  
Please follow [video recording integration guide](guide_video_recording.md) to know more about available features.

## Passing Apple Store review
Unfortunately Apple Store may reject your app due to use of TrueDepth API.  
Please [follow guidelines](passing_apple_review.md) to successfully pass Apple Store review.

## Launch methods
In progress...

### Configure audio content

Banuba Video Editor SDK can trim audio tracks, merge them, and apply them to a video. It doesn't include music or sounds. However, it can be integrated with [Mubert](https://mubert.com/) and get music from it (requires additional contract with them). Moreover, the users can add audio files from internal memory (downloaded library) from the phone.

Integrating audio content is simple. See this [guide](audio_content.md#step-1).


## Configure screens
Each screen can be modified to your liking. You can change icons, colors, text and its font, button titles, and much more.

Note that layouts and screen order can't be changed. You can, however, [ask](https://www.banuba.com/faq/kb-tickets/new) us to customize the mobile video editor UI as a separate contract.

Below see the list of screens with links to their detailed description and notes on modifying them

1. [Editor screen](editor_styles.md)
2. [Trim screens](trim_styles.md)
3. [Overlay screens](overlayEditor_styles.md)
4. [Music editor screen](musicEditor_styles.md)
5. [Gallery screen](gallery_styles.md)
6. [Alert screens](alert_styles.md)
7. [Cover screen](cover_style.md)
8. [Audio Browser screen](audioBrowser.md)

The SDK allows overriding icons, colors, typefaces and many more configuration entities. Every SDK screen has its own set of styles.

### Configure masks, video effects and filters order

The SDK allows to reorder masks and filters in the way you need. To achieve this use the property ```preferredLutsOrder``` and ```preferredMasksOrder```

``` swift
 let config = VideoEditorConfig()
 
 // Sorting for the record screen
 config.recorderConfiguration.recorderEffectsConfiguration.preferredLutsOrder = [
   "egypt",
   "norway",
   "japan"
   ...
 ]
 
 config.recorderConfiguration.recorderEffectsConfiguration.preferredMasksOrder = [
   "XYScanner",
   "Background"
   ...
 ]
 
 // Sorting for the post processing screen
 config.filterConfiguration.preferredLutsOrder = [
   "byers",
   "sunset",
   "vinyl"
   ...
 ]
 
 config.filterConfiguration.preferredMasksOrder = [
   "XYScanner",
   "Background"
   ...
 ]
 
 config.filterConfiguration.preferredVideoEffectOrderAndSet = [
  VisualEffectApplicatorType.acid,
  VisualEffectApplicatorType.dvCam
  ...
]
``` 


### Configure stickers content

Stickers are interactive objects (gif images) that can be added to the video recording to add more fun for users.

By default [**Giphy API**](https://developers.giphy.com/docs/api/) is used to load stickers. All you need is just to pass your personal Giphy Api Key into **giphyAPIKey** parameter in GifPickerConfiguration entity.

GIPHY doesn't charge for their content. The one thing they do require is attribution. Also, there is no commercial aspect to the current version of the product (no advertisements, etc.) To use it, please, [add "Search GIPHY" text attribution](overlayEditor_styles.md#string-resources) to the search bar.

### Configure media content

AI Video Editor SDK is provided with its own solution for media content (i.e. images and videos) selection - the gallery screen. To use it as a part of SDK just add the ```BanubaVideoEditorGallerySDK``` pod to your podfile:
```diff
target 'Example' do
  pod 'BanubaVideoEditorSDK'
  ...
+  pod 'BanubaVideoEditorGallerySDK', '1.23.0'
}
```
The gallery provided by the SDK is fully customizable according to [this guide](gallery_styles.md).

Also there is an option to use **your own implementation of the gallery**. This is available according to this [step-by-step guide](configure_external_gallery.md).

### Configure additional Video Editor SDK features

1. [Transition effects](transitions_styles.md)

### Icons

Any icon in the mobile video editor SDK can be replaced. This is how:

1. Load custom images to the Assets catalog
2. Locate the screen with an icon you want to change in the [VideoEditorConfig](/Example/Example/ViewController.swift#L97) entity
3. Find the specific element and override it with the resource name or use UIImage, if available.

For [example](/Example/Example/Extension/RecorderConfiguration.swift#L80), this is how you change a mask icon on the camera screen.

### Localization

Any text in the mobile video editor SDK can be changed. To edit text resources, download the file with strings [here](/Example/Example/en.lproj/Localizable.strings), change whatever you need, and put the new file into your app.

Don't change the keys (values on the left), only the values on the right. Otherwise, the button names and other texts will not show.
