//
//  VerificationCodeViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/3/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import SnapKit
import UIKit

class VerificationCodeViewController: UIViewController {
    var presenter: VerificationViewPresenterProtocol!
    let activityIndicator = UIActivityIndicatorView()
    var countdownTimer: Timer!
    var totalTime = 60
    
    private lazy var verificationLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.verification_message_key()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var timerLabel: UILabel = {
           let label = UILabel()
           label.text = "60"
           label.font = .systemFont(ofSize: 30)
           label.numberOfLines = 0
           label.textAlignment = .center
           label.textColor = .white
           return label
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

    private lazy var otpCodeTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.textContentType = .oneTimeCode
        textField.layer.cornerRadius = 5
        textField.backgroundColor = R.color.login_button_color()?.withAlphaComponent(0.3)
        textField.textColor = UIColor(white: 1, alpha: 0.9)
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.autocorrectionType = .no
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        return textField
    }()

     private lazy var resendButton: UIButton = {
        let button = UIButton()
        let string = NSAttributedString(string: R.string.localizable.resend_button_key(),
                                        attributes: [NSAttributedString.Key.font:
                                            UIFont.systemFont(ofSize: 18),
                                                     .foregroundColor: UIColor.white])
        let attributedString = NSMutableAttributedString(attributedString: string)
        button.setAttributedTitle(attributedString, for: .normal)
        button.isEnabled = false
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.layer.borderColor = R.color.frozen_button()?.cgColor
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToHideKeyboardOnTapOnView()
        setupUI()
        view.backgroundColor = .white
        resendButton.addTarget(self, action: #selector(self.resendButtonClicked), for: .touchUpInside)
        startTimer()
    }
    
    private func setupUI() {
        view.addSubview(blackView)
        view.addSubview(verificationLabel)
        view.addSubview(otpCodeTextField)
        view.addSubview(timerLabel)
        view.addSubview(resendButton)
        setConstraints()
    }
    
    private func setConstraints() {
        blackView.snp.makeConstraints {
            $0.height.equalTo(view.snp.height).offset(-200)
            $0.width.equalTo(view.snp.width).offset(-30)
            $0.center.equalToSuperview()
        }
        verificationLabel.snp.makeConstraints {
            $0.width.equalTo(blackView).offset(-60)
            $0.top.equalTo(blackView).offset(60)
            $0.centerX.equalTo(blackView)
        }
        timerLabel.snp.makeConstraints {
            $0.width.equalTo(blackView).offset(-60)
            $0.top.equalTo(verificationLabel).offset(100)
            $0.centerX.equalTo(blackView)
        }
        otpCodeTextField.snp.makeConstraints {
            $0.width.equalTo(blackView).offset(-20)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(blackView)
        }
        resendButton.snp.makeConstraints {
            $0.width.equalTo(blackView).offset(-20)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(otpCodeTextField).offset(60)
        }
    }
}

extension VerificationCodeViewController {
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    @objc func updateTime() {
        timerLabel.text = "\(totalTime)"
        if totalTime != 0 {
            totalTime -= 1
        } else {
            resendButton.isEnabled = true
            resendButton.layer.borderColor = R.color.enabled_button()?.cgColor
            endTimer()
        }
    }
    func endTimer() {
        countdownTimer.invalidate()
    }
    @objc func textDidChange() {
        guard let text = otpCodeTextField.text else {
            return
        }
        if text.count == 6 {
            endTimer()
            view.endEditing(true)
            presenter.verifyUser(verificationCode: text)
        }
    }
    @objc func resendButtonClicked() {
        totalTime = 60
        timerLabel.text = "\(totalTime)"
        startTimer()
    }
}

extension VerificationCodeViewController: VerificationViewProtocol {
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
        CustomAlertView.instance.showAlert(title: "Error", message: error.localizedDescription, alertType: .error)
    }
}
