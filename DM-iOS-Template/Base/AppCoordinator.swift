import UIKit

class AppCoordinator: Coordinator {
  var navigationController: UINavigationController
  let window: UIWindow
  let appSession: AppSessionType
  var childCoordinators = [Coordinator]()
  
  init(window: UIWindow, appSession: AppSessionType = AppSession.shared) {
    self.window = window
    self.navigationController = UINavigationController()
    self.appSession = appSession
  }
  
  func start() {
    window.rootViewController = navigationController
    
    if appSession.isLoggedIn(user: appSession.currentUser) {
      presentFeed()
    } else {
      presentSignIn()
    }
    
    window.makeKeyAndVisible()
  }
}

// MARK: Presentation Methods

extension AppCoordinator {
  func presentFeed() {
    let feedCoordinator = FeedCoordinator(navigationController)
    feedCoordinator.start()
    childCoordinators.append(feedCoordinator)
  }
  
  func presentSignIn() {
    let signInCoordinator = SignInCoordinator(navigationController)
    signInCoordinator.delegate = self
    signInCoordinator.start()
    childCoordinators.append(signInCoordinator)
  }
}

// MARK: SignInCoordinatorDelegate

extension AppCoordinator: SignInCoordinatorDelegate {
  func finishSignInFlow(coordinator: SignInCoordinator) {
    childDidFinish(coordinator)
    presentFeed()
  }
}

