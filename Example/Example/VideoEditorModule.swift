
import UIKit
import BanubaVideoEditorSDK

import VideoEditor
import AVFoundation
import AVKit
import Photos
import BSImagePicker
import VEExportSDK
import BanubaAudioBrowserSDK

// Adopting CountdownView to using in BanubaVideoEditorSDK
extension CountdownView: MusicEditorCountdownAnimatableView {}

class VideoEditorModule {
    
    fileprivate static let primaryColor = UIColor(red: 6 / 255, green: 188 / 255, blue: 193 / 255, alpha: 1)
    
    var videoEditorSDK: BanubaVideoEditor?
    
    var isVideoEditorInitialized: Bool { videoEditorSDK != nil }
    
    init(token: String) {
        let config = createConfiguration()
        let externalViewControllerFactory = createExampleExternalViewControllerFactory()
        
        let videoEditorSDK = BanubaVideoEditor(
            token: token,
            configuration: config,
            externalViewControllerFactory: externalViewControllerFactory
        )
        
        self.videoEditorSDK = videoEditorSDK
    }
    
    func presentVideoEditor(with launchConfig: VideoEditorLaunchConfig) {
        guard isVideoEditorInitialized else {
            print("BanubaVideoEditor is not initialized!")
            return
        }
        videoEditorSDK?.presentVideoEditor(
            withLaunchConfiguration: launchConfig,
            completion: nil
        )
    }
    
    func createExportConfiguration(destFile: URL) -> ExportConfiguration {
        let watermarkConfiguration = WatermarkConfiguration(
          watermark: ImageConfiguration(imageName: "Common.Banuba.Watermark"),
          size: CGSize(width: 204, height: 52),
          sharedOffset: 20,
          position: .rightBottom)
        
        let exportConfiguration = ExportVideoConfiguration(
          fileURL: destFile,
          quality: .auto,
          useHEVCCodecIfPossible: true,
          watermarkConfiguration: watermarkConfiguration
        )
        
        let exportConfig = ExportConfiguration(
          videoConfigurations: [exportConfiguration],
          isCoverEnabled: true,
          gifSettings: GifSettings(duration: 0.3)
        )
        
        return exportConfig
    }
    
    func createProgressViewController() -> ProgressViewController {
      let progressViewController = ProgressViewController.makeViewController()
      progressViewController.configuration = updateProgressViewConfiguration(progressViewController.configuration!)
      progressViewController.message = "Exporting"
      return progressViewController
    }
    
