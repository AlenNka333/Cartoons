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
    var countdownTimer: Timer!
    var timer = DefaultValues.totalTime
    
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

    private lazy var otpCodeTextField = CustomTextField()
        
       private lazy var ownView: UIView = {
           view = UIView()
           view.backgroundColor = UIColor(patternImage: R.image.main_background()!)
           return view
       }()

     private lazy var resendButton = CustomButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToHideKeyboardOnTapOnView()
        setupUI()
        startTimer()
    }
    
    override func loadView() {
           self.view = ownView
       }
    
    private func setupUI() {
        resendButton.isEnabled = false
        resendButton.backgroundColor = R.color.disabled_button_color()
//        view.addSubview(verificationLabel)
//
//        view.addSubview(otpCodeTextField)
//        otpCodeTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
//        otpCodeTextField.snp.makeConstraints {
//            $0.height.equalTo(40)
//            $0.centerX.equalToSuperview()
//
//        }
//        view.addSubview(timerLabel)
//        timerLabel.snp.makeConstraints {
//            $0.width.equalTo(blackView).offset(-60)
//            $0.top.equalTo(verificationLabel).offset(100)
//            $0.centerX.equalTo(blackView)
//        }
//        view.addSubview(resendButton)
//        resendButton.snp.makeConstraints {
//            $0.width.equalTo(blackView).offset(-20)
//            $0.height.equalTo(50)
//            $0.centerX.equalToSuperview()
//            $0.top.equalTo(otpCodeTextField).offset(60)
//        }
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
        countdownTimer.invalidate()
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
        CustomAlertView.instance.showAlert(title: R.string.localizable.error(), message: error.localizedDescription, alertType: .error)
    }
}
