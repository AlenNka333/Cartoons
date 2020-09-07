//
//  VerificationCodeViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/3/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit
import FirebaseAuth

class VerificationCodeViewController: UIViewController {
    var presenter: VerificationViewPresenterProtocol!
    
    private lazy var verificationLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.verification_message_key()
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.setAnchor(width: self.view.frame.width - 60, height: 0)
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
//        imgView.image = UIImage(named: R.image.village_background.name)
//        imgView.contentMode = .scaleAspectFill
//        return imgView
//    }()

    lazy var otpCodeTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.textContentType = .oneTimeCode
        textField.layer.cornerRadius = 5
        textField.backgroundColor = UIColor(named: R.color.login_button_color.name)?.withAlphaComponent(0.3)
        textField.textColor = UIColor(white: 1, alpha: 0.9)
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.autocorrectionType = .no
        return textField
    }()

     lazy var verifyButton: UIButton = {
        let button = UIButton()
        let string = NSAttributedString(string: R.string.localizable.continue_button_key(),
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
        self.setupToHideKeyboardOnTapOnView()
        setup()
        self.view.backgroundColor = .green
        verifyWithOTP()
    }
    
    func verifyWithOTP() {
        guard let verificationID = UserDefaults.standard.string(forKey: "firebase_verification") else {
            return
        }
        guard let code = otpCodeTextField.text, code != "" else {
            return
        }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: code)
        Auth.auth().signIn(with: credential) { (authResult, error) in
        if let error = error {
           print(error.localizedDescription)
          } else {
            print("Success")
           }
    }
    }
    
    func setup() {
//        view.addSubview(backgroundImageView)
        view.addSubview(blackView)
        view.addSubview(verificationLabel)
        view.addSubview(otpCodeTextField)
        view.addSubview(verifyButton)
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
        verificationLabel.snp.makeConstraints {
            $0.top.equalTo(blackView).offset(60)
            $0.centerX.equalTo(blackView)
        }
        otpCodeTextField.snp.makeConstraints {
            $0.width.equalTo(view.frame.width - 100)
            $0.height.equalTo(40)
            $0.centerX.equalTo(view.center)
            $0.centerY.equalTo(blackView)
        }
        verifyButton.snp.makeConstraints {
            $0.width.equalTo(view.frame.width - 100)
            $0.height.equalTo(50)
            $0.centerX.equalTo(view.center)
            $0.top.equalTo(otpCodeTextField).offset(60)
        }
    }
}