    func createConfiguration() -> VideoEditorConfig {
        var config = VideoEditorConfig()
        
        config.setupColorsPalette(
            VideoEditorColorsPalette(
                primaryColor: #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1),
                iconPrimaryCololor: #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1),
                secondaryColor: .black,
                accentColor: UIColor(red: 250, green: 62, blue: 118, alpha: 1)
            )
        )
         let mubertToken = "b308b0ad7d98e8869e043a1b5b5132b6fb909c7c"
         let mubertLicense = "banuba_sdkmubertlicense#eDfDLWJoMHIvsAS9EvcelXr1zkDyEQGLLvGsNukOQLcxSDw4mR8kdVYjXD6q0H0DZQj5hPtPlsK"
        // Set Mubert API KEYS here
        BanubaAudioBrowser.setMubertKeys(
            license: mubertLicense,
            token: mubertToken
        )
        AudioBrowserConfig.shared.musicSource = .allSources
        AudioBrowserConfig.shared.setPrimaryColor(#colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1))
        
        var featureConfiguration = config.featureConfiguration
        featureConfiguration.supportsTrimRecordedVideo = true
        featureConfiguration.isMuteCameraAudioEnabled = true
        config.updateFeatureConfiguration(featureConfiguration: featureConfiguration)
        
        // Video Recording
        config.recorderConfiguration = updateRecorderConfiguration(config.recorderConfiguration)
        config.isHandfreeEnabled = true
        config.handsfreeConfiguration = updateHandsfreeConfiguration(config.handsfreeConfiguration)
        
        // Gallery
        config.combinedGalleryConfiguration = updateCombinedGalleryConfiguration(config.combinedGalleryConfiguration)
        
  
        // Video Trimming
        config.trimVideoConfiguration = updateTrimVideoConfiguration(config.trimVideoConfiguration)
        config.trimVideosConfiguration = updateTrimVideosConfiguration(config.trimVideosConfiguration)
        config.aspectsConfiguration = updateAspectsConfiguration(config.aspectsConfiguration)
        
        // Video Editing
        config.editorConfiguration = updateEditorConfiguration(config.editorConfiguration)
        config.gifPickerConfiguration = updateGifPickerConfiguration(config.gifPickerConfiguration)
        config.textEditorConfiguration = updateTextEditorConfiguration(config.textEditorConfiguration)
        config.overlayEditorConfiguration = updateOverlayEditorConfiguraiton(config.overlayEditorConfiguration)
        
        // Progress
        config.progressViewConfiguration = updateProgressViewConfiguration(config.progressViewConfiguration)
        
        // Cover image
        config.extendedVideoCoverSelectionConfiguration = updateVideCoverSelectionConfiguration(config.extendedVideoCoverSelectionConfiguration)
        
        // Music editor
        config.musicEditorConfiguration = updateMusicEditorConfigurtion(config.musicEditorConfiguration)
        
        // Alert popups
        config.alertViewConfiguration = updateAlertViewConfiguration(config.alertViewConfiguration)
        
        // ???
        config.filterConfiguration = updateFilterConfiguration(config.filterConfiguration)
       
        // ???
        config.fullScreenActivityConfiguration = updateFullScreenActivityConfiguration(config.fullScreenActivityConfiguration)
        
        return config
    }
    
    func updateProgressViewConfiguration(_ configuration: ProgressViewConfiguration) -> ProgressViewConfiguration {
        configuration.progressBarColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        configuration.progressBarHeight = 2.0
        configuration.progressBarCornerRadius = 1.0
        
        configuration.cancelButtonBorderConfiguration.borderColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        configuration.cancelButtonTextConfiguration.style.color = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        
        configuration.messageConfiguration.color = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        configuration.tooltipMessageConfiguration.color = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        
        return configuration
    }
    
    private func updateOverlayEditorConfiguraiton(_ configuration: OverlayEditorConfiguration) -> OverlayEditorConfiguration {
        var updatedConfiguration = configuration
        updatedConfiguration.mainOverlayViewControllerConfig = updateMainOverlayViewConfiguration(configuration.mainOverlayViewControllerConfig)
        return updatedConfiguration
    }
    
    private func updateMainOverlayViewConfiguration(_ configuration: MainOverlayViewControllerConfig) -> MainOverlayViewControllerConfig {
        var updatedConfiguration = configuration
        
        updatedConfiguration.addButtons = [
            OverlayAddButtonConfig(
                type: .text,
                title: "Text",
                titleColor: .white,
                font: UIFont.systemFont(ofSize: 14.0),
                imageName: "ic_AddText"
            ),
            
            OverlayAddButtonConfig(
                type: .sticker,
                title: "Sticker",
                titleColor: .white,
                font: UIFont.systemFont(ofSize: 14.0),
                imageName: "ic_AddSticker"
            ),
            
            OverlayAddButtonConfig(
                type: .blur,
                title: "Circle",
                titleColor: .white,
                font: UIFont.systemFont(ofSize: 14.0),
                imageName: "circle_blur",
                drawableFigure: .circle
            ),
            
            OverlayAddButtonConfig(
                type: .blur,
                title: "Square",
                titleColor: .white,
                font: UIFont.systemFont(ofSize: 14.0),
                imageName: "square_blur",
                drawableFigure: .square
            )
        ]
        
        updatedConfiguration.editButtonsHeight = 50.0
        updatedConfiguration.editButtonsInteritemSpacing = 0.0
        
        updatedConfiguration.controlButtons = [
            OverlayControlButtonConfig(
                type: .reset,
                imageName: "ic_restart",
                selectedImageName: nil
            ),
            OverlayControlButtonConfig(
                type: .play,
                imageName: "ic_editor_play",
                selectedImageName: "ic_pause"
            ),
            OverlayControlButtonConfig(
                type: .done,
                imageName: "ic_done",
                selectedImageName: nil
            )
        ]
        
        updatedConfiguration.editCompositionButtons = [
            OverlayEditButtonConfig(
                type: .edit,
                title: "Edit",
                titleColor: .white,
                font: UIFont.systemFont(ofSize: 14.0),
                imageName: "ic_edit",
                selectedImageName: nil
            ),
            
            OverlayEditButtonConfig(
                type: .delete,
                title: "Delete",
                titleColor: .white,
                font: UIFont.systemFont(ofSize: 14.0),
                imageName: "ic_trash",
                selectedImageName: nil
            )
        ]
        
        updatedConfiguration.playerControlsHeight = 50.0
        updatedConfiguration.mainLabelColors = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        updatedConfiguration.additionalLabelColors = UIColor.white
        updatedConfiguration.additionalLabelFonts = UIFont.systemFont(ofSize: 12.0)
        updatedConfiguration.cursorColor = UIColor.white
        updatedConfiguration.audioWaveConfiguration.borderColor = UIColor.white
        updatedConfiguration.resizeImageName = "ic_cut_arrow"
        updatedConfiguration.draggersHorizontalInset = .zero
        updatedConfiguration.draggersHeight = 25.0
        updatedConfiguration.backgroundConfiguration.cornerRadius = .zero
        updatedConfiguration.playerControlsBackgroundConfiguration.cornerRadius = .zero
        updatedConfiguration.defaultLinesCount = 2
        updatedConfiguration.timelineCornerRadius = .zero
        updatedConfiguration.draggerBackgroundColor = UIColor.white
        updatedConfiguration.timeLabelsOffset = .zero
        updatedConfiguration.itemsTopOffset = .zero
        updatedConfiguration.draggerCornerRadius = nil
        updatedConfiguration.draggersImageHeight = 25.0
        updatedConfiguration.draggersWidth = nil
        
        return updatedConfiguration
    }
    
    private func updateTextEditorConfiguration(_ configuration: TextEditorConfiguration) -> TextEditorConfiguration {
        var updatedConfiguration = configuration
        
        updatedConfiguration.doneButton.textConfiguration?.color = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        updatedConfiguration.fontItemConfiguration = TextEditFontItemConfiguration(
            titleColor: #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1),
            fontSize: 14.0,
            cornerRadius: 4.0,
            backgroundColor: .clear,
            isBackgroundViewHidden: true
        )
        
        updatedConfiguration.textBackgroundButton = ImageButtonConfiguration(
            imageConfiguration: ImageConfiguration(imageName: "ic_text_without_background"),
            selectedImageConfiguration: ImageConfiguration(imageName: "ic_text_with_background")
        )
        
        updatedConfiguration.alignmentImages = [
            .left: ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_text_align_left")),
            .center: ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_text_align_center")),
            .right: ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_text_align_right"))
        ]
        
        updatedConfiguration.palette = [
            VideoTextColorPair(colors:( .clear, .white, .white, .darkGray)),
            VideoTextColorPair(colors:( .clear, .yellow, .yellow, .white)),
            VideoTextColorPair(colors:( .clear, .gray, .gray, .white))
        ]
        
        updatedConfiguration.fonts = [
            VideoTextFont(
                font: UIFont.systemFont(ofSize: 38),
                name: "Regular"
            ),
            VideoTextFont(
                font: UIFont.italicSystemFont(ofSize: 38),
                name: "Italic"
            ),
            VideoTextFont(
                font: UIFont.boldSystemFont(ofSize: 38),
                name: "Bold"
            )
        ]
        
        updatedConfiguration.additionalPaletteBackgroundConfiguration.cornerRadius = .zero
        updatedConfiguration.screenNameConfiguration.style = nil
        updatedConfiguration.palleteInsets = .zero
        
        updatedConfiguration.selectionColorBehavior = TextEditSelectionBorderAnimationBehavior(
            defaultBorderWidth: 3.0,
            selectedBorderWidth: 8.0
        )
        
        updatedConfiguration.colorItemConfiguration = TextEditColorItemConfiguration(
            borderColor: UIColor.white,
            borderWidth: 3.0
        )
        
        updatedConfiguration.fontItemConfiguration = TextEditFontItemConfiguration(
            titleColor: #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1),
            fontSize: 16.0,
            cornerRadius: 4.0,
            backgroundColor: .clear,
            isBackgroundViewHidden: false
        )
        
        return updatedConfiguration
    }
    
    private func updateGifPickerConfiguration(_ configuration: GifPickerConfiguration) -> GifPickerConfiguration {
        var updatedConfiguration = configuration
        updatedConfiguration.regularFont = UIFont.systemFont(ofSize: 16)
        updatedConfiguration.boldFont = UIFont.boldSystemFont(ofSize: 22)
        updatedConfiguration.activityConfiguration.activityLineWidth = 3.0
        updatedConfiguration.cursorColor = UIColor.white
        updatedConfiguration.giphyAPIKey = nil
        
        return updatedConfiguration
    }
    
    private func updateFilterConfiguration(_ configuration: FilterConfiguration) -> FilterConfiguration {
        var updatedConfiguration = configuration
        
        updatedConfiguration.resetButton.backgroundColor = Self.primaryColor
        updatedConfiguration.resetButton.cornerRadius = 6.0
        updatedConfiguration.resetButton.textConfiguration?.color = .white
        updatedConfiguration.toolTipLabel.color = .white
        updatedConfiguration.cursorButton = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_cursor"))
        
        updatedConfiguration.effectItemConfiguration.cornerRadius = 6.0
        
        updatedConfiguration.controlButtons = [
            FilterControlButtonConfig(type: .cancel, imageName: "ic_close", selectedImageName: nil),
            FilterControlButtonConfig(type: .play, imageName: "ic_editor_play", selectedImageName: "ic_pause"),
            FilterControlButtonConfig(type: .done, imageName: "ic_done", selectedImageName: nil),
        ]
        
        return updatedConfiguration
    }
    
    private func updateFullScreenActivityConfiguration(_ configuration: FullScreenActivityConfiguration) -> FullScreenActivityConfiguration {
        var updatedConfiguration = configuration
        
        updatedConfiguration.activityIndicator = SmallActivityIndicatorConfiguration(
            gradientType: .color(
                SmallActivityIndicatorConfiguration.GradientColorConfiguration(
                    angle: 0.0,
                    colors: [Self.primaryColor.cgColor, UIColor.white.cgColor]
                )
            ),
            activityLineWidth: 3.0
        )
        return updatedConfiguration
    }
    
    private func updateVideCoverSelectionConfiguration(_ configuration: VideoCoverSelectionConfiguration) -> VideoCoverSelectionConfiguration {
        var updatedConfiguration = configuration
        
        updatedConfiguration.cancelButton.backgroundColor = .clear
        updatedConfiguration.cancelButton.textConfiguration?.color = UIColor(
            red: 6, green: 188, blue: 193, alpha: 1
        )
        updatedConfiguration.doneButton.backgroundColor = .clear
        updatedConfiguration.doneButton.textConfiguration?.color = UIColor(
            red: 6, green: 188, blue: 193, alpha: 1
        )
        updatedConfiguration.titleLabel?.text = "Title cover"
        updatedConfiguration.toolTipLabel.text = "Tool tip tabel"
        updatedConfiguration.selectGalleryImageButton.titlePosition = .left
        updatedConfiguration.deleteImageButtonImageConfiguration.titlePosition = .top
        updatedConfiguration.backgroundConfiguration.color = UIColor.black
        updatedConfiguration.previewBackgroundConfiguration.color = .clear
        updatedConfiguration.thumbnailsCursorConfiguration.imageConfiguration = VideoEditor.ImageConfiguration(imageName: "thumb")
        updatedConfiguration.numberOfThumbnails = 12
        updatedConfiguration.preferredStatusBarStyle = .default
        return updatedConfiguration
    }
    
    private func updateCombinedGalleryConfiguration(_ configuration: GalleryConfiguration) -> GalleryConfiguration {
        configuration.videoResolution = .hd1920x1080
        configuration.nextButtonConfiguration.backgroundColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        configuration.galleryItemConfiguration.orderNumberBackgroudColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        configuration.galleryItemConfiguration.orderNumberTitleColor = UIColor.black
        configuration.galleryItemConfiguration.backgroundSelectionIndicatorImageName = "elipce"
        configuration.galleryItemConfiguration.hideSelectionIndicatorBySelection = true
        configuration.galleryItemConfiguration.durationLabelConfiguration.color = UIColor.white
        configuration.galleryItemConfiguration.durationLabelBackgroundColor = UIColor.clear
        configuration.galleryItemConfiguration.activityIndicatorConfiguration.activityLineWidth = 2.0
        configuration.galleryItemConfiguration.cornerRadius = 0.0
        configuration.closeButtonConfiguration.imageConfiguration = BanubaVideoEditorSDK.ImageConfiguration(imageName: "camera_control.back")
        configuration.albumButtonConfiguration.style.color = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        configuration.nextButtonConfiguration.text = "Next"
        configuration.noItemsLabelConfiguration.alignment = .center
        configuration.layoutConfiguration.numberOfItemsPerRow = 2
        configuration.topBarBlurColor = UIColor.yellow
        configuration.clearSelectionButtonConfiguration.imageConfiguration = BanubaVideoEditorSDK.ImageConfiguration(imageName: "camera_control.back")
        configuration.galleryTypeButton.style.color = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        configuration.galleryTypeUnderlineColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        configuration.visibleTabsInGallery = [.video, .photo]
        
        return configuration
    }
    
    private func updateEditorConfiguration(_ configuration: EditorConfiguration) -> EditorConfiguration {
        var updatedConfiguration = configuration
        
        updatedConfiguration.additionalEffectsButtons = [
            AdditionalEffectsButtonConfiguration(
                identifier: .sticker,
                imageConfiguration: ImageConfiguration(imageName: "ic_stickers_off"),
                selectedImageConfiguration: ImageConfiguration(imageName: "ic_stickers_on")
            ),
            AdditionalEffectsButtonConfiguration(
                identifier: .text,
                imageConfiguration: ImageConfiguration(imageName: "ic_text_off"),
                selectedImageConfiguration: ImageConfiguration(imageName: "ic_text_on")
            ),
            AdditionalEffectsButtonConfiguration(
                identifier: .effects,
                imageConfiguration: ImageConfiguration(imageName: "ic_effects_off"),
                selectedImageConfiguration: ImageConfiguration(imageName: "ic_effects_on")
            ),
            AdditionalEffectsButtonConfiguration(
                identifier: .masks,
                imageConfiguration: ImageConfiguration(imageName: "ic_masks_off"),
                selectedImageConfiguration: ImageConfiguration(imageName: "ic_masks_on")
            ),
            AdditionalEffectsButtonConfiguration(
                identifier: .sound,
                imageConfiguration: ImageConfiguration(imageName: "ic_audio_off"),
                selectedImageConfiguration: ImageConfiguration(imageName: "ic_audio_on")
            ),
            AdditionalEffectsButtonConfiguration(
                identifier: .time,
                imageConfiguration: ImageConfiguration(imageName: "ic_speed_effects_off"),
                selectedImageConfiguration: ImageConfiguration(imageName: "ic_speed_effects_on")
            ),
            AdditionalEffectsButtonConfiguration(
                identifier: .color,
                imageConfiguration: ImageConfiguration(imageName: "ic_filters_off"),
                selectedImageConfiguration: ImageConfiguration(imageName: "ic_filters_on")
            ),
            AdditionalEffectsButtonConfiguration(
                identifier: .blur,
                imageConfiguration: ImageConfiguration(imageName: "blur_inactive"),
                selectedImageConfiguration: ImageConfiguration(imageName: "blur_active")
            )
        ]
        
        updatedConfiguration.additionalEffectsButtonsBottomOffset = 0.0
        updatedConfiguration.videoResolution = VideoResolutionConfiguration(
            default: .hd1920x1080,
            resolutions: [
                .iPhone5s: .hd1280x720,
                .iPhone6: .default854x480,
                .iPhone6s: .hd1280x720,
                .iPhone6Plus: .default854x480,
                .iPhone6sPlus: .hd1280x720,
                .iPhoneSE: .hd1280x720,
            ],
            thumbnailHeights: [
                .iPhone5s: 200.0,
                .iPhone6: 80.0,
                .iPhone6s: 200.0,
                .iPhone6Plus: 80.0,
                .iPhone6sPlus: 200.0,
                .iPhoneSE: 200.0,
            ],
            defaultThumbnailHeight: 400.0
        )
        
        updatedConfiguration.saveButton.background.color = Self.primaryColor
        updatedConfiguration.saveButton.background.cornerRadius = 4.0
        updatedConfiguration.saveButton.width = 68.0
        updatedConfiguration.saveButton.height = 42.0
        updatedConfiguration.saveButton.title.style.color = .white
        
        updatedConfiguration.backButton = BackButtonConfiguration(imageConfiguration: BanubaVideoEditorSDK.ImageConfiguration(imageName: "ic_nav_back_arrow"))
        
        return updatedConfiguration
    }
    
    private func updateMusicEditorConfigurtion(_ configuration: MusicEditorConfig) -> MusicEditorConfig {
        var updatedConfiguration = configuration
        
        updatedConfiguration.mainMusicViewControllerConfig = updateMainMusicViewConfiguration(configuration.mainMusicViewControllerConfig)
        updatedConfiguration.audioRecorderViewControllerConfig = updateAudioRecorderViewConfiguration(configuration.audioRecorderViewControllerConfig)
        updatedConfiguration.audioTrackLineEditControllerConfig = updateAudioTrackLineEditConfiguration(configuration.audioTrackLineEditControllerConfig)
        updatedConfiguration.videoTrackLineEditControllerConfig = updateVideoTrackLineEditConfiguration(configuration.videoTrackLineEditControllerConfig)
        
        /// Provides voice filters which can be applied for voice recording at music editor screen
        struct ExampleVoiceFilterProvider: VoiceFilterProvider {
            func provideFilters() -> [VoiceFilter] {
                return  [
                    VoiceFilter(type: .elf, title: NSLocalizedString("com.banuba.musicEditor.elf", comment: "Elf filter title"), image: UIImage(named:"elf")),
                    VoiceFilter(type: .baritone, title: NSLocalizedString("com.banuba.musicEditor.baritone", comment: "Baritone filter title"), image: UIImage(named:"baritone")),
                    VoiceFilter(type: .echo, title: NSLocalizedString("com.banuba.musicEditor.echo", comment: "Echo filter title"), image: UIImage(named:"echo")),
                    VoiceFilter(type: .giant, title: NSLocalizedString("com.banuba.musicEditor.giant", comment: "Giant filter title"), image: UIImage(named:"giant")),
                    VoiceFilter(type: .robot, title: NSLocalizedString("com.banuba.musicEditor.robot", comment: "Robot filter title"), image: UIImage(named:"robot")),
                    VoiceFilter(type: .squirrel, title: NSLocalizedString("com.banuba.musicEditor.squirrel", comment: "Squirrel filter title"), image: UIImage(named:"squirrel"))
                ]
            }
        }
        
        updatedConfiguration.audioTrackLineEditControllerConfig.voiceFilterProvider = ExampleVoiceFilterProvider()
        
        return updatedConfiguration
    }
    
    private func updateMainMusicViewConfiguration(_ configuration: MainMusicViewControllerConfig) -> MainMusicViewControllerConfig {
        var updatedConfiguration = configuration
        
        updatedConfiguration.editButtons = [
            EditButtonConfig(
                font: UIFont.systemFont(ofSize: 14.0),
                type: .track,
                title: "Tracks",
                titleColor: #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1),
                imageName: "ic_tracks"
            ),
            EditButtonConfig(
                font: UIFont.systemFont(ofSize: 14.0),
                type: .effect,
                title: "Effects",
                titleColor: #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1),
                imageName: "ic_effects"
            ),
            EditButtonConfig(
                font: UIFont.systemFont(ofSize: 14.0),
                type: .record,
                title: "Record",
                titleColor: #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1),
                imageName: "ic_voice_recording"
            ),
            EditButtonConfig(
                font: UIFont.systemFont(ofSize: 14.0),
                type: .volume,
                title: "Volume",
                titleColor: #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1),
                imageName: "ic-volume"
            )
        ]
        
        updatedConfiguration.editButtonsHeight = 50.0
        
        updatedConfiguration.editCompositionButtons = [
            EditCompositionButtonConfig(
                font: UIFont.systemFont(ofSize: 14.0),
                type: .voiceEffect,
                title: "Voice",
                titleColor: #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1),
                imageName: "voice",
                selectedImageName: nil
            ),
            EditCompositionButtonConfig(
                font: UIFont.systemFont(ofSize: 14.0),
                type: .edit,
                title: "Edit",
                titleColor: #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1),
                imageName: "ic_edit",
                selectedImageName: nil
            ),
            EditCompositionButtonConfig(
                font: UIFont.systemFont(ofSize: 14.0),
                type: .delete,
                title: "Delete",
                titleColor: #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1),
                imageName: "ic_trash",
                selectedImageName: nil
            )
        ]
        
        updatedConfiguration.controlButtons = [
            ControlButtonConfig(
                type: .reset,
                imageName: "ic_restart",
                selectedImageName: nil
            ),
            ControlButtonConfig(
                type: .play,
                imageName: "ic_editor_play",
                selectedImageName: "ic_pause"
            ),
            ControlButtonConfig(
                type: .done,
                imageName: "ic_done",
                selectedImageName: nil
            )
        ]
        
        updatedConfiguration.playerControlsHeight = 50.0
        updatedConfiguration.audioWaveConfiguration.isRandomWaveColor = true
        updatedConfiguration.mainLabelColors = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        updatedConfiguration.additionalLabelColors = UIColor.black
        updatedConfiguration.tracksLimit = 5
        updatedConfiguration.cursorColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        updatedConfiguration.controlsBackgroundConfiguration.cornerRadius = 0.0
        updatedConfiguration.backgroundConfiguration.cornerRadius = 0.0
        updatedConfiguration.timelineCornerRadius = 0.0
        
        return updatedConfiguration
    }
    
    private func updateAudioRecorderViewConfiguration(_ configuration: AudioRecorderViewControllerConfig) -> AudioRecorderViewControllerConfig {
        var updatedConfiguration = configuration
        
        updatedConfiguration.rewindToStartButton = ControlButtonConfig(
            type: .reset,
            imageName: "ic_restart",
            selectedImageName: nil
        )
        
        updatedConfiguration.playPauseButton = ControlButtonConfig(
            type: .play,
            imageName: "ic_editor_play",
            selectedImageName: "ic_pause"
        )
        
        updatedConfiguration.playerControlsHeight = 50.0
        
        updatedConfiguration.recordButton = ControlButtonConfig(
            type: .play,
            imageName: "ic_start_recording",
            selectedImageName: "ic_pause_recording"
        )
        
        updatedConfiguration.backButtonImage = "ic_close"
        updatedConfiguration.doneButtonImage = "ic_done"
        updatedConfiguration.dimViewColor = #colorLiteral(red: 0.3176470588, green: 0.5960784314, blue: 0.8549019608, alpha: 0.2039811644)
        updatedConfiguration.additionalLabelColors = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        updatedConfiguration.startingRecordingTimerSeconds = 0.0
        updatedConfiguration.timerColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        updatedConfiguration.cursorColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        updatedConfiguration.backgroundConfiguration.cornerRadius = 0.0
        updatedConfiguration.playerControlsBackgroundConfiguration.cornerRadius = 0.0
        updatedConfiguration.timelineCornerRadius = 0.0
        
        return updatedConfiguration
    }
    
    private func updateVideoTrackLineEditConfiguration(_ configuration: VideoTrackLineEditViewControllerConfig) -> VideoTrackLineEditViewControllerConfig {
        var updatedConfiguration = configuration
        
        updatedConfiguration.doneButton = ImageButtonConfiguration(
            imageConfiguration: .init(
                imageName: "ic_done",
                tintColor: #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
            )
        )
        updatedConfiguration.sliderTintColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        updatedConfiguration.mainLabelColors = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        updatedConfiguration.additionalLabelColors = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        updatedConfiguration.backgroundConfiguration.cornerRadius = 0.0
        
        return updatedConfiguration
    }
    
    private func updateAudioTrackLineEditConfiguration(_ configuration: AudioTrackLineEditViewControllerConfig) -> AudioTrackLineEditViewControllerConfig {
        var updatedConfiguration = configuration
        
        updatedConfiguration.audioWaveConfiguration.isRandomWaveColor = true
        updatedConfiguration.audioWaveConfiguration.waveLinesColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        updatedConfiguration.doneButtonImageName = "ic_done"
        updatedConfiguration.doneButtonTintColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        updatedConfiguration.sliderTintColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        updatedConfiguration.draggersColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        updatedConfiguration.draggerImageName = "trim_left"
        updatedConfiguration.trimHeight = 61.0
        updatedConfiguration.trimBorderColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        updatedConfiguration.trimBorderWidth = 2.0
        updatedConfiguration.cursorHeight = 1.0
        updatedConfiguration.dimViewColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        updatedConfiguration.mainLabelColors = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        updatedConfiguration.additionalLabelColors = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        updatedConfiguration.cursorColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        updatedConfiguration.draggersWidth = 25.0
        updatedConfiguration.draggersLineColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        updatedConfiguration.draggersCornerRadius = 0.0
        updatedConfiguration.draggersLineWidth = 2.0
        updatedConfiguration.draggersLineHeight = 35.0
        updatedConfiguration.numberOfLinesInDraggers = 1
        updatedConfiguration.draggerLinesSpacing = 2.0
        updatedConfiguration.draggersCornerRadius = 0.0
        updatedConfiguration.backgroundConfiguration.cornerRadius = 0.0
        updatedConfiguration.voiceFilterConfiguration?.cornerRadius = 4.0
        
        return updatedConfiguration
    }
    
    private func updateAlertViewConfiguration(_ configuration: AlertViewConfiguration) -> AlertViewConfiguration {
        var updatedConfiguration = configuration
        updatedConfiguration.cornerRadius = 7.0
        updatedConfiguration.agreeButtonRadius = 4.0
        updatedConfiguration.refuseButtonRadius = 4.0
        updatedConfiguration.refuseButtonTextConfig = TextButtonConfiguration(
            style: TextConfiguration(
                font: UIFont.systemFont(ofSize: 16.0),
                color: UIColor.white
            ),
            text: nil
        )
        updatedConfiguration.agreeButtonTextConfig = TextButtonConfiguration(
            style: TextConfiguration(
                font: UIFont.systemFont(ofSize: 16.0),
                color: UIColor.white
            ),
            text: nil
        )
        updatedConfiguration.refuseButtonBackgroundColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        updatedConfiguration.agreeButtonBackgroundColor = #colorLiteral(red: 0.07058823529, green: 0.1490196078, blue: 0.2274509804, alpha: 1)
        
        updatedConfiguration.titleTextConfig = TextConfiguration(
            kern: .zero,
            font: UIFont.boldSystemFont(ofSize: 22.0),
            color: .black,
            alignment: .center,
            text: nil,
            shadow: nil
        )
        updatedConfiguration.additionalButtonRadius = 4.0
        updatedConfiguration.additionalButtonBackgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        updatedConfiguration.refuseButtonBorderConfiguration = BorderButtonConfiguration(
            borderWidth: .zero,
            borderColor: UIColor.clear.cgColor
        )
        updatedConfiguration.agreeButtonBorderConfiguration = BorderButtonConfiguration(
            borderWidth: .zero,
            borderColor: UIColor.clear.cgColor
        )
        updatedConfiguration.additionalButtonBorderConfiguration = BorderButtonConfiguration(
            borderWidth: .zero,
            borderColor: UIColor.clear.cgColor
        )
        updatedConfiguration.additionalButtonTextConfig = TextButtonConfiguration(
            style: TextConfiguration(
                font: UIFont.boldSystemFont(ofSize: 15.0),
                color: .black
            ),
            text: nil
        )
        updatedConfiguration.preferredStatusBarStyle = .default
        
        return updatedConfiguration
    }
    
    private func updateTrimVideosConfiguration(_ configuration: TrimVideosConfiguration) -> TrimVideosConfiguration {
        var updatedConfiguration = configuration
        
        updatedConfiguration.backButtonConfiguration = ImageButtonConfiguration(
            imageConfiguration: ImageConfiguration(imageName: "ic_close")
        )
        
        updatedConfiguration.nextButtonConfiguration = ImageTextButtonConfiguration(
            imageConfiguration: ImageConfiguration(imageName: "ic_done")
        )
        
        updatedConfiguration.editVideoItemTitleConfiguration = TextConfiguration(
            font: .systemFont(ofSize: 11.0),
            color: .white
        )
        
        updatedConfiguration.editVideoItems = [
            TrimVideoCompositionEditItem(
                title: NSLocalizedString("com.banuba.trim.rotateEditButtonTitle", comment: ""),
                icon: ImageConfiguration(imageName: "ic_rotate"),
                type: .rotate
            ),
            TrimVideoCompositionEditItem(
                title: NSLocalizedString("com.banuba.trim.splitEditButtonTitle", comment: ""),
                icon: ImageConfiguration(imageName: "ic_split"),
                type: .split
            ),
            TrimVideoCompositionEditItem(
                title: NSLocalizedString("com.banuba.trim.deleteEditButtonTitle", comment: ""),
                icon: ImageConfiguration(imageName: "ic_trash"),
                type: .delete
            ),
            TrimVideoCompositionEditItem(
                title: NSLocalizedString("com.banuba.trim.trimEditButtonTitle", comment: ""),
                icon: ImageConfiguration(imageName: "ic_split"),
                type: .trim
            ),
        ]
        
        updatedConfiguration.addGalleryVideoImageButtonConfiguration = ImageButtonConfiguration(
            imageConfiguration: ImageConfiguration(imageName: "btn_add_video_sticky")
        )
        
        updatedConfiguration.addGalleryVideoButtonBackgroundConfiguration = BackgroundConfiguration(
            cornerRadius: 4.0,
            color: UIColor.clear
        )
        
        updatedConfiguration.trimTimelineConfiguration.trimContentCornerRadius = .zero
        updatedConfiguration.trimTimelineConfiguration.draggerConfiguration.backgroundConfiguraiton.cornerRadius = 8.0
        updatedConfiguration.trimTimelineConfiguration.draggerConfiguration.draggerImageName = "trim_left"
        updatedConfiguration.trimTimelineConfiguration.controlsColor = UIColor(
            red: 250, green: 62, blue: 118, alpha: 1
        )
        updatedConfiguration.playerControlConfiguration = PlayerControlConfiguration(
            playButtonImageName: "ic_play",
            pauseButtonImageName: "ic_trim_pause"
        )
        updatedConfiguration.backgroundConfiguration.cornerRadius = .zero
        updatedConfiguration.screenNameConfiguration.style = nil
        
        updatedConfiguration.videoResolutionConfiguration = VideoResolutionConfiguration(
            default: .hd1920x1080,
            resolutions: [
                .iPhone5s: .hd1280x720,
                .iPhone6: .default854x480,
                .iPhone6s: .hd1280x720,
                .iPhone6Plus: .default854x480,
                .iPhone6sPlus: .hd1280x720,
                .iPhoneSE: .hd1280x720,
            ],
            thumbnailHeights: [
                .iPhone5s: 200.0,
                .iPhone6: 80.0,
                .iPhone6s: 200.0,
                .iPhone6Plus: 80.0,
                .iPhone6sPlus: 200.0,
                .iPhoneSE: 200.0,
            ],
            defaultThumbnailHeight: 400.0
        )
        
        return updatedConfiguration
    }
    
    private func updateTrimVideoConfiguration(_ configuration: TrimVideoConfiguration) -> TrimVideoConfiguration {
        var updatedConfiguration = configuration
        
        updatedConfiguration.backButton = ImageButtonConfiguration(
            imageConfiguration: ImageConfiguration(imageName: "ic_close")
        )
        
        updatedConfiguration.saveButton = ImageButtonConfiguration(
            imageConfiguration: ImageConfiguration(imageName: "ic_done")
        )
        
        updatedConfiguration.playerControlConfiguration = PlayerControlConfiguration(
            playButtonImageName: "ic_play",
            pauseButtonImageName: "ic_trim_pause"
        )
        updatedConfiguration.backgroundConfiguration.cornerRadius = .zero
        updatedConfiguration.screenNameConfiguration.style = nil
        
        return updatedConfiguration
    }
    
    func updateAspectsConfiguration(_ configuration: EffectsListConfiguration) -> EffectsListConfiguration {
        var updatedConfiguration = configuration
        
        updatedConfiguration.doneButton = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_done"))
        updatedConfiguration.cancelButton = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_close"))
        
        return updatedConfiguration
    }
    
    private func updateHandsfreeConfiguration(_ configuration: HandsfreeConfiguration?) -> HandsfreeConfiguration? {
        guard var config = configuration else { return nil }
        //    config.timerOptionBarConfiguration.timerDisabledOptionTitle = "Выкл"
        config.timerOptionBarConfiguration.selectorColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        config.timerOptionBarConfiguration.selectorTextColor = UIColor.black
        config.timerOptionBarConfiguration.optionBackgroundColor = UIColor.clear
        config.timerOptionBarConfiguration.optionCornerRadius = 0.0
        config.timerOptionBarConfiguration.optionTextColor = UIColor.white
        config.timerOptionBarConfiguration.backgroundColor = UIColor.black
        config.timerOptionBarConfiguration.cornerRadius = 8.0
        config.timerOptionBarConfiguration.sliderCornerRadius = 8.0
        config.timerOptionBarConfiguration.barCornerRadius = 4.0
        config.timerOptionBarConfiguration.selectorEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        config.timerOptionBarConfiguration.activeThumbAndLineColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        config.timerOptionBarConfiguration.inactiveThumbAndLineColor = UIColor.white
        config.timerOptionBarConfiguration.minVideoDuration = 1.0
        config.timerOptionBarConfiguration.buttonCornerRadius = 20.0
        config.timerOptionBarConfiguration.buttonBackgroundColor = #colorLiteral(red: 0.2350233793, green: 0.7372031212, blue: 0.7565478683, alpha: 1)
        //    config.timerOptionBarConfiguration.timerTitleColor       = UIColor.white
        config.timerOptionBarConfiguration.modeTitleColor        = UIColor.white
        config.timerOptionBarConfiguration.dragTitleColor        = UIColor.lightGray
        config.timerOptionBarConfiguration.buttonTitleColor      = UIColor.white
        config.timerOptionBarConfiguration.currentValueTextColor = UIColor.white
        config.timerOptionBarConfiguration.minimumValueTextColor = UIColor.white
        config.timerOptionBarConfiguration.maximumValueTextColor = UIColor.white
        
        config.timerOptionBarConfiguration.selectorTextFont = .systemFont(ofSize: 14.0)
        config.timerOptionBarConfiguration.selectorBorderWidth =  .zero
        config.timerOptionBarConfiguration.selectorBorderColor = UIColor.clear.cgColor
        config.timerOptionBarConfiguration.optionTextFont = .systemFont(ofSize: 14.0)
        config.timerOptionBarConfiguration.dragTitleFont = .systemFont(ofSize: 17.0)
        config.timerOptionBarConfiguration.buttonTitleFont = .systemFont(ofSize: 12, weight: .bold)
        config.timerOptionBarConfiguration.currentValueTextFont = .systemFont(ofSize: 12.0)
        config.timerOptionBarConfiguration.minimumValueTextFont = .systemFont(ofSize: 12.0)
        config.timerOptionBarConfiguration.maximumValueTextFont = .systemFont(ofSize: 12.0)
        config.timerOptionBarConfiguration.thumbLineViewBackgroundColor = UIColor.black
        config.timerOptionBarConfiguration.cursorViewColor = UIColor.white
        return config
    }
    
    private func updateRecorderConfiguration(_ configuration: RecorderConfiguration) -> RecorderConfiguration {
        var updatedConfiguration = configuration
        
        updatedConfiguration.videoResolution = VideoResolutionConfiguration(
            default: .hd1920x1080,
            resolutions: [
                .iPhone5s: .hd1280x720,
                .iPhone6: .default854x480,
                .iPhone6s: .hd1280x720,
                .iPhone6Plus: .default854x480,
                .iPhone6sPlus: .hd1280x720,
                .iPhoneSE: .hd1280x720,
            ],
            thumbnailHeights: [
                .iPhone5s: 200.0,
                .iPhone6: 80.0,
                .iPhone6s: 200.0,
                .iPhone6Plus: 80.0,
                .iPhone6sPlus: 200.0,
                .iPhoneSE: 200.0,
            ],
            defaultThumbnailHeight: 400.0
        )
        
        let nextButtonTextConfiguration = TextConfiguration(
            kern: 1.0,
            font: UIFont.systemFont(ofSize: 12.0),
            color: UIColor.white
        )
        let inactiveNextButtonTextConfiguration = TextConfiguration(
            kern: 1.0,
            font: UIFont.systemFont(ofSize: 12.0),
            color: UIColor.white.withAlphaComponent(0.5)
        )
        
        updatedConfiguration.saveButton = SaveButtonConfiguration(
            textConfiguration: nextButtonTextConfiguration,
            inactiveTextConfiguration: inactiveNextButtonTextConfiguration,
            text: "NEXT",
            width: 68.0,
            height: 41.0,
            cornerRadius: 4.0,
            backgroundColor: Self.primaryColor,
            inactiveBackgroundColor: Self.primaryColor.withAlphaComponent(0.5)
        )
        
        updatedConfiguration.backButton = BackButtonConfiguration(imageConfiguration: BanubaVideoEditorSDK.ImageConfiguration(imageName: "ic_nav_close"))
        updatedConfiguration.removeButtonImageName = "camera.delete_videoPart"
        updatedConfiguration.captureButtonModes = [.video]
        //    updatedConfiguration.captureButtonMode = .video
        updatedConfiguration.recordButtonConfiguration.normalImageName = "ic_record_normal"
        updatedConfiguration.recordButtonConfiguration.recordImageName = "ic_record_normal"
        updatedConfiguration.recordButtonConfiguration.idleStrokeColor = UIColor.white.cgColor
        updatedConfiguration.recordButtonConfiguration.strokeColor = Self.primaryColor.cgColor
        
        updatedConfiguration.additionalEffectsButtons = [
            AdditionalEffectsButtonConfiguration(
                identifier: .beauty,
                imageConfiguration: ImageConfiguration(imageName: "ic_beauty_off"),
                selectedImageConfiguration: ImageConfiguration(imageName: "ic_beauty_on")
            ),
            AdditionalEffectsButtonConfiguration(
                identifier: .sound,
                imageConfiguration: ImageConfiguration(imageName: "ic_audio_off"),
                selectedImageConfiguration: ImageConfiguration(imageName: "ic_audio_on"),
                position: .bottom
            ),
            AdditionalEffectsButtonConfiguration(
                identifier: .effects,
                imageConfiguration: ImageConfiguration(imageName: "ic_filters_off"),
                selectedImageConfiguration: ImageConfiguration(imageName: "ic_filters_on")
            ),
            AdditionalEffectsButtonConfiguration(
                identifier: .masks,
                imageConfiguration: ImageConfiguration(imageName: "ic_masks_off"),
                selectedImageConfiguration: ImageConfiguration(imageName: "ic_masks_on")
            ),
            AdditionalEffectsButtonConfiguration(
                identifier: .toggle,
                imageConfiguration: ImageConfiguration(imageName: "ic_cam_front"),
                selectedImageConfiguration: ImageConfiguration(imageName: "ic_cam_back_on")
            ),
            AdditionalEffectsButtonConfiguration(
                identifier: .flashlight,
                imageConfiguration: ImageConfiguration(imageName: "ic_flash_off"),
                selectedImageConfiguration: ImageConfiguration(imageName: "ic_flash_on")
            ),
            AdditionalEffectsButtonConfiguration(
                identifier: .timer,
                imageConfiguration: ImageConfiguration(imageName: "ic_timer_off"),
                selectedImageConfiguration: ImageConfiguration(imageName: "ic_timer_on")
            ),
            AdditionalEffectsButtonConfiguration(
                identifier: .speed,
                imageConfiguration: ImageConfiguration(imageName: "ic_speed_1x"),
                selectedImageConfiguration: nil
            ),
            AdditionalEffectsButtonConfiguration(
                identifier: .muteSound,
                imageConfiguration: ImageConfiguration(imageName: "ic_mic_on"),
                selectedImageConfiguration: ImageConfiguration(imageName: "ic_mic_off")
            ),
            AdditionalEffectsButtonConfiguration(
                identifier: .pip,
                imageConfiguration: ImageConfiguration(imageName: "camera_control.pip_on"),
                selectedImageConfiguration: ImageConfiguration(imageName: "camera_control.pip_off")
            )
        ]
        
        updatedConfiguration.speedBarButtons.imageNameHalf = "ic_speed_0.5x"
        updatedConfiguration.speedBarButtons.imageNameNormal = "ic_speed_1x"
        updatedConfiguration.speedBarButtons.imageNameDouble = "ic_speed_2x"
        updatedConfiguration.speedBarButtons.imageNameTriple = "ic_speed_3x"
        updatedConfiguration.speedBarButtons.selectedTitleColor = Self.primaryColor
        
        let galleryButton: RoundedButtonConfiguration = RoundedButtonConfiguration(
            textConfiguration: TextConfiguration(
                kern: 0.0,
                font: UIFont.systemFont(ofSize: 12.0),
                color: UIColor.white,
                text: NSLocalizedString("com.banuba.recorder.gallery.title", comment: "")
            ),
            cornerRadius: 3,
            backgroundColor: UIColor.clear,
            borderWidth: 0
        )
        updatedConfiguration.galleryButton = galleryButton
        
        updatedConfiguration.emptyGalleryImageName = "multi_choice"
        
        updatedConfiguration.timerConfiguration.defaultButton = ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_timer_off"))
        updatedConfiguration.timerConfiguration.options = [
            TimerConfiguration.TimerOptionConfiguration(
                button: ImageButtonConfiguration(imageConfiguration: ImageConfiguration(imageName: "ic_timer_on")),
                startingTimerSeconds: 3,
                stoppingTimerSeconds: 0
            )
        ]
        
        updatedConfiguration.timeLineConfiguration.progressBarColor = Self.primaryColor
        updatedConfiguration.timeLineConfiguration.progressBarSelectColor = .white
        
        updatedConfiguration.regularRecordButtonPosition = 10.0
        updatedConfiguration.recorderEffectsConfiguration.cornerRadius = 0.0
        updatedConfiguration.recorderEffectsConfiguration.effectItemConfiguration.imageCornerRadius = 6.0
        updatedConfiguration.leftControlsBottomOffsetFromCaptureButton = 0.0
        updatedConfiguration.leftControlsLeftOffset = 25.0
        updatedConfiguration.sequenceHeight = 6.0
        updatedConfiguration.loopAudioWhileRecording = true
        updatedConfiguration.takeAudioDurationAsMaximum = false
        updatedConfiguration.isDynamicMusicTitle = false
        updatedConfiguration.isAudioRateEqualsVideoSpeed = true
        updatedConfiguration.isGalleryButtonHidden = false
        updatedConfiguration.supportMultiRecords = true
        
        let videoCaptureButton: RoundedButtonConfiguration = RoundedButtonConfiguration(
            textConfiguration: TextConfiguration(
                kern: .zero,
                font: .systemFont(ofSize: 14, weight: .regular),
                color: UIColor.white
            ),
            cornerRadius: .zero,
            backgroundColor: UIColor.clear,
            borderWidth: .zero
        )
        updatedConfiguration.videoCaptureButtonConfiguration = videoCaptureButton
        
        let photoButton: RoundedButtonConfiguration = RoundedButtonConfiguration(
            textConfiguration: TextConfiguration(
                kern: .zero,
                font: .systemFont(ofSize: 14, weight: .regular),
                color: UIColor.white
            ),
            cornerRadius: .zero,
            backgroundColor: UIColor.clear,
            borderWidth: .zero
        )
        updatedConfiguration.photoCaptureButtonConfiguration = photoButton
        
        let backroundMusicContainer = BackgroundConfiguration(
            cornerRadius: 20.0,
            color: .black.withAlphaComponent(0.3)
        )
        updatedConfiguration.backroundMusicContainerConfiguration = backroundMusicContainer
        
        updatedConfiguration.floatingViewSeparatedLines = true
        updatedConfiguration.effectSelectorContainerCornerRadius = 8.0
        updatedConfiguration.preferredStatusBarStyle = .default
        
        return updatedConfiguration
    }

    // MARK: - Example view controller factory customization
    func createExampleExternalViewControllerFactory() -> ExternalViewControllerFactory {
        return ExampleViewControllerFactory()
    }
    
    /// Example video editor view controller factory stores custom view factories used for customization BanubaVideoEditor
    class ExampleViewControllerFactory: ExternalViewControllerFactory {
        var musicEditorFactory: MusicEditorExternalViewControllerFactory?
        var countdownTimerViewFactory: CountdownTimerViewFactory?
        var exposureViewFactory: AnimatableViewFactory?
        
        init() {
            countdownTimerViewFactory = CountdownTimerViewControllerFactory()
            exposureViewFactory = DefaultExposureViewFactory()
        }
        
        /// Example countdown timer view factory for Recorder countdown animation
        class CountdownTimerViewControllerFactory: CountdownTimerViewFactory {
            func makeCountdownTimerView() -> CountdownTimerAnimatableView {
                let countdownView = CountdownView()
                countdownView.frame = UIScreen.main.bounds
                countdownView.font = countdownView.font.withSize(102.0)
                countdownView.digitColor = VideoEditorModule.primaryColor
                return countdownView
            }
        }
    }
}
