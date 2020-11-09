import UIKit
import BanubaVideoEditorSDK
import BanubaOverlayEditorSDK

class ViewController: UIViewController {

  private var videoEditorSDK: BanubaVideoEditorSDK?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initVideoEditor()
  }
  
  private func initVideoEditor() {
    let config = createVideoEditorConfiguration()
    videoEditorSDK = BanubaVideoEditorSDK(
      token: "place client token here",
      effectsToken: "place effects token here",
      configuration: config,
      analytics: nil,
      externalViewControllerFactory: nil
    )
    videoEditorSDK?.delegate = self
  }
  
  @IBAction func openVideoEditorAction(_ sender: Any) {
    videoEditorSDK?.presentVideoEditor(from: self, animated: true, completion: nil)
  }
  
  func createVideoEditorConfiguration() -> VideoEditorConfig {
    var config = VideoEditorConfig()
    
    config.overlayEditorConfiguration = updateOverlayEditorConfiguraiton(config.overlayEditorConfiguration)
    config.textEditorConfiguration = updateTextEditorConfiguration(config.textEditorConfiguration)
    
    return config
  }
  
  private func updateOverlayEditorConfiguraiton(_ configuration: OverlayEditorConfiguration) -> OverlayEditorConfiguration {
    var configuration = configuration
    
    configuration.mainOverlayViewControllerConfig.controlButtons = [
      OverlayControlButtonConfig(
        type: .reset,
        imageName: "ic_restart",
        selectedImageName: nil
      ),
      OverlayControlButtonConfig(
        type: .play,
        imageName: "ic_play",
        selectedImageName: "ic_pause"
      ),
      OverlayControlButtonConfig(
        type: .done,
        imageName: "ic_done",
        selectedImageName: nil
      )
    ]
    
    configuration.mainOverlayViewControllerConfig.editButtons = [
      OverlayEditorEditButtonConfig(
        type: .text,
        title: "Text",
        titleColor: .white,
        font: UIFont.systemFont(ofSize: 14.0),
        imageName: "ic_addText"
      ),
      OverlayEditorEditButtonConfig(
        type: .sticker,
        title: "Sticker",
        titleColor: .white,
        font: UIFont.systemFont(ofSize: 14.0),
        imageName: "ic_addSticker"
      )
    ]
    
    configuration.mainOverlayViewControllerConfig.editCompositionButtons = [
      OverlayEditCompositionButtonConfig(
        type: .edit,
        title: "Edit",
        titleColor: .white,
        font: UIFont.systemFont(ofSize: 14.0),
        imageName: "ic_edit",
        selectedImageName: nil
      ),
      OverlayEditCompositionButtonConfig(
        type: .delete,
        title: "Delete",
        titleColor: .white,
        font: UIFont.systemFont(ofSize: 14.0),
        imageName: "ic_trash",
        selectedImageName: nil
      )
    ]
    
    configuration.mainOverlayViewControllerConfig.resizeImageName = "ic_cut_arrow"
    configuration.mainOverlayViewControllerConfig.draggerBackgroundColor = .clear
    configuration.mainOverlayViewControllerConfig.draggersHorizontalInset = 10.0
    configuration.mainOverlayViewControllerConfig.draggersHeight = 20.0
    
    configuration.mainOverlayViewControllerConfig.cancelButtonConfiguration.color = UIColor(red: 6, green: 188, blue: 193)
    configuration.mainOverlayViewControllerConfig.cancelButtonConfiguration.title = "Cancel" 
    
    return configuration
  }
  
  private func updateTextEditorConfiguration(_ configuration: TextEditorConfiguration) -> TextEditorConfiguration {
    var configuration = configuration
    
    configuration.alignmentImages = [
      .left: ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_text_align_left")),
      .center: ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_text_align_center")),
      .right: ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_text_align_right"))
    ]
    configuration.textBackgroundButton = ImageButtonConfiguration(
      imageConfiguration: ImageConfiguration(imageName: "ic_text_without_background"),
      selectedImageConfiguration: ImageConfiguration(imageName: "ic_text_with_background")
    )
    configuration.doneButton.textConfiguration.color = UIColor(red: 6, green: 188, blue: 193)
    configuration.fontButton.borderColor = UIColor(red: 6, green: 188, blue: 193).cgColor
    configuration.fontButton.textConfiguration.color = UIColor(red: 6, green: 188, blue: 193)
    
    return configuration
  }
}

extension ViewController: BanubaVideoEditorSDKDelegate {
  func videoEditorDidCancel(_ videoEditor: BanubaVideoEditorSDK) {
    videoEditor.dismissVideoEditor(animated: true, completion: nil)
  }
  
  func videoEditorDone(_ videoEditor: BanubaVideoEditorSDK) {
    videoEditor.dismissVideoEditor(animated: true, completion: nil)
  }
}
