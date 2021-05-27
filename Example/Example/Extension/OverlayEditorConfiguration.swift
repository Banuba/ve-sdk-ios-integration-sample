import UIKit
import BanubaOverlayEditorSDK
import BanubaVideoEditorSDK

extension ViewController {
  
  func updateOverlayEditorConfiguraiton(_ configuration: OverlayEditorConfiguration) -> OverlayEditorConfiguration {
    var configuration = configuration
    
    configuration.mainOverlayViewControllerConfig = updateMainOverlayViewControllerConfig(configuration.mainOverlayViewControllerConfig)
    configuration.interactivesConfig = nil
    
    return configuration
  }
  
  func updateMainOverlayViewControllerConfig(_ configuration: MainOverlayViewControllerConfig) -> MainOverlayViewControllerConfig {
    var configuration = configuration
    
    configuration.addButtons = [
      OverlayAddButtonConfig(
        type: .text,
        title: "Text",
        titleColor: .white,
        font: UIFont.systemFont(ofSize: 14.0),
        imageName: "ic_AddText"
      ),
      
      OverlayAddButtonConfig(
        type: .sticker,
        title: "Sticker",
        titleColor: .white,
        font: UIFont.systemFont(ofSize: 14.0),
        imageName: "ic_AddSticker"
      )
    ]
    
    configuration.editButtonsHeight = 50.0
    configuration.editButtonsInteritemSpacing = 0.0
    
    configuration.controlButtons = [
      OverlayControlButtonConfig(
        type: .reset,
        imageName: "ic_restart",
        selectedImageName: nil
      ),
      OverlayControlButtonConfig(
        type: .play,
        imageName: "ic_editor_play",
        selectedImageName: "ic_pause"
      ),
      OverlayControlButtonConfig(
        type: .done,
        imageName: "ic_done",
        selectedImageName: nil
      )
    ]
    
    configuration.editCompositionButtons = [
      OverlayEditButtonConfig(
        type: .edit,
        title: "Edit",
        titleColor: .white,
        font: UIFont.systemFont(ofSize: 14.0),
        imageName: "ic_edit",
        selectedImageName: nil
      ),
      
      OverlayEditButtonConfig(
        type: .delete,
        title: "Delete",
        titleColor: .white,
        font: UIFont.systemFont(ofSize: 14.0),
        imageName: "ic_trash",
        selectedImageName: nil
      )
    ]
    
    configuration.playerControlsHeight = 50.0
    configuration.mainLabelColors = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    configuration.additionalLabelColors = UIColor.white
    configuration.additionalLabelFonts = UIFont.systemFont(ofSize: 12.0)
    configuration.cursorColor = UIColor.white
    configuration.audioWaveConfiguration.borderColor = UIColor.white
    configuration.resizeImageName = "ic_cut_arrow"
    configuration.draggersHorizontalInset = .zero
    configuration.draggersHeight = 25.0
    configuration.backgroundConfiguration.cornerRadius = .zero
    configuration.playerControlsBackgroundConfiguration.cornerRadius = .zero
    configuration.defaultLinesCount = 2
    configuration.timelineCornerRadius = .zero
    configuration.draggerBackgroundColor = UIColor.white
    configuration.timeLabelsOffset = .zero
    configuration.itemsTopOffset = .zero
    
    return configuration
  }
  
  func updateTextEditorConfiguration(_ configuration: TextEditorConfiguration) -> TextEditorConfiguration {
    var configuration = configuration
    
    configuration.doneButton.textConfiguration.color = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    configuration.fontButton.borderColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    configuration.fontButton.backgroundColor = #colorLiteral(red: 0.609685123, green: 0.5531321764, blue: 0.4753085971, alpha: 0.1220836901)
    configuration.fontButton.textConfiguration.color = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
    
    configuration.textBackgroundButton = ImageButtonConfiguration(
      imageConfiguration: ImageConfiguration(imageName: "ic_text_without_background"),
      selectedImageConfiguration: ImageConfiguration(imageName: "ic_text_with_background")
    )
    
    configuration.alignmentImages = [
      .left: ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_text_align_left")),
      .center: ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_text_align_center")),
      .right: ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_text_align_right"))
    ]
    
    configuration.palette = [
      VideoTextColorPair(colors:
                          (
                            UIColor.white,
                            UIColor.clear,
                            UIColor.yellow,
                            UIColor.systemYellow
                          )
      )
    ]
    
    configuration.fonts = [
      VideoTextFont(
        font: UIFont.systemFont(ofSize: 38),
        name: "Regular"
      ),
      VideoTextFont(
        font: UIFont.italicSystemFont(ofSize: 38),
        name: "Italic"
      ),
      VideoTextFont(
        font: UIFont.boldSystemFont(ofSize: 38),
        name: "Bold"
      )
    ]
    
    configuration.backgroundConfiguration.cornerRadius = .zero
    configuration.screenNameConfiguration.style = nil
    configuration.palleteInsets = .zero
    
    configuration.selectionColorBehavior = TextEditSelectionBorderAnimationBehavior(
      defaultBorderWidth: 3.0,
      selectedBorderWidth: 8.0
    )
    
    configuration.colorItemConfiguration = TextEditColorItemConfiguration(
      borderColor: UIColor.white,
      borderWidth: 3.0
    )
    
    return configuration
  }
  
  func updateGifPickerConfiguration(_ configuration: GifPickerConfiguration) -> GifPickerConfiguration {
    var configuration = configuration
    configuration.regularFont = UIFont.systemFont(ofSize: 16)
    configuration.boldFont = UIFont.boldSystemFont(ofSize: 22)
    configuration.activityConfiguration.activityLineWidth = 3.0
    configuration.cursorColor = UIColor.white
    configuration.giphyAPIKey = nil
    
    return configuration
  }
}
