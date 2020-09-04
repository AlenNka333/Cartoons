import UIKit

class AuthorizationViewController: UIViewController {
    private lazy var authView: AuthorizationView = {
        let authView = AuthorizationView()
        return authView
    }()
    
    private lazy var secondView = VerificationView(frame: view.frame)

    override func viewDidLoad() {
        super.viewDidLoad()
        authView = AuthorizationView(frame: view.frame)

        view.addSubview(secondView)
        view.addSubview(authView)
        
        authView.phoneNumberTextField.delegate = self
        authView.sendCodeButton.addTarget(self,
                                          action: #selector(self.buttonClicked),
                                          for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}

extension AuthorizationViewController {
    @objc func buttonClicked() {
        let newViewController = VerificationCodeViewController()
        navigationController?.pushViewController(newViewController, animated: true)
    }
}

extension AuthorizationViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return false
        }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = String.format(with: "+XXX (XX) XXX-XX-XX", phone: newString)
        return false
    }
}
