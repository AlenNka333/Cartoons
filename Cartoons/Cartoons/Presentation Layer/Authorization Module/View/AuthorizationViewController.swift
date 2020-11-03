import UIKit

class AuthorizationViewController: BaseViewController {
    weak var transitionDelegate: AuthorizationTransitionDelegate?
    var presenter: AuthorizationViewPresenterProtocol?
    
    private lazy var appLabelView = CustomLabelView()
    private lazy var phoneNumberTextField = CustomTextField()
    private lazy var getCodeButton: UIButton = CustomButton()
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
        getCodeButton.isEnabled = true
        getCodeButton.backgroundColor = R.color.enabled_button_color()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func setupUI() {
        super.setupUI()
        view.addSubview(appLabelView)
        appLabelView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(160)
            $0.leading.trailing.equalToSuperview().inset(50)
        }
        phoneNumberTextField.delegate = self
        getCodeButton.setTitle(R.string.localizable.get_code_button_key(), for: .normal)
        getCodeButton.addTarget(self, action: #selector(buttonTappedToSendCodeAction), for: .touchUpInside)
        stackView.addArrangedSubview(phoneNumberTextField)
        stackView.addArrangedSubview(getCodeButton)
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            if UIScreen.main.bounds.height > 736 {
                $0.centerY.equalToSuperview().offset(-60)
            } else {
                $0.top.equalTo(appLabelView.snp_bottomMargin).offset(60)
            }
            $0.leading.trailing.equalToSuperview().inset(50)
        }
        phoneNumberTextField.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalToSuperview()
        }
        getCodeButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalToSuperview()
        }
    }
    
    override func showActivityIndicator() {
        super.showActivityIndicator()
        activityIndicator.center = view.center
    }
    
    override func stopActivityIndicator() {
        super.stopActivityIndicator()
    }
    
    override func showError(error: Error) {
        super.showError(error: error)
        getCodeButton.isEnabled = true
        getCodeButton.backgroundColor = R.color.enabled_button_color()
    }
}

extension AuthorizationViewController: AuthorizationViewProtocol {
    func transit(verificationId: String, number: String) {
        transitionDelegate?.transit(verificationId, number)
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
