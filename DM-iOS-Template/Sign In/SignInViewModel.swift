protocol SignInViewModelType {
  func sendSignInCredentials(phone: String?)
  var delegate: SignInViewControllerDelegate? { get set }
}

class SignInViewModel: SignInViewModelType {
  private var networkClient: NetworkClientType
  
  init(networkClient: NetworkClientType) {
    self.networkClient = networkClient
  }
  
  weak var delegate: SignInViewControllerDelegate?
  
  func sendSignInCredentials(phone: String?) {
    guard let phone = phone else { return }
    networkClient.verify(with: phone.trimmingCharacters(in: .whitespacesAndNewlines)){ result in
      switch result {
      case .success(let user):
        AppSession.shared.setUser(user)
        self.delegate?.didSucceed()
      case .failure(let error):
        self.delegate?.didFail(with: error)
      }
    }
  }
}
