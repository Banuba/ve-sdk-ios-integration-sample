# Face AR and AR Cloud integration guide

- [Overview](#Overview)
- [Manage effects](#Manage-effects)
- [Integrate AR Cloud](#Integrate-AR-Cloud)
- [Change effects order](#Change-effects-order)
- [Disable Face AR SDK](#Disable-Face-AR-SDK)
- [Integrate Beauty effect](#Integrate-Beauty-effect)
- [Integrate Background effect](#Integrate-Background-effect)

[Banuba Face AR SDK](https://www.banuba.com/facear-sdk/face-filters) product is used on camera and editor screens for applying various AR effects while making video content.

## Overview
Any Face AR effect is a normal folder that includes a number of files required for Face AR SDK to play this effect.

:exclamation: Important    
Make sure you included ```preview.png``` file in effect folder. This file is used as a preview for AR effect.

## Manage effects
There are 2 options for managing AR effects:
1. ```bundleEffects``` folder
   Use [Example/bundleEffects](../Example/Example/bundleEffects) folder
2. ```AR Cloud```  
   Effects are stored on the remote server.

:exclamation: Important,  
Please, keep the name ```bundleEffects```, otherwise, the app will not start. Create ```bundleEffects``` folder if it does not exist.

:bulb: Recommendation  
You can use both options i.e. store just a few AR effects in ```assets``` and 100 or more AR effects  on ```AR Cloud```.

## Integrate AR Cloud

```AR Cloud``` is a cloud solution for storing Banuba Face AR effects on the server and used by Face AR and Video Editor products.  
Any AR effect downloaded from ```AR Cloud``` is cached on the user's device.

Add dependency to [Podfile](../Example/Podfile#L11) to integrate ```AR Cloud``` into your project.
```diff
+  pod 'BanubaARCloudSDK', '1.26.5'
```

Since the link to your AR Cloud bucket is included into the license token. AR effects will appear once you set the license token with AR Cloud link.

## Change effects order
By default, all AR effects are listed in alphabetical order. AR effects from ```bundleEffects``` are listed in the beginning.

Provide your ordered list of effects to  ```preferredMasksOrder``` in ```VideoEditorConfig```
```swift
 videoEditorConfig.recorderConfiguration.recorderEffectsConfiguration.preferredMasksOrder = [
   "XYScanner",
   "Background"
   ...
 ]
``` 

:exclamation: Important  
These are names of specific directories located in ```bundleEffects``` or on ```AR Cloud```.

## Disable Face AR SDK
Video Editor SDK can work without Face AR SDK.
Change [Podfile](../Example/Podfile) to disable Face AR SDK.
```diff
banuba_sdk_version = '1.26.5'

-  pod 'BanubaEffectPlayer', banuba_sdk_version
-  pod 'BanubaSDK', banuba_sdk_version
+  pod 'BanubaSDKSimple', banuba_sdk_version
```

## Integrate Beauty effect
IN PROGRESS...

## Integrate Background effect
IN PROGRESS...
AND add styles
