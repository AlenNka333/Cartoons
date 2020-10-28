//
//  VerificationViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/3/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import SnapKit
import UIKit

class VerificationViewController: BaseViewController {
    enum Constant {
        static let otpCodeCount = 6
    }
    
    var presenter: VerificationViewPresenterProtocol?
    var countdownTimer: Timer?
    
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
        presenter?.startTimer()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: R.image.main_background.name)
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
    }
    
    override func setupUI() {
        super.setupUI()
        view.addSubview(verificationLabel)
        verificationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        view.addSubview(circleImage)
        circleImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(verificationLabel.snp_bottomMargin).offset(50)
            $0.width.height.equalTo(80)
        }
        view.addSubview(timerLabel)
        timerLabel.snp.makeConstraints {
            $0.center.equalTo(circleImage)
        }
        view.addSubview(otpCodeTextField)
        otpCodeTextField.attributedPlaceholder =
            NSAttributedString(string: R.string.localizable.otp_code_key(),
                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.48),
                                            NSAttributedString.Key.font: R.font.aliceRegular(size: 15).unwrapped])
        otpCodeTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        otpCodeTextField.snp.makeConstraints {
            $0.width.equalTo(30)
            if UIScreen.main.bounds.height > 736 {
                $0.centerY.equalToSuperview().offset(-60)
            } else {
                $0.top.equalTo(timerLabel.snp_bottomMargin).offset(60)
            }
            $0.leading.equalToSuperview().offset(50)
            $0.trailing.equalToSuperview().offset(-50)
        }
        view.addSubview(resendButton)
        resendButton.isEnabled = false
        resendButton.backgroundColor = R.color.disabled_button_color()
        resendButton.setTitle(R.string.localizable.resend_button_key(), for: .normal)
        resendButton.addTarget(self, action: #selector(resendButtonTappedAction), for: .touchUpInside)
        resendButton.snp.makeConstraints {
            $0.top.equalTo(otpCodeTextField.snp_bottomMargin).offset(20)
            $0.leading.equalToSuperview().offset(50)
            $0.trailing.equalToSuperview().offset(-50)
        }
    }
    
    override func showError(error: Error) {
        super.showError(error: error)
    }
}

extension VerificationViewController {
    @objc func textDidChange() {
        guard let presenter = self.presenter else {
            return
        }
        guard let text = otpCodeTextField.text else {
            return
        }
        if text.count == Constant.otpCodeCount {
            presenter.endTimer()
            view.endEditing(true)
            presenter.verifyUser(verificationCode: text)
        }
    }
    
    @objc func resendButtonTappedAction() {
        resendButton.isEnabled = false
        resendButton.backgroundColor = R.color.disabled_button_color()
        presenter?.startTimer()
        presenter?.resendVerificationCode()
    }
}

extension VerificationViewController: VerificationViewProtocol {
    func setLabelText(number: String) {
        verificationLabel.text?.append("\n\(number)")
    }
    
    func startTimer(timer: Timer, time: Int) {
        countdownTimer = timer
        timerLabel.text = "\(time)"
    }
    
    func endTimer() {
        resendButton.isEnabled = true
        resendButton.backgroundColor = R.color.enabled_button_color()
        countdownTimer?.invalidate()
    }
    
    func updateTime(timer: Int) {
        timerLabel.text = "\(timer)"
    }
}
