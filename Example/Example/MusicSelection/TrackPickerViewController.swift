import UIKit
import BanubaMusicEditorSDK

class TrackPickerViewController: UIViewController, TrackSelectionViewController {
  
  weak var trackSelectionDelegate: TrackSelectionViewControllerDelegate?
  
  var readyFiles = [URL]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let documentsUrl = Bundle.main.bundleURL.appendingPathComponent("Music/long")
    let directoryContents = try? FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil)
    let wavFiles = directoryContents?.filter{ $0.pathExtension == "wav" }
    readyFiles = wavFiles!
  }
  
  @IBAction func closeTrackSelection(_ sender: UIButton) {
    trackSelectionDelegate?.trackSelectionViewControllerDidCancel(viewController: self)
  }
}

extension TrackPickerViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return readyFiles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath)
    cell.textLabel?.text = readyFiles[indexPath.row].lastPathComponent
    cell.backgroundColor = .systemTeal
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    trackSelectionDelegate?.trackSelectionViewController(
      viewController: self,
      didSelectFile: readyFiles[indexPath.row],
      isEditable: true,
      title: readyFiles[indexPath.row].lastPathComponent,
      additionalTitle: "Additional title",
      uuid: UUID()
    )
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }
}
