# API for using token from Remote Server in the Video Editor SDK

In order to get a token from a remote server, you need to use a public class ```RemoteTokenProvider```.

For example:
```Swift
private func loadToken(completion: @escaping (String) -> Void) {
    let remoteTokenProvider = RemoteTokenProvider(
      targetURL: "token URL"
    )
    let provider = VideoEditorTokenProvider(tokenProvider: remoteTokenProvider)
    
    startActivity(isStopExportButtonHidden: false, text: "Loading")
    
    provider.loadToken() { [weak self] error, token in
      self?.stopActivity()
    ...
```
