import Foundation

protocol AppSessionType {
  func isLoggedIn(user: User?) -> Bool
  var currentUser: User? { get }
}

class AppSession: AppSessionType {
  
  static let shared = AppSession()
  
  private init() {}
  
  func isLoggedIn(user: User?) -> Bool {
    return user != nil
  }
  
  func setUser(_ user: User) {
    let defaults = UserDefaults.standard
    defaults.set(try? PropertyListEncoder().encode(user), forKey: DefaultsKey.user)
  }
  
  var currentUser: User? {
    let defaults = UserDefaults.standard
    guard let userData = defaults.object(forKey: DefaultsKey.user) as? Data else {
      return nil
    }
    
    guard let user = try? PropertyListDecoder().decode(User.self, from: userData) else {
      return nil
    }
    
    return user
  }
}
