# Popups guide

- [Types](#Types)
- [Toast](#Toast)
- [Wait dialog](#Wait-dialog)
- [Info alert](#Info-alert)
- [Confirmation alert](#Confirmation-alert)

## Types
Video editor includes a few types of popups:
- toast
- wait dialog (for long running tasks)
- info alert
- confirmation alert

You can customize all types

## Toast
IN PROGRESS

## Wait dialog
IN PROGRESS...

## Info alert
IN PROGRESS ...

## Confirmation alert
Implement ```AlertViewConfiguration```  and set it to ```VideoEditorConfig.alertViewConfiguration``` 
to customize confirmation alert.  
You can use allowed properties

- [cornerRadius](../Example/Example/VideoEditorModule.swift#L659) - Corner radius of the container view
- [refuseButtonRadius](../Example/Example/VideoEditorModule.swift#L661) - Corner radius of the refuse button
- [agreeButtonRadius](../Example/Example/VideoEditorModule.swift#L669) - Corner radius of the agree button
- [additionalButtonRadius](../Example/Example/VideoEditorModule.swift#L687) - Corner radius of the additional button
- [refuseButtonBackgroundColor](../Example/Example/VideoEditorModule.swift#L676) - Background color of the refuse button
- [agreeButtonBackgroundColor](../Example/Example/VideoEditorModule.swift#L677) - Background color of the agree button
- [additionalButtonBackgroundColor](../Example/Example/VideoEditorModule.swift#L688) - Background color of the additional button
- [refuseButtonBorderConfiguration](../Example/Example/VideoEditorModule.swift#L689) - Border configuration of the refuse button
- [agreeButtonBorderConfiguration](../Example/Example/VideoEditorModule.swift#L693) - Border configuration of the agree button
- [additionalButtonBorderConfiguration](../Example/Example/VideoEditorModule.swift#L697) - Border configuration of the additional button
- [refuseButtonTextConfig](../Example/Example/VideoEditorModule.swift#L662) - Text configuration of the refuse button
- [additionalButtonTextConfig](../Example/Example/VideoEditorModule.swift#L701) - Text configuration of the additional button
- [agreeButtonTextConfig](../Example/Example/VideoEditorModule.swift#L669) - Text configuration of the agree button
- [titleTextConfig](../Example/Example/VideoEditorModule.swift#L679) - Text configuration of the title
- [preferredStatusBarStyle](../Example/Example/VideoEditorModule.swift#L708) - Style configuration of the status bar

![img](screenshots/AlertScreen.png)

And you can customize string resources as well.

| Key        |      Value      |   Description |
| ------------- | :----------- | :------------- |
| OK | OK | OK button title in alert
| Cancel | Cancel | Ability to cancel

![img](screenshots/AlertLocalization.png)