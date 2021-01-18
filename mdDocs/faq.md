# FAQ  
This page is aimed to explain the most frequent technical questions asked while integrating our SDK.

### 2. I want to add AR Mask to the Video Editor (without AR Cloud backend)

 Technically AR Mask is a bulk of files within the folder.

 You should place AR Masks to the YourProject/bundleEffects/ directory inside the host project directory (main bundle). Be sure that AR mask directory has a **preview.png** file. It is used as an icon of the AR mask in the app.

 **Note** that the name of directory will be used as a title of the AR mask within the app. 
 
 **Note** "bundleEffects" is the name for the folder in which the masks should be located. Do not change the name of this folder so that our modules can find the resources they need. If the folder doesn't exist, then create it.
