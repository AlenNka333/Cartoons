//
//  VerificationView.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/3/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit
import Rswift

class VerificationView: UIView {
    private lazy var verificationLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.verification_message_key()
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.setAnchor(width: frame.width - 60, height: 0)
        return label
    }()
    
    private lazy var blackView: UIView = {
        let yView = UIView()
        yView.backgroundColor = .black
        yView.alpha = 0.6
        yView.setAnchor(width: frame.width - 30, height: frame.height / 2)
        yView.layer.masksToBounds = false
        yView.layer.shadowColor = UIColor.black.cgColor
        yView.layer.shadowRadius = 4.0
        yView.layer.shadowOffset = CGSize(width: -1.0, height: 1.0)
        yView.layer.shadowOpacity = 1.0
        return yView
    }()

    private lazy var backgroundImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: R.image.village_background.name)
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()

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
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [otpCodeTextField, verifyButton])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        stackView.setAnchor(width: frame.width - 60, height: 100)
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        addSubview(backgroundImageView)
        addSubview(blackView)
        //addSubview(timerLabel)
        addSubview(verificationLabel)
        addSubview(mainStackView)
        setConstraints()
    }
    
    func setConstraints() {
        backgroundImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        blackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
        }
        verificationLabel.snp.makeConstraints {
            $0.top.equalTo(blackView).offset(60)
            $0.centerX.equalTo(blackView)
        }
        otpCodeTextField.snp.makeConstraints {
            $0.width.equalTo(0)
            $0.height.equalTo(40)
        }
        verifyButton.snp.makeConstraints {
            $0.width.equalTo(0)
            $0.height.equalTo(50)
        }
        
        mainStackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -30).isActive = true
        mainStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
