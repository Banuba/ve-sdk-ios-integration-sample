# Gallery integration guide

- [Add module](#Add-module)
- [Customize default gallery](#Customize-default-gallery)
- [Implement custom gallery](#Implement-custom-gallery)
- [Progress screen](#Progress-screen)

## Add module
Video Editor SDK includes built in solution for the gallery where the user can pick any video or image and use it while making video.  
To connect Banuba Gallery screen and its functionality you need to add the dependency in [Podfile](../Example/Podfile#L22) file.
```Podfile
banuba_sdk_version = '1.26.6'

pod 'BanubaVideoEditorGallerySDK', banuba_sdk_version #optional
```

## Customize default gallery
The gallery is used in app when you want to select a photo or video stored on your phone.
Implement ```GalleryConfiguration```  and set it to ```VideoEditorConfig.combinedGalleryConfiguration``` 
to customize gallery.  
You can use allowed properties

- [videoResolution](../Example/Example/VideoEditorModule.swift#L396) - editor options for rendering video
- [galleryItemConfiguration](../Example/Example/VideoEditorModule.swift#L398) - gallery item style for collection view cell
- [visibleTabsInGallery](../Example/Example/VideoEditorModule.swift#L415) - visible tabs for gallery
- [closeButtonConfiguration](../Example/Example/VideoEditorModule.swift#L406) - close button style
- [albumButtonConfiguration](../Example/Example/VideoEditorModule.swift#L407) - album button style
- [collectionInfoHeaderConfiguration](../Example/Example/VideoEditorModule.swift#L396) - gallery header view
- [nextButtonConfiguration](../Example/Example/VideoEditorModule.swift#L408) - next button style
- [noItemsLabelConfiguration](../Example/Example/VideoEditorModule.swift#L409) - 'no photos' and 'no videos' label title style
- [layoutConfiguration](../Example/Example/VideoEditorModule.swift#L410) - collection view layout for gallery items
- [topBarBlurColor](../Example/Example/VideoEditorModule.swift#L411) - top bar blur color
- [clearSelectionButtonConfiguration](../Example/Example/VideoEditorModule.swift#L412) - clear selection button style
- [galleryTypeButton](../Example/Example/VideoEditorModule.swift#L413) - gallery type buttons' style
- [galleryTypeUnderlineColor](../Example/Example/VideoEditorModule.swift#L414) - color for underline view
- [isPhotoSequenceAnimationEnabled](../Example/Example/VideoEditorModule.swift#L396) - should use animation for photo sequences
- [importItemsLabelConfiguration](../Example/Example/VideoEditorModule.swift#L396) - import items label style
- [bottomViewConfiguration](../Example/Example/VideoEditorModule.swift#L396) - bottom view
- [visibleTabsInGallery](../Example/Example/VideoEditorModule.swift#L415) - visible tabs for gallery
- [isCloseButtonHidden](../Example/Example/VideoEditorModule.swift#L396) - describes if close button hidden
- [backgroundColor](../Example/Example/VideoEditorModule.swift#L396) - view background color
- [maximumSelectedCountFromGallery](../Example/Example/VideoEditorModule.swift#L396) - the maximum number of items can be selected from gallery

![img](screenshots/Gallery.png)

![img](screenshots/GalleryLocalization.png)

| Key        |      Value      |   Description |
| ------------- | :----------- | :------------- |
| No matching files found in gallery | No matching files found in gallery | No photo in the combined gallery
| No matching photos found in gallery | No photos found | No photo in gallery
| No matching video found in gallery | No videos found | No video in gallery
| Too much, %d - max number of photos | Too much, %d - max number of photos | User selected too many photos in the gallery
| You can choose %i videos | You can choose %i videos | Shown when the user tries to add a file to import beyond what is possible
| Error loading images | Error loading images | Failed to download photos for slideshow
| Failed to create video | Failed to create video | Failed to export a video
| BanubaVideoEditor.Gallery.ImageTabTitle | Image | Gallery image tab title
| BanubaVideoEditor.Gallery.VideoTabTitle | Video | Gallery video tab title
| BanubaVideoEditor.Gallery.AllPhotosTitle | All Photos | Gallery custom All Photos title
| BanubaVideoEditor.Gallery.RecentPhotosTitle | Recent | Gallery Recent Photos title
| BanubaVideoEditor.Gallery.SelectItems | Select items | Gallery selection hint
| BanubaVideoEditor.Gallery.ImportSingleVideo | Import 1 video | Import single video template
| BanubaVideoEditor.Gallery.ImportMultipleVideos | Import %d videos | Import multiple videos template
| BanubaVideoEditor.Gallery.ImportSingleImage | Import 1 image | Import single image template
| BanubaVideoEditor.Gallery.ImportMultipleImages | Import %d images | Import multiple images template


## Implement custom gallery
Please follow these steps to integrate you gallery into the SDK.

## Step 1
Implement custom `UIViewController` inherited from `GalleryViewController`

```swift
    @objc open class GalleryViewController: UIViewController {
        open weak var delegate: GalleryViewControllerDelegate?
        open var configuration: GalleryConfiguration?
        open var selectionBehaviour: GallerySelectionBehaviour?
        /// Setups new album at gallery
        open func useAlbum(_ albumModel: AlbumModel) {}
        /// Cancel current export
        open func cancelExport() {}
        /// Retry export failed items
        open func retryExport() {}
    }
```

- `delegate`- use this property to notify Video Editor SDK about user actions in custom gallery.

  Below is the list of possible actions:
    ```swift
        // MARK: - GalleryViewControllerDelegate
        @objc public protocol GalleryViewControllerDelegate: AnyObject {
            /// Tells delegate object about starting asynchronous operations at the gallery.
            /// BanubaVideoEditorSDK showing full-screen spinner by this event. It can help to prevent unnecessary actions from a user.
            func galleryViewController(_ controller: GalleryViewController, didStartExportWith progressHandler: ProgressHandler)
            /// Tells delegate object about finishing asynchronous operations at the gallery
            func galleryViewController(_ controller: GalleryViewController, didEndExportWith error: Error?, hideProgressViewCompletion: @escaping () -> Void)
            /// Tells delegate object about the closing gallery.
            func galleryViewControllerDidClose(_ controller: GalleryViewController)
            /// Tells delegate object about completion picking gallery items.
            func galleryViewControllerDone(
                _ controller: GalleryViewController,
                withGalleryItems items: [GalleryItem]
            )
            /// Tells delegate object that he should present message.
            /// In BanubaVideoEditorSDK it presents popup message.
            func galleryViewController(
                _ controller: GalleryViewController,
                presentMessage message: String
            )
        }
    ```

- `configuration` contains UI configuration. All details you can find [here](#Customize-default-gallery)
- `selectionBehaviour` contains gallery settings

    ```swift
        /// Setups gallery selection behaviour
        @objc public class GallerySelectionBehaviour: NSObject {
            /// Maximum possible selected gallery items quantity which can select a user.
            public let maximumSelectedCount: Int
            /// Setups already selected items quantity if gallery open as a picker at trimmer sceen or other cases.
            /// Use this field to control maximum selection items.
            public let selectedItemsCount: Int?
            /// Setups picker mode if isMultiselectModeEnabled is false.
            /// Otherwise, multiselection mode enabled.
            public let isMultiselectModeEnabled: Bool
            /// Setups gallery video duration fetched from user gallery supported by BanubaVideoEditorSDK.
            /// By default is 3.0
            public let minimumGalleryVideoDuration: TimeInterval
            /// Setups allowed media types which user can select in gallery
            public let allowedMediaTypes: [GalleryMediaType]
        }

    @objc public enum GalleryMediaType: Int, CaseIterable {
        case video
        case photo
    }
    ```

`GalleryItem` protocol which your items should conform to pass gallery selection result to `BanubaVideoEditorSDK`

```swift
    @objc public protocol GalleryItem: NSObjectProtocol {
        /// Video representation url asset
        var urlAsset: AVURLAsset? { get }
        /// Preview for gallery item
        var preview: UIImage? { get set }
        /// GalleryItem duration
        var duration: TimeInterval { get }
        /// Type can be video, photo or unknown
        var type: GalleryItemType { get }
          
        /// Requests preview for displaying in gallery list
        func requestPreview(
            size: CGSize,
            handler: @escaping (UIImage?) -> Void
        )
        /// Requests photo with desired size
        func requestPhoto(
            size: CGSize,
            progressHandler: ((Double) -> (Bool))?,
            handler: @escaping (UIImage?, Error?) -> Void
        )
        /// Requests video url asset
        func requestAVURLAsset(
            progressHandler:((Double) -> (Bool))?,
            handler: @escaping (AVURLAsset?, Error?) -> Void
        )
        /// Requests video player item
        func requestAVPlayerItem(
          progressHandler: ((Double) -> (Bool))?,
          handler: @escaping (AVPlayerItem?, Error?) -> Void
        )
    }
```

## Step 2
Implement custom `UIViewController` inherited from `AlbumsViewController`

```swift
    @objc open class AlbumsViewController: UIViewController {
        open weak var delegate: AlbumsViewControllerDelegate?
        open var configuration: AlbumsConfiguration?
        open var selectedAlbum: AlbumModel?
    }
```

- `delegate` notifies `BanubaVideoEditorSDK` about actions that happens in Albums. There are possible actions:

```swift
    @objc public protocol AlbumsViewControllerDelegate: AnyObject {
        /// Tells delegate object about selection the new album
        func albumsViewController(_ controller: AlbumsViewController, didSelect album: AlbumModel)
        // Tells delegate object about close action
        func albumsViewControllerDidClose(_ controller: AlbumsViewController)
    }
```

- `configuration` is simple configuration with `TextButtonConfiguration` and `BackButtonConfiguration` configurations.
- `selectedAlbum` entity contains information about currently selected album:

```swift
    @objc public protocol AlbumModel {
        /// Album name
        var name: String? { get set }
        /// Album preview
        var preview: UIImage? { get set }
        /// Assosiated asset collection with album
        var assetCollection: PHAssetCollection { get }
    }
```

## Step 3
Provide your custom gallery to `BanubaVideoEditorSDK`. Please follow these steps:
- Create your own viewControllerFactory conforms `GalleryViewControllerFactory`

```swift
    @objc public protocol GalleryViewControllerFactory: NSObjectProtocol {
        /// Creates GalleryViewController
        func makeGalleryViewController(
            withConfiguration configuration: GalleryConfiguration,
            selectionBehaviour: GallerySelectionBehaviour
        ) -> GalleryViewController
    }
    
    class MyGalleryViewControllerFactory: NSObject, GalleryViewControllerFactory {
        func makeGalleryViewController(
            withConfiguration configuration: BanubaUtilities.GalleryConfiguration,
            albumsConfiguration: BanubaUtilities.AlbumsConfiguration,
            selectionBehaviour: BanubaUtilities.GallerySelectionBehaviour
        ) -> BanubaUtilities.GalleryViewController {
          let controller = UIStoryboard(
          name: String(describing: UIViewController.self),
          bundle: Bundle(for: UIViewController.self)
          ).instantiateInitialViewController() as! UIViewController
          return controller
        }
    }
```

- Paste your factory to `BanubaVideoEditor` init

```swift
    /// Example video editor view controller factory
    class ViewControllerFactory: ExternalViewControllerFactory {
        var musicEditorFactory: MusicEditorExternalViewControllerFactory?
        var countdownTimerViewFactory: CountdownTimerViewFactory?
        var exposureViewFactory: AnimatableViewFactory?
        
        //MARK: - ExternalViewControllerFactory protocols variale
        var galleryViewControllerFactory: GalleryViewControllerFactory?
    }
    ...
    let viewControllerFactory = ViewControllerFactory()
    // Paste your custom factory to externalViewControllerFactory
    viewControllerFactory.galleryViewControllerFactory = MyGalleryViewControllersFactory()
                
    videoEditorSDK = BanubaVideoEditor(
        token: token,
        configuration: config,
        externalViewControllerFactory: viewControllerFactory
    )
```


## Progress screen

```ProgressViewController``` shows progress while long asynchronous task is in progress i.e. import media from gallery or export media content. Follow this guide to customize. ProgressView. To apply customization for Gallery you have to update appropriate configuration in VideoEditorConfiguration. To apply customization for Export process refer to these lines

![img](screenshots/ProgressViewConfiguration.png)

Implement ```ProgressViewConfiguration```  and set it to ```VideoEditorConfig.progressViewConfiguration``` 
to customize progress.  
You can use allowed properties

- [messageConfiguration](../Example/Example/VideoEditorModule.swift#L471) - message title
- [tooltipMessageConfiguration](../Example/Example/VideoEditorModule.swift#L142) - tooltip message
- [cancelButtonTextConfiguration](../Example/Example/VideoEditorModule.swift#L139) - cancel button text
- [cancelButtonBorderConfiguration](../Example/Example/VideoEditorModule.swift#L138) - cancel button border 
- [cancelButtonBackgroundConfiguration](../Example/Example/VideoEditorModule.swift#L134) - cancel button background
- [backgroundConfiguration](../Example/Example/VideoEditorModule.swift#134) - progress background
- [backgroundViewBlurStyle](../Example/Example/VideoEditorModule.swift#L134) - background view blur style
- [progressBarColor](../Example/Example/VideoEditorModule.swift#L134) - progress bar color
- [progressBarHeight](../Example/Example/VideoEditorModule.swift#L135) - progress bar height
- [progressBarCornerRadius](../Example/Example/VideoEditorModule.swift#L136) - progress bar corner radius

| Key        |      Value      |   Description |
| ------------- | :----------- | :------------- |
| com.banuba.alert.progressView.agreeButtonTitle | Retry | Retry button title in alert
| com.banuba.alert.progressView.disagreeButtonTitle | Cancel | Ability to cancel
| com.banuba.alert.progressView.importingMedia | Importing media | Message about importing media in gallery
| com.banuba.alert.progressView.exportingVideo | Exporting video | Exporting video message
| com.banuba.alert.progressView.tooltipMessage | Please, don't lock your screen or switch to other apps | Tooltip message for a user
| com.banuba.alert.progressView.exportVideoInterrupted | Export interrupted | Message about error interrupting export process

Failed async operation alert
![img](screenshots/ContentUploadingFailedAlert.png)
