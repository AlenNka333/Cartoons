import UIKit

class AuthorizationViewController: UIViewController {
    var presenter: AuthorizationViewPresenterProtocol?
    let alertView = CustomAlertView()
    let activityIndicator = UIActivityIndicatorView()
    
    private lazy var appLabelView = CustomLabelView()
    private lazy var phoneNumberTextField = CustomTextField()
    private lazy var getCodeButton: UIButton = CustomButton()
    private lazy var ownView: UIView = {
        view = UIView()
        view.backgroundColor = UIColor(patternImage: R.image.main_background()!)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupToHideKeyboardOnTapOnView()
    }
    
    override func loadView() {
        self.view = ownView
    }
    
    private func setupUI() {
        view.addSubview(appLabelView)
        appLabelView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(160)
        }
        view.addSubview(phoneNumberTextField)
        phoneNumberTextField.delegate = self
        phoneNumberTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-60)
        }
        view.addSubview(getCodeButton)
        getCodeButton.setTitle(R.string.localizable.get_code_button_key(), for: .normal)
        getCodeButton.addTarget(self, action: #selector(buttonTappedToSendCodeAction), for: .touchUpInside)
        getCodeButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension AuthorizationViewController: AuthorizationViewProtocol {
    func showActivityIndicatorAction() {
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func stopActivityIndicatorAction() {
        activityIndicator.stopAnimating()
    }
    
    func setError(error: Error) {
        CustomAlertView.instance.showAlert(title: R.string.localizable.error(), message: error.localizedDescription, alertType: .error)
        getCodeButton.isEnabled = true
        getCodeButton.backgroundColor = R.color.enabled_button_color()
    }
}

extension AuthorizationViewController {
    @objc func buttonTappedToSendCodeAction() {
        guard let presenter = self.presenter else {
            return
        }
        guard let number = phoneNumberTextField.text else {
            presenter.showError(error: AuthorizationError.emptyPhoneNumber)
            return
        }
        getCodeButton.isEnabled = false
        getCodeButton.backgroundColor = R.color.disabled_button_color()
        presenter.sendPhoneNumberAction(number: number)
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
        textField.text = newString.format(with: NumberFormat.bel.rawValue)
        return false
    }
}
