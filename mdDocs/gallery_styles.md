# Banuba VideoEditor SDK
## CombinedGalleryConfiguration

The CombinedGallery is used in app when you want to select a photo or video stored on your phone.

Use the properties below to customize the CombinedGallery.

- [videoResolution: VideoResolutionConfiguration](/Example/Example/Extension/CombinedGalleryConfiguration.swift#L7)

VideoResolutionConfiguration setups editor options for rendering video

- [visibleTabsInGallery: [GalleryMediaType]](/Example/Example/Extension/CombinedGalleryConfiguration.swift#L25)

GalleryMediaType setups visible tabs for gallery

- [galleryItemConfiguration: GalleryItemConfiguration](/Example/Example/Extension/CombinedGalleryConfiguration.swift#L8)

GalleryItemConfiguration setups gallery item style for collection view cell

- [closeButtonConfiguration: ImageButtonConfiguration](/Example/Example/Extension/CombinedGalleryConfiguration.swift#L16)

ImageButtonConfiguration setups close button style

- [albumButtonConfiguration: TextButtonConfiguration](/Example/Example/Extension/CombinedGalleryConfiguration.swift#L17)

TextButtonConfiguration setups album button style

- [nextButtonConfiguration: SaveButtonConfiguration](/Example/Example/Extension/CombinedGalleryConfiguration.swift#L18)

SaveButtonConfiguration setups next button style

- [noItemsLabelConfiguration: TextConfiguration](/Example/Example/Extension/CombinedGalleryConfiguration.swift#L19)
  
TextConfiguration setups 'no photos' and 'no videos' label title style

- [layoutConfiguration: GalleryLayoutConfiguration](/Example/Example/Extension/CombinedGalleryConfiguration.swift#L20)
  
GalleryLayoutConfiguration setups collection view layout for gallery items

- [topBarBlurColor: UIColor](/Example/Example/Extension/CombinedGalleryConfiguration.swift#L21)
 
Top bar blur color

- [clearSelectionButtonConfiguration: ImageButtonConfiguration](/Example/Example/Extension/CombinedGalleryConfiguration.swift#L22)
  
ImageButtonConfiguration setups clear selection button style

- [galleryTypeButton: TextButtonConfiguration](/Example/Example/Extension/CombinedGalleryConfiguration.swift#L23)
  
TextButtonConfiguration setups gallery type buttons' style

- [galleryTypeUnderlineColor: UIColor](/Example/Example/Extension/CombinedGalleryConfiguration.swift#L24)
  
Color for underline view

![img](screenshots/Gallery.png)

## String resources

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
