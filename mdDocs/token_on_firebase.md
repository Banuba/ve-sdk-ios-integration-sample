# API for using token from Firebase in the SDK

Banuba token can be stored in Firebase

### Step 1

Please add snapshot `banubaToken` in your [Firebase Realtime Database](https://firebase.google.com/docs/database) with token provided by Banuba representatives.

### Step 2

Add following dependency to pod file. Run pod install.
```
 pod 'BanubaTokenStorageSDK', 'Specify Version'
```

### Step 3

VideoEditorTokenProvider is used for handling the way how you can store a banuba_token in your app.

There are 2 possible options:

- Store banuba_token in BanubaVideoEditorSDK-Info.plist(Default behavior):

```swift
import BanubaTokenStorageSDK

let provider = VideoEditorTokenProvider()
```

- This file should be placed in your project and has the following structure:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>VideoEditorToken</key>
	<string>Put VE SDK token here</string>
</dict>
</plist>
```

### Step 4

Firebase Realtime Database.

After that specify url to your database(For example: https://*-default-rtdb.*.firebasedatabase.app/) or path to GoogleService-Info.plist in VideoEditorTokenProvider:

```swift
import BanubaTokenStorageSDK

// For example, targetUrl can be
// https://*-default-rtdb.*.firebasedatabase.app/
let provider = VideoEditorTokenProvider(
  targetUrl: "Put your firebase database url"
)
```

Options to create VideoEditorTokenProvider:

```swift
/// VideoEditorTokenProvider constructor
/// - Parameters:
///   - targetUrl: Firebase database url
///   - plistPath: path to GoogleService-Info.plist
init(
  targetUrl: String? = nil,
  plistPath: String? = nil
)
```

`loadToken` method from `VideoEditorTokenProvider` is used to get banuba_token either hardcoded in the app or from Firebase.

```swift
/// Receiving token from local plist file or via FIR Database
/// - Parameters:
///   - completion: The completion handler is called with optional token and some optional errors.
///     - error: Description of any error that might occur.
///     - token: Token used to initialize the BanubaVideoEditor.
func loadToken(
  completion: @escaping (_ error: TokenProviderErrorType?, _ token: String?) -> Void
)

/// Possible errors
enum TokenProviderErrorType: Error {
  case databaseError(error: Error?)  /// Have't permission to access database
  case databaseSettingsError         /// TokenSnapshot and targetUrl are not setted
  case localTokenNotFound            /// Local token is nil or empty
  case snapshotError                 /// Snapshot is nil or has incorrect type
  case noInternetConnection          /// There is no internet connection
}
```

### Step 5

Below is an example of how you can use VideoEditorTokenProvider to load banuba_token and initialize VideoEditor SDK

```swift
provider.loadToken() { [weak self] (error, token) in
  guard let token = token else { return }
  guard let self = self else { return }
  self.videoEditorSDK = BanubaVideoEditor(
    token: token,
    configuration: self.config,
    analytics: Analytics(),
    externalViewControllerFactory: viewControllerFactory
  )
}

// Use videoEditorSDK
```

### Note:
For better user experience you should load the `banuba_token` at the start of your app lifecycle because  `VideoEditorTokenProvider` loads banuba_token asynchronously. **Please keep in mind that you have to handle errors when the internet is not connected and other errors.**
