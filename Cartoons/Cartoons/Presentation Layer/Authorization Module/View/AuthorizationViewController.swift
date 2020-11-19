import UIKit

class AuthorizationViewController: BaseViewController {
    weak var transitionDelegate: AuthorizationTransitionProtocol?
    var presenter: AuthorizationViewPresenterProtocol?
    
    private lazy var appLabelView = AppNameView()
    private lazy var phoneNumberTextField = CustomTextField()
    private lazy var signInButton = CustomButton()
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupToHideKeyboardOnTapOnView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: R.image.main_background.name)
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.isHidden = true
    }
    
    override func setupUI() {
        super.setupUI()
    
        view.addSubview(appLabelView)
        appLabelView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(160)
            $0.leading.trailing.equalToSuperview().inset(50)
        }
        
        stackView.addArrangedSubview(phoneNumberTextField)
        stackView.addArrangedSubview(signInButton)
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            if UIScreen.main.bounds.height > 736 {
                $0.centerY.equalToSuperview().offset(-60)
            } else {
                $0.top.equalTo(appLabelView.snp_bottomMargin).offset(100)
            }
            $0.leading.trailing.equalToSuperview().inset(50)
        }
        
        phoneNumberTextField.delegate = self
        phoneNumberTextField.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalToSuperview()
        }
        
        signInButton.setTitle(R.string.localizable.get_code_button_key(), for: .normal)
        signInButton.isEnabled = true
        signInButton.backgroundColor = R.color.navigation_bar_color()
        signInButton.addTarget(self, action: #selector(buttonTappedToSendCodeAction), for: .touchUpInside)
        signInButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalToSuperview()
        }
    }
    
    override func showActivityIndicator() {
        signInButton.isInProgress = true
    }
    
    override func stopActivityIndicator() {
        signInButton.isInProgress = false
    }
    
    override func showError(error: Error) {
        super.showError(error: error)
        signInButton.isEnabled = true
        signInButton.backgroundColor = R.color.navigation_bar_color()
    }
}

extension AuthorizationViewController: AuthorizationViewProtocol {
    func transit(_ verificationId: String, _ phoneNumber: String) {
        transitionDelegate?.transit(verificationId, phoneNumber)
    }
}

extension AuthorizationViewController {
    @objc func buttonTappedToSendCodeAction() {
        guard let presenter = self.presenter else {
            return
        }
        guard let phoneNumber = phoneNumberTextField.text else {
            presenter.showError(error: AuthorizationError.emptyPhoneNumber)
            return
        }
        signInButton.isEnabled = false
        signInButton.backgroundColor = R.color.disabled_button_color()
        presenter.sendRequest(with: phoneNumber)
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
