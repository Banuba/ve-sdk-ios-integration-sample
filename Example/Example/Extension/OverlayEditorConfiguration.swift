extension ViewController {
  
  private func updateOverlayEditorConfiguraiton(_ configuration: OverlayEditorConfiguration) -> OverlayEditorConfiguration {
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
        imageName: "imageName"
      ),
      
      OverlayAddButtonConfig(
        type: .sticker,
        title: "Sticker",
        titleColor: .white,
        font: UIFont.systemFont(ofSize: 14.0),
        imageName: "imageName"
      )
    ]
    
    configuration.editButtonsHeight = 50.0
    configuration.editButtonsInteritemSpacing = 0.0
    
    configuration.controlButtons = [
      OverlayControlButtonConfig(
        type: .reset,
        imageName: "imageName",
        selectedImageName: nil
      ),
      OverlayControlButtonConfig(
        type: .play,
        imageName: "imageName",
        selectedImageName: "imageName"
      ),
      OverlayControlButtonConfig(
        type: .done,
        imageName: "imageName",
        selectedImageName: nil
      )
    ]
    
    configuration.editCompositionButtons = [
      OverlayEditButtonConfig(
        type: .edit,
        title: "Edit",
        titleColor: .white,
        font: UIFont.systemFont(ofSize: 14.0),
        imageName: "imageName",
        selectedImageName: "imageName"
      ),
      
      OverlayEditButtonConfig(
        type: .delete,
        title: "Delete",
        titleColor: .white,
        font: UIFont.systemFont(ofSize: 14.0),
        imageName: "imageName",
        selectedImageName: "imageName"
      )
    ]
    
    configuration.playerControlsHeight = 50.0
    configuration.mainLabelColors = UIColor.yellow
    configuration.additionalLabelColors = UIColor.white
    configuration.additionalLabelFonts = UIFont.systemFont(ofSize: 12.0)
    configuration.cursorColor = UIColor.white
    configuration.audioWaveConfiguration.borderColor = UIColor.white
    configuration.resizeImageName = "imageName"
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
  
  private func updateTextEditorConfiguration(_ configuration: TextEditorConfiguration) -> TextEditorConfiguration {
    var configuration = configuration
    
    configuration.doneButton.textConfiguration.color = UIColor.yellow
    configuration.fontButton.borderColor = UIColor.yellow.cgColor
    configuration.fontButton.backgroundColor = #colorLiteral(red: 0.609685123, green: 0.5531321764, blue: 0.4753085971, alpha: 0.1220836901)
    configuration.fontButton.textConfiguration.color = UIColor.yellow
    
    configuration.textBackgroundButton = ImageButtonConfiguration(
      imageConfiguration: ImageConfiguration(imageName: "imageName"),
      selectedImageConfiguration: ImageConfiguration(imageName: "imageName")
    )
    
    configuration.alignmentImages = [
      .left: ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "imageName")),
      .center: ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "imageName")),
      .right: ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "imageName"))
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
