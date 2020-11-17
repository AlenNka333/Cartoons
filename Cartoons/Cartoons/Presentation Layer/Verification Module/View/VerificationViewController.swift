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
    
    weak var transitionDelegate: VerificationTransitionDelegate?
    var presenter: VerificationViewPresenterProtocol?
    var countdownTimer: Timer?
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    private lazy var codeTextField = CustomTextField()
    private lazy var resendButton = CustomButton()
    private lazy var circleImageView: UIImageView = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToHideKeyboardOnTapOnView()
        presenter?.startTimer()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.isHidden = false
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
        codeTextField.attributedPlaceholder =
            NSAttributedString(string: R.string.localizable.otp_code_key(),
                               attributes: [.foregroundColor: UIColor.black.withAlphaComponent(0.48),
                                            .font: R.font.aliceRegular(size: 15).unwrapped])
        codeTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        resendButton.isEnabled = false
        resendButton.backgroundColor = R.color.disabled_button_color()
        resendButton.setTitle(R.string.localizable.resend_button_key(), for: .normal)
        resendButton.addTarget(self, action: #selector(resendButtonTappedAction), for: .touchUpInside)
        
        view.addSubview(verificationLabel)
        verificationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(160)
            $0.leading.trailing.equalToSuperview().inset(50)
        }
        view.addSubview(circleImageView)
        circleImageView.snp.makeConstraints {
            $0.size.equalTo(80)
            $0.top.equalTo(verificationLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        circleImageView.addSubview(timerLabel)
        timerLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        stackView.addArrangedSubview(codeTextField)
        stackView.addArrangedSubview(resendButton)
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(50)
            if UIScreen.main.bounds.height > 736 {
                $0.centerY.equalToSuperview()
            } else {
                $0.top.equalTo(circleImageView.snp.bottom).offset(20)
            }
        }
        codeTextField.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalToSuperview()
        }
        resendButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalToSuperview()
        }
    }
    
    override func showError(error: Error) {
        super.showError(error: error)
        codeTextField.text?.removeAll()
    }
}

extension VerificationViewController {
    @objc func textDidChange() {
        guard let presenter = self.presenter else {
            return
        }
        guard let text = codeTextField.text else {
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
        countdownTimer?.invalidate()
        countdownTimer = timer
        timerLabel.text = "\(time)"
    }
    
    func endTimer() {
        resendButton.isEnabled = true
        resendButton.backgroundColor = R.color.navigation_bar_color()
        countdownTimer?.invalidate()
        timerLabel.text = "0"
    }
    
    func updateTime(timer: Int) {
        timerLabel.text = "\(timer)"
    }
    
    func stopTimer() {
        countdownTimer?.invalidate()
    }
    
    func transit() {
        transitionDelegate?.transit()
    }
}
