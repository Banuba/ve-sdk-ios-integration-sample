import UIKit
import BanubaMusicEditorSDK

class EffectPickerViewController: UIViewController, EffectSelectionViewController {
  
  weak var delegate: EffectSelectionViewControllerDelegate?
  
  var readyFiles = [URL]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let documentsUrl = Bundle.main.bundleURL.appendingPathComponent("Music/short")
    let directoryContents = try? FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil)
    let wavFiles = directoryContents?.filter{ $0.pathExtension == "wav" }
    readyFiles = wavFiles!
  }
  
  @IBAction func closeEffectSelection(_ sender: UIButton) {
    delegate?.effectSelectionViewControllerDidCancel(viewController: self)
  }
}

extension EffectPickerViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return readyFiles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "EffectCell", for: indexPath)
    cell.textLabel?.text = readyFiles[indexPath.row].lastPathComponent
    cell.backgroundColor = .systemTeal
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.effectSelectionViewController(
      viewController: self,
      didSelectFile: readyFiles[indexPath.row],
      title: readyFiles[indexPath.row].lastPathComponent,
      id: Int64.random(in: 6..<1000))
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }
}
