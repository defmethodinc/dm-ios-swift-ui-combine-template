import Foundation

public enum Environment {
  // MARK: - Keys
  enum Keys {
    enum Plist {
      static let apiURL = "API_URL"
    }
  }
  
  private static let infoDictionary: [String: Any] = {
    guard let dict = Bundle.main.infoDictionary else {
      fatalError("Plist file not found")
    }
    return dict
  }()
  
  static let apiUrl: URL = {
    guard let apiUrlstring = Environment.infoDictionary[Keys.Plist.apiURL] as? String else {
      fatalError("\(Keys.Plist.apiURL) not set in plist for this environment")
    }
    guard let url = URL(string: apiUrlstring) else {
      fatalError("\(Keys.Plist.apiURL) is invalid")
    }
    return url
  }()
}
