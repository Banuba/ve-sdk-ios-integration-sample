# Popups guide

- [Types](#Types)
- [Toast](#Toast)
- [Wait dialog](#Wait-dialog)
- [Popover alert](#Popover-alert)
- [Alert](#Alert)

## Types
Video editor includes a few types of popups:
- toast
- wait dialog (for long running tasks)
- popover alert
- alert

You can customize all types

## Toast
Implement ```ToastConfiguration```  and set it to ```VideoEditorConfig.toastConfiguration``` 
to customize toast.  
You can use allowed properties

- [kern](../Example/Example/VideoEditorModule.swift#L81) - The kerning of the presented text
- [font](../Example/Example/VideoEditorModule.swift#L81) - The font of the presented text
- [cornerRadius](../Example/Example/VideoEditorModule.swift#L81) - The toast corner of radius
- [textColor](../Example/Example/VideoEditorModule.swift#L81) - The toast text color
- [backgroundColor](../Example/Example/VideoEditorModule.swift#L81) - The toast background color

## Wait dialog
Implement ```FullScreenActivityConfiguration```  and set it to ```VideoEditorConfig.fullScreenActivityConfiguration``` 
to customize wait dialog.  
You can use allowed properties

- [labelFont](../Example/Example/VideoEditorModule.swift#L359) - Label title font
- [cornerRadius](../Example/Example/VideoEditorModule.swift#L359) - Container corner radius
- [activityEffectsViewAlpha](../Example/Example/VideoEditorModule.swift#L359) - Background view alpha
- [activityIndicator](../Example/Example/VideoEditorModule.swift#L359) - Throbber

## Popover alert

Implement ```PopoverAlertViewConfiguration```  and set it to ```VideoEditorConfig.popoverAlertViewConfiguration``` 
to customize popover alert.  
You can use allowed properties

- [mainBackgroundColor](../Example/Example/VideoEditorModule.swift#L81) - Color used to fill the remaining space under actions list
- [actionsViewBackgroundColor](../Example/Example/VideoEditorModule.swift#L81) - Background color of actions list
- [cornerRadius](../Example/Example/VideoEditorModule.swift#L81) - Corner radius of actions list border
- [actionCellHeight](../Example/Example/VideoEditorModule.swift#L81) - Height of each action row
- [hideAnimated](../Example/Example/VideoEditorModule.swift#L81) - Flag used to specify if view's dismiss must be animated

## Alert
Implement ```AlertViewConfiguration```  and set it to ```VideoEditorConfig.alertViewConfiguration``` 
to customize alert.  
You can use allowed properties

- [cornerRadius](../Example/Example/VideoEditorModule.swift#L704) - Corner radius of the container view
- [refuseButtonRadius](../Example/Example/VideoEditorModule.swift#L706) - Corner radius of the refuse button
- [agreeButtonRadius](../Example/Example/VideoEditorModule.swift#L705) - Corner radius of the agree button
- [additionalButtonRadius](../Example/Example/VideoEditorModule.swift#L732) - Corner radius of the additional button
- [refuseButtonBackgroundColor](../Example/Example/VideoEditorModule.swift#L721) - Background color of the refuse button
- [agreeButtonBackgroundColor](../Example/Example/VideoEditorModule.swift#L722) - Background color of the agree button
- [additionalButtonBackgroundColor](../Example/Example/VideoEditorModule.swift#L733) - Background color of the additional button
- [refuseButtonBorderConfiguration](../Example/Example/VideoEditorModule.swift#L734) - Border configuration of the refuse button
- [agreeButtonBorderConfiguration](../Example/Example/VideoEditorModule.swift#L738) - Border configuration of the agree button
- [additionalButtonBorderConfiguration](../Example/Example/VideoEditorModule.swift#L742) - Border configuration of the additional button
- [refuseButtonTextConfig](../Example/Example/VideoEditorModule.swift#L707) - Text configuration of the refuse button
- [additionalButtonTextConfig](../Example/Example/VideoEditorModule.swift#L746) - Text configuration of the additional button
- [agreeButtonTextConfig](../Example/Example/VideoEditorModule.swift#L714) - Text configuration of the agree button
- [titleTextConfig](../Example/Example/VideoEditorModule.swift#L724) - Text configuration of the title
- [preferredStatusBarStyle](../Example/Example/VideoEditorModule.swift#L753) - Style configuration of the status bar

![img](screenshots/AlertScreen.png)

And you can customize string resources as well.

| Key        |      Value      |   Description |
| ------------- | :----------- | :------------- |
| OK | OK | OK button title in alert
| Cancel | Cancel | Ability to cancel

![img](screenshots/AlertLocalization.png)
