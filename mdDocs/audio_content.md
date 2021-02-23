# API for using client's audio content in the SDK
[comment]: <> (This file was created by exporting notion page from here: https://www.notion.so/vebanuba/API-for-using-client-s-audio-content-in-the-SDK-9a0e03dd3ad04962a2cbadebe5c73c19)
## Overview

The user can apply audio tracks on camera and audio editor screens.

The SDK can apply an audio track to a video, trim an audio track before applying, create new audio track as a composition of several applied audio tracks on video.

**NOTE: the VE SDK is not responsible for providing audio content. The client has to implement an integration with audio content provider.**

### Step 1

Add a dependency into your pod file containing other VE SDK dependencies and setup its version (the latest is 0.0.13):

```swift
pod 'BanubaAudioBrowserSDK', '0.0.14'

```
Then update configuration to be able to open Audio Browser.

**NOTE: BanubaVideoEditor entity should be already initialized before your configuration updating.**

```swift
guard var currentConfig = videoEditorSDK?.currentConfiguration else {
   return 
}

currentConfig.audioBrowserConfiguration.config.mubertAudioConfig.pat = "Your mubert pat"

var featureConfiguration = currentConfig.featureConfiguration
featureConfiguration.isAudioBrowserEnabled = true
currentConfig.updateFeatureConfiguration(featureConfiguration: featureConfiguration)
videoEditorSDK?.updateVideoEditorConfig(currentConfig)

```
