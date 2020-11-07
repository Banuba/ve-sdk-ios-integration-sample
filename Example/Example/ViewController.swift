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
    
    config.galleryConfiguration = updateGalleryConfiguration(config.galleryConfiguration)
    config.slideShowConfiguration = updateSlideShowConfiguration(config.slideShowConfiguration)
    
    return config
  }
  
  private func updateGalleryConfiguration(_ configuration: GalleryConfiguration) -> GalleryConfiguration {
    var configuration = configuration
    
    configuration.multiselectButtonConfiguration = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "multi_choise"))
    configuration.cancelMultiselectButtonConfiguration = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "cancel_cross"))
    configuration.backButtonConfiguration = BackButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "back_arrow"))
    
    return configuration
  }
  
  private func updateSlideShowConfiguration(_ configuration: SlideShowConfiguration) -> SlideShowConfiguration {
    var configuration = configuration
    
    configuration.clearSelectionButtonConfiguration = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "cancel_cross"))
    configuration.closeButtonConfiguration = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "back_arrow"))
    
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
