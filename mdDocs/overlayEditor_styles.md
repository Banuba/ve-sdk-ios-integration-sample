# Banuba VideoEditor SDK
## OverlayEditorConfiguration

The Overlay Editor screen allows you to add text, gifs to your video, as well as adjust the size and position of the added elements.

Below are the configs for customizing the Overlay Editor screen.

- [mainOverlayViewControllerConfig: MainOverlayViewControllerConfig](/Example/Example/Extension/OverlayEditorConfiguration.swift#L10)

MainOverlayViewControllerConfig setups main overlay screen

- [overlayType: OverlayAddButtonConfig](/Example/Example/Extension/OverlayEditorConfiguration.swift#L10)

Types of editing overlay items. Can be .text or .sticker

- [selectedOverlayItem: OverlayItem?](/Example/Example/Extension/OverlayEditorConfiguration.swift#L11)

Selected overlay item. If nil passed overlay editor will be opened for creation a new one

- var `default`: OverlayEditorConfiguration

Default Configuration


## MainOverlayViewControllerConfig

- [editButtons: [OverlayAddButtonConfig]](/Example/Example/Extension/OverlayEditorConfiguration.swift#L19)

Array of adding buttons

- [addButtons: [OverlayAddButtonConfig]](/Example/Example/Extension/OverlayEditorConfiguration.swift#L19)

Array of adding buttons

- [editButtonsHeight: CGFloat](/Example/Example/Extension/OverlayEditorConfiguration.swift#L37)

Height for adding buttons' container

- [editButtonsInteritemSpacing: CGFloat](/Example/Example/Extension/OverlayEditorConfiguration.swift#L38)

Spacing between adding buttons

- [editCompositionButtons: [OverlayEditCompositionButtonConfig]](/Example/Example/Extension/OverlayEditorConfiguration.swift#L58)

Array of edit composition buttons

- [controlButtons: [OverlayControlButtonConfig]](/Example/Example/Extension/OverlayEditorConfiguration.swift#L40)

Array of control buttons

- [playerControlsHeight: CGFloat](/Example/Example/Extension/OverlayEditorConfiguration.swift#L78)

Controls container height

- [mainLabelColors: UIColor](/Example/Example/Extension/OverlayEditorConfiguration.swift#L79)

Main labels title color

- [additionalLabelColors: UIColor](/Example/Example/Extension/OverlayEditorConfiguration.swift#L80)

Additional labels title color

- [additionalLabelFonts: UIFont](/Example/Example/Extension/OverlayEditorConfiguration.swift#L81)

Additional labels title font

- [cursorColor: UIColor](/Example/Example/Extension/OverlayEditorConfiguration.swift#L82)

Cursor color

- [audioWaveConfiguration: OverlayItemConfiguration](/Example/Example/Extension/OverlayEditorConfiguration.swift#L83)

OverlayItemConfiguration setups time line items styles

- [resizeImageName: String](/Example/Example/Extension/OverlayEditorConfiguration.swift#L84)

Image name setups resize draggers UIImage

- [draggersHorizontalInset: CGFloat](/Example/Example/Extension/OverlayEditorConfiguration.swift#L85)

Draggers horizontal inset

- [draggersWidth: CGFloat?](/Example/Example/Extension/OverlayEditorConfiguration.swift#L96)

Draggers views' width

- [draggersHeight: CGFloat?](/Example/Example/Extension/OverlayEditorConfiguration.swift#L86)

Draggers views' height

- [draggersImageHeight: CGFloat?](/Example/Example/Extension/OverlayEditorConfiguration.swift#L95)

Draggers view'h images height

- [backgroundConfiguration: BackgroundConfiguration](/Example/Example/Extension/OverlayEditorConfiguration.swift#L87)

BackgroundConfiguration setups background view style

- [playerControlsBackgroundConfiguration: BackgroundConfiguration](/Example/Example/Extension/OverlayEditorConfiguration.swift#L88)

BackgroundConfiguration setups player controls background view style

- [defaultLinesCount: Int](/Example/Example/Extension/OverlayEditorConfiguration.swift#L89)

Default number of time limes

- [timelineCornerRadius: CGFloat](/Example/Example/Extension/OverlayEditorConfiguration.swift#L90)

Time line corner raduis

- [draggerBackgroundColor: UIColor](/Example/Example/Extension/OverlayEditorConfiguration.swift#L91)

Draggers views' background color

- [draggerCornerRadius: CGFloat?](/Example/Example/Extension/OverlayEditorConfiguration.swift#L94)

Draggers views' corner radius.

- [timeLabelsOffset: CGFloat](/Example/Example/Extension/OverlayEditorConfiguration.swift#L92)

Time labels offset

- [itemsTopOffset: CGFloat](/Example/Example/Extension/OverlayEditorConfiguration.swift#L93)

Top items offset

- [alertConfig: AlertViewConfiguration](/Example/Example/Extension/OverlayEditorConfiguration.swift#L93)

Configuration for alertView

- [previewViewBackgroundConfiguration: BackgroundConfiguration](/Example/Example/Extension/OverlayEditorConfiguration.swift#L93)

BackgroundConfiguration setups preview view background style

![img](screenshots/MainOverlayScreen.png)

## TextEditorConfiguration

- [doneButton: RoundedButtonConfiguration](/Example/Example/Extension/OverlayEditorConfiguration.swift#L104)

RoundedButtonConfiguration setups done button style

- [fontButton: ImageButtonConfiguration](/Example/Example/Extension/OverlayEditorConfiguration.swift#L105)

RoundedButtonConfiguration setups choosing font button style

- [colorButton: ImageButtonConfiguration](/Example/Example/Extension/OverlayEditorConfiguration.swift#L105)

ImageButtonConfiguration setups filling background color button

- [textBackgroundButton: ImageButtonConfiguration](/Example/Example/Extension/OverlayEditorConfiguration.swift#L113)

ImageButtonConfiguration setups filling background color button

- [alignmentImages: [VideoTextAligment: ImageButtonConfiguration]](/Example/Example/Extension/OverlayEditorConfiguration.swift#L118)

Images for aligment states button

- [palette: [VideoTextColorPair]](/Example/Example/Extension/OverlayEditorConfiguration.swift#L124)

Pallete of filling colors

- [fonts: [VideoTextFont]](/Example/Example/Extension/OverlayEditorConfiguration.swift#L135)

Array of text fonts

- [additionalPaletteBackgroundConfiguration: [BackgroundConfiguration]](/Example/Example/Extension/OverlayEditorConfiguration.swift#L150)

Setup background color for additional palette with fonts or colors

- [screenNameConfiguration: ScreenNameConfiguration](/Example/Example/Extension/OverlayEditorConfiguration.swift#L151)

ScreenNameConfiguration setups screen title style

- [palleteInsets: UIEdgeInsets](/Example/Example/Extension/OverlayEditorConfiguration.swift#L152)

Color pallete inset

- [fontInsets: UIEdgeInsets](/Example/Example/Extension/OverlayEditorConfiguration.swift#L145)

Font inset

- [selectionColorBehavior: TextEditSelectionColorBehavior](/Example/Example/Extension/OverlayEditorConfiguration.swift#L154)

 TextEditSelectionColorBehavior setups text editr selection color behavior
 
 - [colorItemConfiguration: TextEditColorItemConfiguration](/Example/Example/Extension/OverlayEditorConfiguration.swift#L159)

TextEditColorItemConfiguration setups pallete's color items' configuration 

- [fontItemConfiguration: TextEditFontItemConfiguration](/Example/Example/Extension/OverlayEditorConfiguration.swift#L164)

TextEditFontItemConfiguration setups pallete font items' configuration

- cursorColor: UIColor

Cursor color

![img](screenshots/TextEditorScreen.png)

## GifPickerConfiguration

- [regularFont: UIFont](/Example/Example/Extension/OverlayEditorConfiguration.swift#L177)

Regular font for controls

- [boldFont: UIFont](/Example/Example/Extension/OverlayEditorConfiguration.swift#L178)

Bold font for controls

- [activityConfiguration: SmallActivityIndicatorConfiguration](/Example/Example/Extension/OverlayEditorConfiguration.swift#L179)

SmallActivityIndicatorConfiguration setups activity indicator style

- [cursorColor: UIColor](/Example/Example/Extension/OverlayEditorConfiguration.swift#L180)

Cursor color

- [giphyAPIKey: String?](/Example/Example/Extension/OverlayEditorConfiguration.swift#L181)

API key to interact with giphy service

![img](screenshots/GifScreen.png)


## String resources

![img](screenshots/OverlayLocalization.png)

| Key        |      Value      |   Description |
| ------------- | :----------- | :------------- |
| OverlayEditor.Delete | Delete | Delete overlay item button title
| OverlayEditor.Edit | Edit | Edit overlay item button title
| OverlayEditor.Text | Text | Add text button title
| OverlayEditor.Sticker | Sticker | Add sticker button title
| OverlayEditor.Cancel | Cancel | Cancel button title
| OverlayEditor.Done | Done | Done button title
| OverlayEditor.Yes | Yes | Confirmation button title
| OverlayEditor.No | No | Discarding button title
| com.banuba.overlayEditor.mainScreen.resetAll.title | Discard changes? | Confirmation message for discarding changes
| com.banuba.searchGif.placeholder | Search GIPHY | Hint, which is shown in the GIF objects search input field, if it is empty
| Cancel | Cancel | Ability to cancel the search for GIF objects
| No stickers found | No stickers found | Pictures not found by custom keyword
| Problems with internet | Problems with internet |A heading showing that there are problems with the Internet connection
| Check your connection and try again | Check your connection and try again | Advice to the user on further actions to solve this problem
| Again | Again | Ability to load GIF objects again
