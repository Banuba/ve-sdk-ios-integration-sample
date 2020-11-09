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
    
    config.trimGalleryVideoConfiguration = updateTrimGalleryVideoConfiguration(config.trimGalleryVideoConfiguration)
    config.multiTrimConfiguration = updateMultiTrimConfiguration(config.multiTrimConfiguration)
    config.singleTrimConfiguration = updateSingleTrimConfiguration(config.singleTrimConfiguration)
    
    return config
  }
  
  private func updateTrimGalleryVideoConfiguration(_ configuration: TrimGalleryVideoConfiguration) -> TrimGalleryVideoConfiguration {
    var configuration = configuration
    
    configuration.backButtonConfiguration = BackButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "back_arrow"))
    configuration.playerControlConfiguration = PlayerControlConfiguration(
      playButtonImageName: "ic_play",
      pauseButtonImageName: "ic_pause"
    )
    
    configuration.galleryVideoPartsConfiguration.addGalleryVideoPartImageName = "add_video_part"
    configuration.deleteGalleryVideoPartButtonConfiguration = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_delete_video_part"))
    
    configuration.nextButtonConfiguration.backgroundColor = .clear
    configuration.nextButtonConfiguration.textConfiguration.color = UIColor(red: 6, green: 188, blue: 193)
    
    configuration.editedTimeLabelConfiguration.errorColor = UIColor(red: 250, green: 62, blue: 118)
    
    return configuration
  }
  
  private func updateMultiTrimConfiguration(_ configuration: MultiTrimConfiguration) -> MultiTrimConfiguration {
    var configuration = configuration
    
    configuration.backButton = BackButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "back_arrow"))
    configuration.playerControlConfiguration = PlayerControlConfiguration(
      playButtonImageName: "ic_play",
      pauseButtonImageName: "ic_pause"
    )
    
    configuration.trimTimeLineConfiguration.draggerImageName = "trim_left"
    configuration.trimTimeLineConfiguration.doneButtonConfiguration.style.color = UIColor(red: 6, green: 188, blue: 193)
    configuration.trimTimeLineConfiguration.trimControlsColor = UIColor(red: 250, green: 62, blue: 118)
    
    configuration.saveButton.backgroundColor = .clear
    configuration.saveButton.textConfiguration.color = UIColor(red: 6, green: 188, blue: 193)
    
    configuration.editedTimeLabelConfiguration.errorColor = UIColor(red: 250, green: 62, blue: 118)
    
    return configuration
  }
  
  private func updateSingleTrimConfiguration(_ configuration: SingleTrimConfiguration) -> SingleTrimConfiguration {
    var configuration = configuration
    
    configuration.playerControlConfiguration = PlayerControlConfiguration(
      playButtonImageName: "ic_play",
      pauseButtonImageName: "ic_pause"
    )
    configuration.backButton = BackButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "back_arrow"))
    
    configuration.trimTimeLineConfiguration.draggerImageName = "trim_left"
    configuration.trimTimeLineConfiguration.trimControlsColor = UIColor(red: 250, green: 62, blue: 118)
    
    configuration.saveButton.backgroundColor = .clear
    configuration.saveButton.textConfiguration.color = UIColor(red: 6, green: 188, blue: 193)
    
    configuration.editedTimeLabelConfiguration.errorColor = UIColor(red: 250, green: 62, blue: 118)
    
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
