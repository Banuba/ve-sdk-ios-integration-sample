# Banuba AI Video Editor SDK
## Aspects screen style

    How to open aspects screen?

![initial](https://user-images.githubusercontent.com/73183216/149048108-835d4ca8-827c-47ac-9d01-fdbfc9102ec0.PNG)

    How to change related icons?

![details](https://user-images.githubusercontent.com/73183216/149048176-a6d40e6b-b883-4173-add8-b81b93e1ca1b.PNG)

- [ic_done](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/ic_done.imageset/ic_done%402x.png)

    icon for the button that applies selected aspect

- [ic_close](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/ic_close.imageset/ic_close%402x.png)

    icon for the button that returns the user to the previous screen

- [ic_play](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/ic_play.imageset/ic_play@2x.png)

- [ic_trim_pause](https://github.com/Banuba/ve-sdk-ios-integration-sample/blob/main/Example/Example/Assets.xcassets/ic_trim_pause.imageset/ic_pause@2x.png)

![pause](https://user-images.githubusercontent.com/73183216/149048240-be04ee64-2edf-4bad-acc3-50e6015c728e.PNG)

- To update view, consider ```AspectsConfiguration``` and the following method:
```swift
  func updateAspectsConfiguration(_ configuration: AspectsConfiguration) -> AspectsConfiguration {
    var configuration = configuration
    
    configuration.doneButton = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_done"))
    configuration.cancelButton = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_close"))
    
    return configuration
  }
  ```

```swift
/// Aspects screen configuration
public struct AspectsConfiguration {

    /// Setups image for cancel button
    public var cancelButton: BanubaVideoEditorSDK.ImageButtonConfiguration

    /// Setups image for done button
    public var doneButton: BanubaVideoEditorSDK.ImageButtonConfiguration

    /// Setups background color for screen
    public var backgroundConfiguration: BanubaUtilities.BackgroundConfiguration

    /// Setups background color for controls view
    public var backgroundControlsViewColor: UIColor

    /// Setups aspects
    public var aspects: [BanubaVideoEditorSDK.AspectConfiguration]

    /// Setups default aspect
    /// Default is .original
    public var defaultAspect: BanubaUtilities.AspectRatio
    
    /// Setups the primary aspect. Hides aspects button if it's value is not nil.
    /// Default is nil.
    public var primaryAspect: AspectRatio?
}
```
