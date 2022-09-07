# Banuba VideoEditor SDK
## AlertViewConfiguration

The AlertController entity displays a message to the user.
In addition to displaying a message to the user, you can associate actions that can be used. In the application AlertController is used when you want to cancel some action, or reset progress.

Please use the properties below to configure the AlertController.

- [cornerRadius: CGFloat](/Example/Example/Extension/AlertViewConfiguration.swift#L7)

Container corner radius

- [refuseButtonRadius: CGFloat](/Example/Example/Extension/AlertViewConfiguration.swift#L9)

Refuse button radius

- [agreeButtonRadius: CGFloat](/Example/Example/Extension/AlertViewConfiguration.swift#L8)

Agree button radius

- [additionalButtonRadius: CGFloat](/Example/Example/Extension/AlertViewConfiguration.swift#L35)
    
 Additional button radius

- [refuseButtonBackgroundColor: UIColor](/Example/Example/Extension/AlertViewConfiguration.swift#L24)

Refuse button background color

- [agreeButtonBackgroundColor: UIColor](/Example/Example/Extension/AlertViewConfiguration.swift#L25)

Agree button background color

- [additionalButtonBackgroundColor: UIColor](/Example/Example/Extension/AlertViewConfiguration.swift#L36)
    
Additional button background color

- [refuseButtonBorderConfiguration: BanubaUtilities.BorderButtonConfiguration](/Example/Example/Extension/AlertViewConfiguration.swift#L37)

Refuse button border configuration

- [agreeButtonBorderConfiguration: BanubaUtilities.BorderButtonConfiguration](/Example/Example/Extension/AlertViewConfiguration.swift#L41)

Agree button border configuration

- [additionalButtonBorderConfiguration: BanubaUtilities.BorderButtonConfiguration](/Example/Example/Extension/AlertViewConfiguration.swift#L45)

Additional button border configuration

- [refuseButtonTextConfig: TextButtonConfiguration](/Example/Example/Extension/AlertViewConfiguration.swift#L17)

Refuse button text configuratin

- [additionalButtonTextConfig: BanubaUtilities.TextButtonConfiguration](/Example/Example/Extension/AlertViewConfiguration.swift#L49)

Additional button text configuratin

- [agreeButtonTextConfig: TextButtonConfiguration](/Example/Example/Extension/AlertViewConfiguration.swift#L10)

Agree button text configuratin

- [titleTextConfig: TextConfiguration](/Example/Example/Extension/AlertViewConfiguration.swift#L27)

Main title text configuratin

- [messageTextConfig: TextConfiguration?](/Example/Example/Extension/AlertViewConfiguration.swift#L27)

Message text configuration

- [preferredStatusBarStyle: UIStatusBarStyle](/Example/Example/Extension/AlertViewConfiguration.swift#L56)

The style of the status bar.

![img](screenshots/AlertScreen.png)

## String resources

| Key        |      Value      |   Description |
| ------------- | :----------- | :------------- |
| OK | OK | OK button title in alert
| Cancel | Cancel | Ability to cancel

![img](screenshots/AlertLocalization.png)
