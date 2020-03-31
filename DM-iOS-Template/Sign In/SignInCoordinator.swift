import UIKit

protocol SignInCoordinatorDelegate: class {
  func finishSignInFlow(coordinator: SignInCoordinator)
}

class SignInCoordinator: Coordinator {
  var childCoordinators = [Coordinator]()
  var navigationController: UINavigationController
  weak var delegate: SignInCoordinatorDelegate?
  
  init(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let signInVC = SignInViewController.instantiateViewController()
    let signInVM = SignInViewModel(networkClient: NetworkClient())
    signInVC.setup(with: signInVM)
    signInVC.flowDelegate = self
    navigationController.pushViewController(signInVC, animated: true)
  }
}

extension SignInCoordinator: SignInFlowDelegate {
  func didSignIn() {
    delegate?.finishSignInFlow(coordinator: self)
  }
}
