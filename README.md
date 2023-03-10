[![](https://www.banuba.com/hubfs/Banuba_November2018/Images/Banuba%20SDK.png)](https://www.banuba.com/video-editor-sdk)
# Banuba Video Editor SDK - iOS integration sample
<p align="center">
<img src="mddocs/gif/camera_preview.gif" alt="Screenshot" width="19%" height="auto" class="docs-screenshot"/>&nbsp;
<img src="mddocs/gif/camera_pip.gif" alt="Screenshot" width="19%" height="auto" class="docs-screenshot"/>&nbsp;
<img src="mddocs/gif/audio_browser.gif" alt="Screenshot" width="19%" height="auto" class="docs-screenshot"/>&nbsp;
<img src="mddocs/gif/editor_timeline.gif" alt="Screenshot" width="19%" height="auto" class="docs-screenshot"/>&nbsp;
<img src="mddocs/gif/background_separation.gif" alt="Screenshot" width="19%" height="auto" class="docs-screenshot"/>&nbsp;
</p>

## Overview
[Banuba Video Editor SDK](https://www.banuba.com/video-editor-sdk) allows you to quickly add short video functionality and possibly AR filters and effects into your mobile app.  

## Usage
### License
Before you commit to a license, you are free to test all the features of the SDK for free. The trial period lasts 14 days. To start it, [send us a message](https://www.banuba.com/video-editor-sdk#form).
We will get back to you with the trial token.  
Feel free to [contact us](https://www.banuba.com/faq/kb-tickets/new) if you have any questions.

### Installation

1. Clone the repository
2. Install CocoaPods dependencies. Open **Example** directory ```cd Example``` and run ```pod install``` in terminal.
3. Open the project in XCode
4. Open **Signing & Capabilities** tab in Target settings and select your Development Team.
5. Add the license token [within the app](/Example/Example/AppDelegate.swift#L9)
6. Run sample application in XCode

### Quickstart Guide
Our [Quickstart Guide](mdDocs/quickstart.md) will help you to quickly integrate and customize Video Editor SDK into your iOS project.

## Requirements
This is what you need to run the AI Video Editor SDK

- iPhone devices 6s+
- Swift 5+
- Xcode 14.0+
- iOS 13.0+
  Unfortunately, It isn't optimized for iPads.

## Supported media formats
| Audio      | Video      | Images      |
| ---------- | ---------  | ----------- |
|.mp3, .aac, .wav, <br>.m4a, .flac, .aiff |.mp4, .mov, .m4v| .bmp, .gif, .heic, <br>.jpeg, .jpg, .png, .tiff