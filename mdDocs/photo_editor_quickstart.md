# Banuba AR Photo Editor Quickstart Guide
## SDK Installation
### CocoaPods
Learn [CocoaPods Getting Started Guide](https://guides.cocoapods.org/using/getting-started.html) if you are new to CocoaPods.

❗️Important  
It is advised to use the latest CocoaPods version. Please check your version ```pod --version``` and upgrade.

Complete the following steps to get Photo Editor SDK dependencies using CocoaPods.
1. Install CocoaPods using Homebrew
   ```sh
   brew install cocoapods 
   ```
2. Create a new Podfile in your project folder or editing existing one
   ```sh
   pod init
   ```
3. Add necessary pods and our podspecs source to the Podfile. The list of required Photo Editor dependencies can be found in example [Podfile](../Example/Podfile).
4. Install Video Editor SDK pods
   ```sh
   pod install --repo-update
   ```
4. Open the workspace ```***.xcworkspace``` in Xcode and run the project.
## Add localization strings
Photo Editor SDK displays a number of strings that can be freely changed in the Localizable.strings file of your app.  
Please make sure that you've included all the strings with `photoEditor` key prefix in your app's Localizable.strings file from [Localized Strings](../Example/Example/en.lproj/Localizable.strings) file provided with the sample project to prevent the placeholders from showing up in the photo editor's UI.
If you are still seeing placeholders, make sure that App Language in Xcode Scheme Options is set to English as this is the only language supported by this demo app.
## Launch
Create instance of ```BanubaPhotoEditor```  using the license token.
```swift
var configuration = PhotoEditorConfig()
let photoEditorSDK = BanubaPhotoEditor(
  token: token,
  configuration: configuration
)
photoEditorSDK?.delegate = delegate
photoEditorSDK?.presentPhotoEditor(
  withLaunchConfiguration: launchConfig,
  completion: nil
)

```
`photoEditorSDK` is `nil` when the license token is incorrect i.e. empty, truncated.
If `photoEditorSDK` is not `nil` you can proceed and start video editor.

Next, we strongly recommend checking your license state before starting the photo editor
```swift
photoEditorSDK?.getLicenseState(completion: { [weak self] isValid in
  if isValid {
    print("✅ License is active, all good")
  } else {
    print("❌ License is either revoked or expired")
  }
  ...
  completion(isValid)
})
```
⚠️ "Photo editing is unavailable" screen will appear if you start Photo Editor SDK with revoked or expired license.

⚠️ If you have also integrated the Video Editor SDK in your app, make sure to deallocate any instances of `BanubaVideoEditor` that remain in memory before presenting the photo editor, to prevent crashes:
```swift
videoEditorSDK = nil
...
photoEditorSDK?.presentPhotoEditor(
  withLaunchConfiguration: launchConfig,
  completion: nil
)
```
## Photo Editor Lifecycle Events
To receive the notifications when user has either closed the editor or finished editing and saved the edited photo, create a class that conforms to `BanubaPhotoEditorDelegate` protocol and assign its reference to `BanubaPhotoEditor.delegate` property:
```swift
photoEditorSDK?.delegate = delegate
```
During handling of both notifications you must dismiss the photo editor:
```swift
/// User closed photo editor without editing image
func photoEditorDidCancel(
  _ photoEditor: BanubaPhotoEditorSDK.BanubaPhotoEditor
) {
  photoEditor.dismissPhotoEditor(animated: true, completion: nil)
}

/// User closed photo editor after saving image
func photoEditorDidFinishWithImage(
  _ photoEditor: BanubaPhotoEditorSDK.BanubaPhotoEditor,
  image: UIImage
) {
  photoEditor.dismissPhotoEditor(animated: true, completion: nil)
  // Do something with received image
}
```
## Configuration
### Initial screen (entry point) selection
By default the built-in gallery will be shown first after the presentation of Photo Editor. In some cases the hosting app may already provide a photo selection functionality using its own custom gallery and it is necessary to directly open the photo editing screen with a preselected photo. To support such use cases there is an `entryPoint` property in `PhotoEditorLaunchConfig`. By using the `editorWithImage` or `editorWithURL` options you can specify the edited image by either directly providing the `UIImage` instance or *local* `URL` to on-disk binary image representation.

In the following example the image stored in app's bundle will be opened in the Photo Editor SDK:
```swift
let url = Bundle.main.url(forResource: "image", withExtension: "jpg")!
let launchConfig = PhotoEditorLaunchConfig(
  hostController: ...,
  entryPoint: .editorWithURL(url)
)
photoEditorSDK.presentPhotoEditor(
  withLaunchConfiguration: launchConfig,
  completion: nil
)
```
Should there be any problem with decoding the image at provided url, an error message will be logged in the console by the SDK.
### Sharing screen configuration
After finishing editing image user is navigated to Sharing screen. If Facebook or Instagram are installed on user's phone it will be possible to present an option to share the image as Facebook or Instagram Story. To enable such functionality you need to specify a Facebook app id:
```swift
var configuration = PhotoEditorConfig() 
configuration.previewScreenConfiguration.facebookId = "***"
let photoEditorSDK = BanubaPhotoEditor(
  token: "***",
  configuration: configuration
)
```
Read more about sharing to Instagram and Facebook stories at https://developers.facebook.com/docs/instagram/sharing-to-stories/.