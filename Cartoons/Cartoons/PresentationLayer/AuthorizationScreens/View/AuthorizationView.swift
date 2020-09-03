//
//  AuthorizationView.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/2/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import SnapKit
import UIKit

class AuthorizationView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let label: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor(white: 1, alpha: 1)
        lb.font = UIFont.systemFont(ofSize: 17)
        lb.text = R.string.localizable.phone_label_key()
        return lb
    }()

    let backgroundImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: R.image.village_background.name)
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()

    let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = 5
        textField.backgroundColor = UIColor(named: R.color.login_button_color.name)?.withAlphaComponent(0.3)
        textField.textColor = UIColor(white: 1, alpha: 0.9)
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.autocorrectionType = .no
        return textField
    }()

    let sendCodeButton: UIButton = {
        let button = UIButton()
        let string = NSAttributedString(string: R.string.localizable.send_code_button_key(), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.white])
        let attributedString = NSMutableAttributedString(attributedString: string)
        button.setAttributedTitle(attributedString, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(named: R.color.send_code_button_color.name)?.withAlphaComponent(1).cgColor

        return button
    }()

    func mainStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [label, phoneNumberTextField, sendCodeButton])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }

    func setup() {
        addSubview(backgroundImageView)
        let stackView = mainStackView()
        addSubview(stackView)
        backgroundImageView.setAnchor(top: topAnchor, left: leftAnchor,
                                      bottom: bottomAnchor, right: rightAnchor,
                                      paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        phoneNumberTextField.setAnchor(width: 0, height: 40)
        sendCodeButton.setAnchor(width: 0, height: 50)
        stackView.setAnchor(width: frame.width - 60, height: 130)

        stackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
