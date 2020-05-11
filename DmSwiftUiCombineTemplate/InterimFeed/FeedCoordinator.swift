import UIKit

class FeedCoordinator: Coordinator {
  var childCoordinators = [Coordinator]()
  var navigationController: UINavigationController
  
  init(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let feedVC = InterimFeedViewController()
    navigationController.pushViewController(feedVC, animated: true)
  }
}
