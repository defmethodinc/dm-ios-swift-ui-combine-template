# iOS Template

### Configuration - How to add environment variables?

1. Add the vairable in the `.xcconfig` files, found in the `Configs/` folder.
```
API_URL = http:/$()/localhost:3000
```
2. Add the variable in `Info.plist`.
```
<key>API_URL</key>
<string>$(API_URL)</string>
```
3. Add the variable in `Environment.swift`.
- Add it to the Keys.Plist enum
```
enum Keys {
    enum Plist {
      static let apiURL = "API_URL"
    }
  }
```
- Add the getter
```
static let apiUrl: URL = {
    guard let apiUrlstring = Environment.infoDictionary[Keys.Plist.apiURL] as? String else {
      fatalError("\(Keys.Plist.apiURL) not set in plist for this environment")
    }
    guard let url = URL(string: apiUrlstring) else {
      fatalError("\(Keys.Plist.apiURL) is invalid")
    }
    return url
}()
```

### Configuration - Secure your environment variables
Use the examples to set up your environments, but don't add them to your version control system.
Since they might contain secrets, you want to keep them in a secure location (like 1Password).
They can then be shared securely amongst developers.

See article: https://thoughtbot.com/blog/let-s-setup-your-ios-environments

### Architecture
- Coordinators are set up to handle the navigation flow.
- Configuration is set up for Development, Staging and Production.
- MVVM is implemented as an example

### Renaming the project

https://stackoverflow.com/questions/33370175/how-do-i-completely-rename-an-xcode-project-i-e-inclusive-of-folders