import UIKit
import Foundation

protocol SignInFlowDelegate: class {
  func didSignIn()
}

protocol SignInViewControllerDelegate: class {
  func didFail(with error: SignInError)
  func didSucceed()
}

class SignInViewController: UIViewController, Storyboarded, ViewModeled {
  
  @IBOutlet weak var phoneNumber: UITextField?
  @IBOutlet weak var phoneInput: UIStackView?
  @IBOutlet weak var signInButton: UIButton?
  @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var errorLabel: UILabel!
  @IBAction func signIn(sender: UIButton) {
    if let phoneNumberText = phoneNumber?.text, phoneNumberText != "" {
      viewModel.sendSignInCredentials(phone: phoneNumberText)
    }
  }
  
  @IBAction func showPhoneInput(sender: UIButton) {
    signInButton?.isHidden = true
    phoneNumber?.becomeFirstResponder()
  }
  
  weak var flowDelegate: SignInFlowDelegate?
  
  var viewModel: SignInViewModelType!
  
  func setup(with viewModel: SignInViewModelType) {
    self.viewModel = viewModel
    self.viewModel.delegate = self
  }
}

// MARK: Life Cycle Methods

extension SignInViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    addKeyboardNotificationObserver()
  }
}

// MARK: UI Methods
private extension SignInViewController {
  func displayError(_ error: SignInError) {
    self.errorLabel.isHidden = false
    switch error {
    case .serverError(let message):
      self.errorLabel.text = message
    default:
      self.errorLabel.text = "Retry in 20 seconds"
    }
  }
}

// MARK: Keyboard Methods
private extension SignInViewController {
  func addKeyboardNotificationObserver() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
  }
  
  @objc func keyboardWillShow(notification: NSNotification) {
    guard let userInfo = notification.userInfo else {return}
    guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
    let keyboardFrame = keyboardSize.cgRectValue
    
    phoneInput?.isHidden = false
    bottomConstraint.constant = view.bounds.maxY - keyboardFrame.minY
  }
}

// MARK: SignInViewControllerDelegate
extension SignInViewController: SignInViewControllerDelegate {
  func didFail(with error: SignInError) {
    DispatchQueue.main.async {
      self.displayError(error)
    }
  }
  
  func didSucceed() {
    DispatchQueue.main.async {
      self.flowDelegate?.didSignIn()
    }
  }
}

