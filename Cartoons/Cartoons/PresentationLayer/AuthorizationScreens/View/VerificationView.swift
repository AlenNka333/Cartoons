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
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var verificationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 3
        label.text = R.string.localizable.verification_message_key()
        return label
    }()

    private lazy var backgroundImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: R.image.village_background.name)
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()

    private lazy var continueButton: UIButton = {
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

    func mainStackView() -> UIStackView {
        let verificationTextField = OneTimeCodeTextField(frame: frame)
        verificationTextField.setAnchor(width: 0, height: 70)
        let stackView = UIStackView(arrangedSubviews: [verificationLabel, verificationTextField, continueButton])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }

    func setup() {
        addSubview(backgroundImageView)
        let stackView = mainStackView()
        addSubview(stackView)
        backgroundImageView.setAnchor(top: topAnchor,
                                      left: leftAnchor,
                                      bottom: bottomAnchor,
                                      right: rightAnchor,
                                      paddingTop: 0,
                                      paddingLeft: 0,
                                      paddingBottom: 0,
                                      paddingRight: 0)
        
        continueButton.setAnchor(width: 0, height: 50)
        stackView.setAnchor(width: frame.width - 60, height: 230)
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
