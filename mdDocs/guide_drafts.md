# Drafts guide

```DraftsService``` class is used for managing drafts.

```swift
/// External Draft of video session
typealias ExternalDraft = VideoSequence

/// Allows you to manage drafts
class DraftsService {
  
  /// Get drafted video sequences
  func getDrafts() -> [ExternalDraft]
  
  /// Remove specific video sequence
  /// - parameters:
  ///  - externalDraft: Drafted video sequence
  func removeExternalDraft(_ externalDraft: ExternalDraft) -> Bool
  
  /// Get preview for specific drafted video sequence
  /// - parameters:
  ///  - externalDraft: Drafted video sequence
  ///  - thumbnailHeight: Preview height
  ///  - completion: Completion when preview UIImage generated
  func getPreviewForVideoSequence(
    _ externalDraft: ExternalDraft,
    thumbnailHeight: CGFloat,
    completion: ((_ preview: UIImage?) -> Void)?
  )
}
```

To get the instance of ```DraftsService```  use the ```BanubaVideoEditor``` instance.

***Example of usage:***
```swift
let videoEditorSDK = BanubaVideoEditor(...) // Initialization of main entity
let drafts = videoEditorSDK?.draftsService.getDrafts() // Get drafts list

let draft = drafts.first!

// Get draft preview
videoEditorSDK?.draftsService.getPreviewForVideoSequence(
  // Choosen draft from list of drafts
  draft,
  // Default config, where config is VideoEditorConfig instance
  thumbnailHeight: config.videoResolutionConfiguration.currentThumbnailHeight, 
  completion: { preview in
    // Preview usage
  }
)

// Remove draft and use returned value to your own condition usage if needed
let _ = videoEditorSDK?.draftsService.removeVideoSequence(videoSequence)

// Open Video Editor with preselected draft
let draftedConfig = VideoEditorLaunchConfig.DraftedLaunchConfig(
  // Choosen draft from list of drafts 
  externalDraft: draft,
  // Any case from DraftsFeatureConfig entity
  draftsConfig: .enabled
)
          
let config = VideoEditorLaunchConfig(
  entryPoint: .editor,
  hostController: self,
  draftedLaunchConfig: draftedConfig,
  animated: true
)
          
// Present Video Editor
self.videoEditorSDK?.presentVideoEditor(
  withLaunchConfiguration: config,
  completion: nil
)
```
