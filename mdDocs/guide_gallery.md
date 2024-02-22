# Gallery integration guide

> [!CAUTION]
> This documentation is deprecated and no longer updated.
> Please check out our [new website](https://docs.banuba.com/ve-pe-sdk/docs/ios/guide_gallery) with latest documentation.

- [Add module](#Add-module)
- [Customize default gallery](#Customize-default-gallery)
- [Implement custom gallery](#Implement-custom-gallery)
- [Progress screen](#Progress-screen)

## Add module
Video Editor SDK includes built in solution for the gallery where the user can pick any video or image and use it while making video.  
To connect Banuba Gallery screen and its functionality you need to add the dependency in [Podfile](../Example/Podfile#L22) file.
```Podfile
banuba_sdk_version = '1.30.2'

pod 'BanubaVideoEditorGallerySDK', banuba_sdk_version #optional
```

## Customize default gallery
The gallery is used in app when you want to select a photo or video stored on your phone.
Implement ```GalleryConfiguration```  and set it to ```VideoEditorConfig.combinedGalleryConfiguration``` to customize gallery.  

## Implement custom gallery
Please follow these steps to integrate you gallery into the SDK.

### Step 1
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

### Step 2
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

### Step 3
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
