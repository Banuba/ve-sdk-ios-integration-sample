
# Banuba VideoEditor SDK
## Hands Free screen styles  

Styles for the Hands Free screen are configured here. This screen is needed to turn the timer on and off, set the time to stop video recording.

Use the properties below to customize the Hands Free screen.

@protocol: HandsfreeConfiguration

 - [timerDisabledOptionTitle: String](/Example/Example/Extension/HandsfreeConfiguration.swift#L7)
 
 Showing the title for the timer
 
 - [selectorColor: UIColor](/Example/Example/Extension/HandsfreeConfiguration.swift#L8)
 
 The selector view color
 
 - [selectorTextColor: UIColor](/Example/Example/Extension/HandsfreeConfiguration.swift#L9)
 
 The selector view text color
 
 - [optionBackgroundColor: UIColor](/Example/Example/Extension/HandsfreeConfiguration.swift#L10)
 
 The timer option selection view background color
 
 - [optionCornerRadius: CGFloat](/Example/Example/Extension/HandsfreeConfiguration.swift#L11)
 
 The timer option selection view corner radius
 
 - [optionTextColor: UIColor](/Example/Example/Extension/HandsfreeConfiguration.swift#L12)
 
 The view text color
 
 - [backgroundColor: UIColor](/Example/Example/Extension/HandsfreeConfiguration.swift#L13)

 The timer option view background color
  
 - [backgroundViewColor: UIColor](/Example/Example/Extension/HandsfreeConfiguration.swift#L13)

 The  background view background configuration
  
 - [cornerRadius: CGFloat](/Example/Example/Extension/HandsfreeConfiguration.swift#L14)
  
 The HandsFreeViewController corner radius
  
 - [sliderCornerRadius: CGFloat](/Example/Example/Extension/HandsfreeConfiguration.swift#L15)
  
 The slider corner radius
  
 - [barCornerRadius: CGFloat](/Example/Example/Extension/HandsfreeConfiguration.swift#L16)
  
 The bar corner radius
  
 - [selectorEdgeInsets: UIEdgeInsets](/Example/Example/Extension/HandsfreeConfiguration.swift#L17)
  
 The selector views edge insets
  
 - [activeThumbAndLineColor: UIColor](/Example/Example/Extension/HandsfreeConfiguration.swift#L18)
  
 The color of the activated switch of active lines in slider
  
 - [inactiveThumbAndLineColor: UIColor](/Example/Example/Extension/HandsfreeConfiguration.swift#L19)
  
 The color of the inactivated switch of inactive lines in slider
  
 - [minVideoDuration: Double](/Example/Example/Extension/HandsfreeConfiguration.swift#L20)
  
 The minimum value for video duration. Default 1.0
   
 - [buttonCornerRadius: CGFloat](/Example/Example/Extension/HandsfreeConfiguration.swift#L21)
   
 The button CornerRadius
   
 - [buttonBackgroundColor: UIColor](/Example/Example/Extension/HandsfreeConfiguration.swift#L22)
   
 The button background color
   
 - [switchOnTintColor: UIColor](/Example/Example/Extension/HandsfreeConfiguration.swift#L23)
   
 The switch background color
   
 - [timerTitleColor: UIColor](/Example/Example/Extension/HandsfreeConfiguration.swift#L24)
   
 The timer title color
   
 - [modeTitleColor: UIColor](/Example/Example/Extension/HandsfreeConfiguration.swift#L25)
    
 The mode title color
    
 - [dragTitleColor: UIColor](/Example/Example/Extension/HandsfreeConfiguration.swift#L26)
    
 The drag title color
   
 - [buttonTitleColor: UIColor](/Example/Example/Extension/HandsfreeConfiguration.swift#L27)
      
 The button title color
   
 - [currentValueTextColor: UIColor](/Example/Example/Extension/HandsfreeConfiguration.swift#L28)
    
 The current value text color
   
 - [minimumValueTextColor: UIColor](/Example/Example/Extension/HandsfreeConfiguration.swift#L29)
   
 The minimum value text color
   
 - [maximumValueTextColor: UIColor](/Example/Example/Extension/HandsfreeConfiguration.swift#L30)
   
 The maximum value text color
   
 - [thumbLineViewColor: UIColor](/Example/Example/Extension/HandsfreeConfiguration.swift#L30)
   
 The thumb line view color

  ![img](screenshots/HandsfreeConfiguration.png)
  
  ![img](screenshots/timerOptionBarColorConfiguration.png)
  
  ## String resources

![img](screenshots/HandsFreeLocalization.png)

| Key        |      Value      |   Description |
| ------------- | :----------- | :------------- |
| hands.free.timer.title | Сountdown | Timer title text
| hands.free.video.mode.title | Hands-free video mode | Mode title text
| hands.free.video.drag.title | Drag to set video duration: | Drag title text
| hands.free.btn.title | START RECORDING | Start recording button title
| hands.free.seconds | %@ s | Seconds
