import UIKit
import FirebaseAuth

class AuthorizationViewController: UIViewController {
    var presenter: AuthorizationViewPresenterProtocol!
    
    private lazy var labelTextView: UIImageView = {
        let label = UIImageView()
        label.image = R.image.cartoons_label_3()
        label.contentMode = .scaleAspectFill
        label.setAnchor(width: 250, height: 100)
        return label
    }()
    
    private lazy var labelImageView: UIImageView = {
        let label = UIImageView()
        label.image = R.image.label()
        label.contentMode = .scaleAspectFill
        label.setAnchor(width: 150, height: 150)
        return label
    }()
    
    private lazy var blackView: UIView = {
        let yView = UIView()
        yView.backgroundColor = .black
        yView.alpha = 0.6
        yView.setAnchor(width: self.view.frame.width - 30, height: self.view.frame.height / 2)
        yView.layer.masksToBounds = false
        yView.layer.shadowColor = UIColor.black.cgColor
        yView.layer.shadowRadius = 4.0
        yView.layer.shadowOffset = CGSize(width: -1.0, height: 1.0)
        yView.layer.shadowOpacity = 1.0
        return yView
    }()

//    private lazy var backgroundImageView: UIImageView = {
//        let imgView = UIImageView()
//        imgView.image = R.image.village_background()
//        imgView.contentMode = .scaleAspectFill
//        return imgView
//    }()

    lazy var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.attributedPlaceholder =
            NSAttributedString(string: R.string.localizable.phone_label_key(), attributes:
            [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.3)])
        textField.textContentType = .telephoneNumber
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = 5
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height:textField.frame.height))
        textField.leftViewMode = .always
        textField.backgroundColor = R.color.login_button_color()?.withAlphaComponent(0.3)
        textField.textColor = UIColor(white: 1, alpha: 0.9)
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.autocorrectionType = .no
        return textField
    }()

     lazy var sendCodeButton: UIButton = {
        let button = UIButton()
        let string = NSAttributedString(string: R.string.localizable.send_code_button_key(),
                                        attributes: [NSAttributedString.Key.font:
                                            UIFont.systemFont(ofSize: 18),
                                                     .foregroundColor: UIColor.white])
        let attributedString = NSMutableAttributedString(attributedString: string)
        button.setAttributedTitle(attributedString, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(named: R.color.send_code_button_color.name)?.withAlphaComponent(1).cgColor
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.view.backgroundColor = .red
        self.setupToHideKeyboardOnTapOnView()
        phoneNumberTextField.delegate = self
        sendCodeButton.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setup() {
//        view.addSubview(backgroundImageView)
        view.addSubview(blackView)
        view.addSubview(labelTextView)
        view.addSubview(labelImageView)
        view.addSubview(phoneNumberTextField)
        view.addSubview(sendCodeButton)
        setConstraints()
    }
    
    func setConstraints() {
//        backgroundImageView.snp.makeConstraints {
//            $0.top.equalToSuperview()
//            $0.bottom.equalToSuperview()
//            $0.leading.equalToSuperview()
//            $0.trailing.equalToSuperview()
//        }
        blackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        labelTextView.snp.makeConstraints {
            $0.top.equalTo(blackView).offset(20)
            $0.centerX.equalTo(blackView)
        }
        labelImageView.snp.makeConstraints {
            $0.top.equalTo(labelTextView).offset(30)
            $0.centerX.equalTo(blackView)
        }
        
        phoneNumberTextField.snp.makeConstraints {
            $0.width.equalTo(view.frame.width - 100)
            $0.height.equalTo(40)
            $0.centerX.equalTo(view.center)
            $0.centerY.equalTo(blackView)
        }
        sendCodeButton.snp.makeConstraints {
            $0.width.equalTo(view.frame.width - 100)
            $0.height.equalTo(50)
            $0.centerX.equalTo(view.center)
            $0.top.equalTo(phoneNumberTextField).offset(60)
        }
    }
}

extension AuthorizationViewController: AuthorizationViewProtocol {
    func setError(error: Error?) {
        let alert = UIAlertController(title: "", message: error?.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}

extension AuthorizationViewController {
    @objc func buttonClicked() {
        guard let number = phoneNumberTextField.text else {
            //presenter.showError()
            return
        }
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
        textField.text = newString.format(with: "+XXX XX XXX-XX-XX")
        return false
    }
}
