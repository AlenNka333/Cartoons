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
    enum DefaultValues {
        static let totalTime = 60
        static let otpCodeCount = 6
    }
    
    var presenter: VerificationViewPresenterProtocol?
    let activityIndicator = UIActivityIndicatorView()
    var countdownTimer: Timer?
    var timer = DefaultValues.totalTime
    let alertService = AlertService()
    
    private lazy var otpCodeTextField = CustomTextField()
    private lazy var resendButton = CustomButton()
    private lazy var circleImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: R.image.ellipse.name)
        return image
    }()
    private lazy var verificationLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.verification_message_key()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = R.font.aliceRegular(size: 20)
        label.textColor = .white
        return label
    }()
    private lazy var timerLabel: UILabel = {
           let label = UILabel()
           label.numberOfLines = 0
           label.textAlignment = .center
           label.font = R.font.aliceRegular(size: 30)
           label.textColor = .white
           return label
       }()
    private lazy var customView: UIView = {
           view = UIView()
        view.backgroundColor = UIColor(patternImage: R.image.main_background().unwrapped)
           return view
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToHideKeyboardOnTapOnView()
        setupUI()
        startTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor(patternImage: R.image.main_background().unwrapped)
    }
    
    private func setupUI() {
        view.addSubview(verificationLabel)
        verificationLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.top.equalToSuperview().offset(100)
        }
        view.addSubview(circleImage)
        circleImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(190)
        }
        view.addSubview(timerLabel)
        timerLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(220)
        }
        view.addSubview(otpCodeTextField)
        otpCodeTextField.attributedPlaceholder =
        NSAttributedString(string: R.string.localizable.otp_code_key(),
                           attributes: [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.48),
                                        NSAttributedString.Key.font: R.font.aliceRegular(size: 15).unwrapped])
        otpCodeTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        otpCodeTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-60)
        }
        view.addSubview(resendButton)
        resendButton.isEnabled = false
        resendButton.backgroundColor = R.color.disabled_button_color()
        resendButton.setTitle(R.string.localizable.resend_button_key(), for: .normal)
        resendButton.addTarget(self, action: #selector(resendButtonTappedAction), for: .touchUpInside)
        resendButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension VerificationCodeViewController {
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        timerLabel.text = "\(timer)"
        if timer != 0 {
            timer -= 1
        } else {
            resendButton.isEnabled = true
            resendButton.backgroundColor = R.color.enabled_button_color()
            endTimer()
        }
    }
    
    func endTimer() {
        countdownTimer?.invalidate()
    }
    
    @objc func textDidChange() {
        guard let presenter = self.presenter else {
            return
        }
        guard let text = otpCodeTextField.text else {
            return
        }
        if text.count == DefaultValues.otpCodeCount {
            endTimer()
            view.endEditing(true)
            presenter.verifyUser(verificationCode: text)
        }
    }
    
    @objc func resendButtonTappedAction() {
        resendButton.isEnabled = false
        resendButton.backgroundColor = R.color.disabled_button_color()
        timer = DefaultValues.totalTime
        timerLabel.text = "\(timer)"
        startTimer()
        presenter?.resendVerificationCode()
    }
}

extension VerificationCodeViewController: VerificationViewProtocol {
    func setLabelText(number: String) {
        verificationLabel.text?.append("\n\(number)")
    }
    
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
        let alertVC = alertService.alert(title: R.string.localizable.error(), body: error.localizedDescription, alertType: .error) {_ in
            return
        }
        present(alertVC, animated: true)
    }
}
