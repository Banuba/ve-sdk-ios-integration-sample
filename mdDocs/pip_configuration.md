# Picture in picture

Picture in picture mode is optional for the video editor SDK and would be disabled if it is not included in your token.
Use ```presentVideoEditor``` method to start Video Editor in picture in picture mode

```swift
/// - Parameters:
///   - pipVideoItem: A url to video located on a phone.
///   - hostController: The view controller to display over.
///   - animated: Pass true to animate the presentation.
///   - musicTrack: Music track which will be played on camera recording.
///   - completion: The block to execute after the presentation finishes.
public func presentVideoEditor(
  withPIPVideoItem pipVideoItem: URL,
  from hostController: UIViewController,
  animated: Bool,
  musicTrack: MediaTrack? = nil,
  completion: (() -> Void)?
)
```

## PIP Configuration

``` swift
/// The picture in picture mode configuration
public struct PIPSettingsConfiguration {
  /// BackgroundConfiguration setups background view style
  public var backgroundConfiguration: BackgroundConfiguration
  /// Cursor color
  public var dragIndicatorConfiguration: RoundedButtonConfiguration
  /// Title font for controls
  public var titleConfiguration: TextConfiguration
  /// Main settings button's configurations
  public var layoutSettingsButtonsConfiguration: [PIPSelectableCellConfiguration]
}
``` 

Picture in picture supports four modes ```.floating```, ```.topBottom```, ```.react```, ```.leftRight```. You can customize the order of this modes and which of them will be available.
Use PIPSelectableCellConfiguration to achieve this

## PIPSelectableCellConfiguration

``` swift
/// The picture in picture cell's configuration
public struct PIPSelectableCellConfiguration {
  /// The button Identifier
  public var identifier: PIPPlayerLayoutSetting
  /// The PIP selectable cell switch config
  public var switchCellConfiguration: PIPSwitchCellConfiguration?
  /// The PIP selectable cell camera config
  public var cameraCellConfiguration: PIPCameraCellConfiguration
  /// The PIP selectable cell cropping config. Only for React mode.
  public var croppingCellConfiguration: PIPCameraCellConfiguration?
  /// The button text configuration.
  public var textConfiguration: TextConfiguration
  /// The default image configuration
  public var imageConfiguration: ImageConfiguration
  /// The border width configuration.
  public var borderWidth: CGFloat
  /// The border color configuration.
  public var borderColor: CGColor
  /// Is image view circable
  public var isRoundedImageView: Bool
  /// The corner radius configuration
  public var cornerRadius: CGFloat?
  /// The background color configuration.
  public var backgroundColor: UIColor
  /// Additional button width.
  ///Default is 130
  public var additionalButtonWidth: CGFloat
  /// Additional button height.
  ///Default is 32
  public var additionalButtonHeight: CGFloat
}
``` 

### Example

``` swift
var config = VideoEditorConfig()

config.pipSettingsConfiguration?.layoutSettingsButtonsConfiguration = [
  PIPSelectableCellConfiguration(identifier: .floating),
  PIPSelectableCellConfiguration(identifier: .react),
  PIPSelectableCellConfiguration(identifier: .topBottom),
  PIPSelectableCellConfiguration(identifier: .leftRight),
]
``` 

