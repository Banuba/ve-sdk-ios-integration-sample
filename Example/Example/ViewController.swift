import UIKit
import BanubaVideoEditorSDK

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
    
    config.editorConfiguration = updateEditorConfiguration(config.editorConfiguration)
    
    return config
  }
  
  private func updateEditorConfiguration(_ configuration: EditorConfiguration) -> EditorConfiguration {
    var configuration = configuration
    
    configuration.additionalEffectsButtons = [
      AdditionalEffectsButtonConfiguration(
        identifier: .sticker,
        imageConfiguration: ImageConfiguration(imageName: "ic_stickers_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_stickers_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .text,
        imageConfiguration: ImageConfiguration(imageName: "ic_text_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_text_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .effects,
        imageConfiguration: ImageConfiguration(imageName: "ic_filters_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_filters_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .masks,
        imageConfiguration: ImageConfiguration(imageName: "ic_masks_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_masks_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .sound,
        imageConfiguration: ImageConfiguration(imageName: "ic_audio_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_audio_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .speed,
        imageConfiguration: ImageConfiguration(imageName: "ic_speed_effect_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_speed_effect_on")
      ),
      AdditionalEffectsButtonConfiguration(
        identifier: .color,
        imageConfiguration: ImageConfiguration(imageName: "ic_effects_off"),
        selectedImageConfiguration: ImageConfiguration(imageName: "ic_effects_on")
      )
    ]
    
    configuration.backButton = BackButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_nav_back_arrow"))
    configuration.playButtonImageName = "ic_play"
    
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
