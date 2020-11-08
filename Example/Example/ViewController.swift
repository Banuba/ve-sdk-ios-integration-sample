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
    
    config.videoCoverSelectionConfiguration = updateVideCoverSelectionConfiguration(config.videoCoverSelectionConfiguration)
    
    return config
  }
  
  private func updateVideCoverSelectionConfiguration(_ configuration: VideoCoverSelectionConfiguration) -> VideoCoverSelectionConfiguration {
    var configuration = configuration
    
    configuration.cancelButton = TextButtonConfiguration(
      style: TextConfiguration(
        font: UIFont.boldSystemFont(ofSize: 18.0),
        color: UIColor(red: 6, green: 188, blue: 193)
      ),
      text: "Cancel"
    )
    configuration.doneButton = RoundedButtonConfiguration(
      textConfiguration: TextConfiguration(
        font: UIFont.boldSystemFont(ofSize: 18.0),
        color: UIColor(red: 6, green: 188, blue: 193)
      ),
      cornerRadius: 0.0,
      backgroundColor: .clear
    )
    configuration.sliderColor = UIColor(red: 6, green: 188, blue: 193)
    configuration.sliderMinTrackTintColor = UIColor(red: 6, green: 188, blue: 193)
    configuration.toolTipLabel = TextConfiguration(
      kern: 0.0,
      font: UIFont.systemFont(ofSize: 16.0),
      color: .white,
      alignment: .left
    )
    
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
