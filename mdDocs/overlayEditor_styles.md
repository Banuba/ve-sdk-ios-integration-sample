# Banuba VideoEditor SDK
## OverlayEditorConfiguration


- mainOverlayViewControllerConfig: MainOverlayViewControllerConfig

MainOverlayViewControllerConfig setups main overlay screen

- interactivesConfig: InteractivesConfiguration?

InteractivesConfiguration setups interactive views styles

- var `default`: OverlayEditorConfiguration

Default Configuration


## MainOverlayViewControllerConfig

- editButtons: [OverlayEditorEditButtonConfig]

Array of adding buttons

- editButtonsHeight: CGFloat

Height for adding buttons' container

- editButtonsInteritemSpacing: CGFloat

Spacing between adding buttons

- editCompositionButtons: [OverlayEditCompositionButtonConfig]

Array of edit composition buttons

- controlButtons: [OverlayControlButtonConfig]

Array of control buttons

- playerControlsHeight: CGFloat

Controls container height

- mainLabelColors: UIColor

Main labels title color

- additionalLabelColors: UIColor

Additional labels title color

- additionalLabelFonts: UIFont

Additional labels title font

- cursorColor: UIColor

Cursor color

- audioWaveConfiguration: OverlayItemConfiguration

OverlayItemConfiguration setups time line items styles

- resizeImageName: String

Image name setups resize draggers UIImage

- draggersHorizontalInset: CGFloat

Draggers horizontal inset

- draggersHeight: CGFloat?

Draggers views' height

- backgroundConfiguration: BackgroundConfiguration

BackgroundConfiguration setups background view style

- playerControlsBackgroundConfiguration: BackgroundConfiguration

BackgroundConfiguration setups player controls background view style

- defaultLinesCount: Int

Default number of time limes

- timelineCornerRadius: CGFloat

Time line corner raduis

- draggerBackgroundColor: UIColor

Draggers views' background color

- timeLabelsOffset: CGFloat

Time labels offset

- itemsTopOffset: CGFloat

Top items offset

![img](screenshots/MainOverlayScreen.png)

## TextEditorConfiguration

- doneButton: RoundedButtonConfiguration

RoundedButtonConfiguration setups done button style

- fontButton: RoundedButtonConfiguration

RoundedButtonConfiguration setups choosing font button style

- textBackgroundButton: ImageButtonConfiguration

ImageButtonConfiguration setups filling background color button

- alignmentImages: [VideoTextAligment: ImageButtonConfiguration]

Images for aligment states button

- palette: [VideoTextColorPair]

Pallete of filling colors

- fonts: [VideoTextFont]

Array of text fonts

- backgroundConfiguration: BackgroundConfiguration

BackgroundConfiguration setups background view style

- screenNameConfiguration: ScreenNameConfiguration

ScreenNameConfiguration setups screen title style

- palleteInsets: UIEdgeInsets

Color pallete inset

- selectionColorBehavior: TextEditSelectionColorBehavior

 TextEditSelectionColorBehavior setups text editr selection color behavior

- colorItemConfiguration: TextEditColorItemConfiguration

TextEditColorItemConfiguration setups pallete's color items' configuration 

![img](screenshots/TextEditorScreen.png)

## GifPickerConfiguration

- regularFont: UIFont

Regular font for controls

- boldFont: UIFont

Bold font for controls

- activityConfiguration: SmallActivityIndicatorConfiguration

SmallActivityIndicatorConfiguration setups activity indicator style

- cursorColor: UIColor

Cursor color

- giphyAPIKey: String?

API key to interact with giphy service

![img](screenshots/GifScreen.png)
