# Banuba VideoEditor SDK
## OverlayEditorConfiguration


- [mainOverlayViewControllerConfig: MainOverlayViewControllerConfig](/Example/Example/Extension/OverlayEditorConfiguration.swift#L6)

MainOverlayViewControllerConfig setups main overlay screen

- [interactivesConfig: InteractivesConfiguration?](/Example/Example/Extension/OverlayEditorConfiguration.swift#L7)

InteractivesConfiguration setups interactive views styles

- var `default`: OverlayEditorConfiguration

Default Configuration


## MainOverlayViewControllerConfig

- [editButtons: [OverlayEditorEditButtonConfig]](/Example/Example/Extension/OverlayEditorConfiguration.swift#L15)

Array of adding buttons

- [editButtonsHeight: CGFloat](/Example/Example/Extension/OverlayEditorConfiguration.swift#L33)

Height for adding buttons' container

- [editButtonsInteritemSpacing: CGFloat](/Example/Example/Extension/OverlayEditorConfiguration.swift#L34)

Spacing between adding buttons

- [editCompositionButtons: [OverlayEditCompositionButtonConfig]](/Example/Example/Extension/OverlayEditorConfiguration.swift#L54)

Array of edit composition buttons

- [controlButtons: [OverlayControlButtonConfig]](/Example/Example/Extension/OverlayEditorConfiguration.swift#L36)

Array of control buttons

- [playerControlsHeight: CGFloat](/Example/Example/Extension/OverlayEditorConfiguration.swift#L74)

Controls container height

- [mainLabelColors: UIColor](/Example/Example/Extension/OverlayEditorConfiguration.swift#L75)

Main labels title color

- [additionalLabelColors: UIColor](/Example/Example/Extension/OverlayEditorConfiguration.swift#L76)

Additional labels title color

- [additionalLabelFonts: UIFont](/Example/Example/Extension/OverlayEditorConfiguration.swift#L77)

Additional labels title font

- [cursorColor: UIColor](/Example/Example/Extension/OverlayEditorConfiguration.swift#L78)

Cursor color

- [audioWaveConfiguration: OverlayItemConfiguration](/Example/Example/Extension/OverlayEditorConfiguration.swift#L79)

OverlayItemConfiguration setups time line items styles

- [resizeImageName: String](/Example/Example/Extension/OverlayEditorConfiguration.swift#L80)

Image name setups resize draggers UIImage

- [draggersHorizontalInset: CGFloat](/Example/Example/Extension/OverlayEditorConfiguration.swift#L81)

Draggers horizontal inset

- [draggersHeight: CGFloat?](/Example/Example/Extension/OverlayEditorConfiguration.swift#L82)

Draggers views' height

- [backgroundConfiguration: BackgroundConfiguration](/Example/Example/Extension/OverlayEditorConfiguration.swift#L83)

BackgroundConfiguration setups background view style

- [playerControlsBackgroundConfiguration: BackgroundConfiguration](/Example/Example/Extension/OverlayEditorConfiguration.swift#L84)

BackgroundConfiguration setups player controls background view style

- [defaultLinesCount: Int](/Example/Example/Extension/OverlayEditorConfiguration.swift#L85)

Default number of time limes

- [timelineCornerRadius: CGFloat](/Example/Example/Extension/OverlayEditorConfiguration.swift#L86)

Time line corner raduis

- [draggerBackgroundColor: UIColor](/Example/Example/Extension/OverlayEditorConfiguration.swift#L87)

Draggers views' background color

- [timeLabelsOffset: CGFloat](/Example/Example/Extension/OverlayEditorConfiguration.swift#L88)

Time labels offset

- [itemsTopOffset: CGFloat](/Example/Example/Extension/OverlayEditorConfiguration.swift#L89)

Top items offset

![img](screenshots/MainOverlayScreen.png)

## TextEditorConfiguration

- [doneButton: RoundedButtonConfiguration](/Example/Example/Extension/OverlayEditorConfiguration.swift#L97)

RoundedButtonConfiguration setups done button style

- [fontButton: RoundedButtonConfiguration](/Example/Example/Extension/OverlayEditorConfiguration.swift#L98)

RoundedButtonConfiguration setups choosing font button style

- [textBackgroundButton: ImageButtonConfiguration](/Example/Example/Extension/OverlayEditorConfiguration.swift#L102)

ImageButtonConfiguration setups filling background color button

- [alignmentImages: [VideoTextAligment: ImageButtonConfiguration]](/Example/Example/Extension/OverlayEditorConfiguration.swift#L107)

Images for aligment states button

- [palette: [VideoTextColorPair]](/Example/Example/Extension/OverlayEditorConfiguration.swift#L113)

Pallete of filling colors

- [fonts: [VideoTextFont]](/Example/Example/Extension/OverlayEditorConfiguration.swift#L124)

Array of text fonts

- [backgroundConfiguration: BackgroundConfiguration](/Example/Example/Extension/OverlayEditorConfiguration.swift#L139)

BackgroundConfiguration setups background view style

- [screenNameConfiguration: ScreenNameConfiguration](/Example/Example/Extension/OverlayEditorConfiguration.swift#L140)

ScreenNameConfiguration setups screen title style

- [palleteInsets: UIEdgeInsets](/Example/Example/Extension/OverlayEditorConfiguration.swift#L141)

Color pallete inset

- [selectionColorBehavior: TextEditSelectionColorBehavior](/Example/Example/Extension/OverlayEditorConfiguration.swift#L143)

 TextEditSelectionColorBehavior setups text editr selection color behavior

- [colorItemConfiguration: TextEditColorItemConfiguration](/Example/Example/Extension/OverlayEditorConfiguration.swift#L148)

TextEditColorItemConfiguration setups pallete's color items' configuration 

![img](screenshots/TextEditorScreen.png)

## GifPickerConfiguration

- [regularFont: UIFont](/Example/Example/Extension/OverlayEditorConfiguration.swift#L158)

Regular font for controls

- [boldFont: UIFont](/Example/Example/Extension/OverlayEditorConfiguration.swift#L159)

Bold font for controls

- [activityConfiguration: SmallActivityIndicatorConfiguration](/Example/Example/Extension/OverlayEditorConfiguration.swift#L160)

SmallActivityIndicatorConfiguration setups activity indicator style

- [cursorColor: UIColor](/Example/Example/Extension/OverlayEditorConfiguration.swift#L161)

Cursor color

- [giphyAPIKey: String?](/Example/Example/Extension/OverlayEditorConfiguration.swift#L162)

API key to interact with giphy service

![img](screenshots/GifScreen.png)
