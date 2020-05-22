# iOS SwiftUI Combine Template
A template repo for getting setup quickly with an iOS project using the `SwiftUI` and `Combine` frameworks.

This template repo was built off of the original [DM-iOS-Template](https://github.com/defmethodinc/dm-ios-template)

This project is managed through a Github [project board](https://help.github.com/en/github/managing-your-work-on-github/about-project-boards).
The board for this project is: [here](https://github.com/defmethodinc/dm-ios-swift-ui-combine-template/projects/1).

This project has been built along side a [backend repo](https://github.com/defmethodinc/CreationShelf-Rails6API-Template). It is a Rails6Api.
Both are built around the concept of "Creations", a generic or duck-type model in the vein of "todos" or "widgets". It is to hold and show things that people "create".

We have added some basic structure to this application we deem useful such as:
 - NavigationViews, NavigationLinks, and Lists in SwiftUI
 - use of publisher/observer pattern in SwiftUI
 - MVVM as an ObserverableObject
 - Testing of MVVM publishing
 - Wrapping networking layer publisher with json decoding of generics

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
3. Add the variable in `Config.swift`.
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
    guard let apiUrlstring = Config.infoDictionary[Keys.Plist.apiURL] as? String else {
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
- Application currently makes use of SwiftUI NavigationView and NavigationLink for navigation (A coordinator pattern may be added back in)
- Configuration is set up for Development, Staging and Production.
- MVVM is implemented as an example.

### Renaming the project

https://stackoverflow.com/questions/33370175/how-do-i-completely-rename-an-xcode-project-i-e-inclusive-of-folders

### Resources/Links
- Automatically update a repo from the template.
https://stackoverflow.com/questions/56577184/github-pull-changes-from-a-template-repository/56577320
- For inspiration about how to make a good boilerplate/template:
https://www.freecodecamp.org/news/whats-boilerplate-and-why-do-we-use-it-let-s-check-out-the-coding-style-guide-ac2b6c814ee7/
https://fullstackworld.com/post/what-is-boilerplate-code-why-when-to-use-the-boilerplate-code

## License (MIT)

Copyright © 2020 Def Method

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
