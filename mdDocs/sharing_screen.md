# Sharing screen

**Feature is available since 1.24.2**

## Overview

Sharing screen is an **optional** screen which can be added to the application in order to add Facebook sharing flow just after video export.

## Implementation

Sharing screen could be configured by `SharingScreenConfiguration` which is provided together with `presentSharingViewController` entire parameter. 

To utilize this screen in your application you should follow the next steps:

- to be able to present sharing screen you need to call `presentSharingViewController` from `BanubaVideoEditor` instance.
```swift
  /// Modally presents Video editor's sharing video view controller
  /// - Parameters:
  ///   - hostController: The view controller to display over.
  ///   - configuration: Sharing view controller configuration.
  ///   - mainVideoUrl: Main video to share with facebook and instagram.
  ///   - videoUrls: Set of video urls to share with sharing iOS controller if needed.
  ///   - animated: Pass true to animate the presentation.
  ///   - completion: The block to execute after the feedback buttons tapped finishes.
  static public func presentSharingViewController(
    from hostController: UIViewController,
    configuration: SharingScreenConfiguration,
    mainVideoUrl: URL,
    videoUrls: [URL],
    previewImage: UIImage,
    animated: Bool,
    completion: (() -> Void)?
  )
```

## Customization

Sharing screen has following customizable theme attributes:

``` swift
/// Sharing screen configurations
public struct SharingScreenConfiguration {
  /// Background view configuration
  public let backgroundConfiguration: BackgroundConfiguration
  /// Setups corner radius for playback gif presentation
  public let videoImageViewCornerRadius: CGFloat
  /// Text configuration for main title of the screen
  public let sharingVideoTextConfiguration: TextConfiguration
  /// Configuration for back button style
  public let closeButtonConfiguration: RoundedButtonConfiguration
  /// Array for sharing model services
  public let sharingModels: [SharingServiceModel]
  /// Setups styles for sharing model cells
  public let sharingCellConfiguration: SharingCellConfiguration
  /// Facebook Id
  public let facebookId: String
```

`backgroundConfiguration`, `videoImageViewCornerRadius`, `sharingVideoTextConfiguration`, `closeButtonConfiguration`, `sharingCellConfiguration` are the part of UI customization.

`sharingModels` describes what kind of sharing services available at sharing screen.
`facebookId` is required option for Facebook reels and stories.
