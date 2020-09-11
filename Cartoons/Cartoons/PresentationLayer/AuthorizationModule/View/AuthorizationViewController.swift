import UIKit

class AuthorizationViewController: UIViewController {
    var presenter: AuthorizationViewPresenterProtocol!
    let alertView = CustomAlertView()
    let activityIndicator = UIActivityIndicatorView()
    
    private lazy var textLabelImageView: UIImageView = {
        let image = UIImageView()
        image.image = R.image.cartoons_label()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var labelImageView: UIImageView = {
        let image = UIImageView()
        image.image = R.image.label()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var blackView: UIView = {
        let blackView = UIView()
        blackView.backgroundColor = .black
        blackView.alpha = 0.6
        blackView.layer.masksToBounds = false
        blackView.layer.shadowColor = UIColor.black.cgColor
        blackView.layer.shadowRadius = 4.0
        blackView.layer.shadowOffset = CGSize(width: -1.0, height: 1.0)
        blackView.layer.shadowOpacity = 1.0
        return blackView
    }()

    private lazy var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.attributedPlaceholder =
            NSAttributedString(string: R.string.localizable.phone_label_key(), attributes:
            [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.3)])
        textField.textContentType = .telephoneNumber
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = 5
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.backgroundColor = R.color.login_button_color()?.withAlphaComponent(0.3)
        textField.textColor = UIColor(white: 1, alpha: 0.9)
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.autocorrectionType = .no
        textField.delegate = self
        return textField
    }()

     private lazy var getCodeButton: UIButton = {
        let button = UIButton()
        let string = NSAttributedString(string: R.string.localizable.get_code_button_key(),
                                        attributes: [NSAttributedString.Key.font:
                                            UIFont.systemFont(ofSize: 18),
                                                     .foregroundColor: UIColor.white])
        let attributedString = NSMutableAttributedString(attributedString: string)
        button.setAttributedTitle(attributedString, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.layer.borderColor = R.color.enabled_button()?.cgColor
        button.addTarget(self, action: #selector(self.buttonTappedToSendCodeAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupToHideKeyboardOnTapOnView()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(blackView)
        blackView.snp.makeConstraints {
            $0.height.equalToSuperview().offset(-200)
            $0.width.equalToSuperview().offset(-30)
            $0.center.equalToSuperview()
        }
        view.addSubview(textLabelImageView)
        textLabelImageView.snp.makeConstraints {
            $0.width.equalTo(250)
            $0.height.equalTo(100)
            $0.top.equalTo(blackView).offset(20)
            $0.centerX.equalTo(blackView)
        }
        view.addSubview(labelImageView)
        labelImageView.snp.makeConstraints {
            $0.width.height.equalTo(150)
            $0.top.equalTo(textLabelImageView).offset(30)
            $0.centerX.equalTo(blackView)
        }
        view.addSubview(phoneNumberTextField)
        phoneNumberTextField.snp.makeConstraints {
            $0.width.equalTo(blackView).offset(-20)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(blackView)
        }
        view.addSubview(getCodeButton)
        getCodeButton.snp.makeConstraints {
            $0.width.equalTo(blackView).offset(-20)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(phoneNumberTextField).offset(60)
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
        getCodeButton.layer.borderColor = R.color.enabled_button()?.cgColor
    }
}

extension AuthorizationViewController {
    @objc func buttonTappedToSendCodeAction() {
        guard let number = phoneNumberTextField.text else {
            presenter.showError(error: AuthorizationError.emptyPhoneNumber)
            return
        }
        getCodeButton.isEnabled = false
        getCodeButton.layer.borderColor = R.color.frozen_button()?.cgColor
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
