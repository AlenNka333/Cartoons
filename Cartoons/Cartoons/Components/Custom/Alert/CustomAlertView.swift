//
//  CustomAlertView.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/9/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class CustomAlertView: UIView {
    static let instance = CustomAlertView()
    var delegate: CustomAlertViewDelegate?
    
    @IBOutlet private var parentView: UIView!
    @IBOutlet private weak var alertView: UIView!
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var agreeButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed(Constants.alertClassName, owner: self, options: nil)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        parentView.backgroundColor = UIColor.clear
        alertView.layer.cornerRadius = 10
        cancelButton.layer.cornerRadius = 20
        cancelButton.layer.shadowColor = UIColor.darkGray.cgColor
        cancelButton.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        cancelButton.layer.shadowRadius = 5.0
        cancelButton.layer.shadowOpacity = 0.3
        cancelButton.layer.masksToBounds = false
        
        agreeButton.layer.cornerRadius = 20
        agreeButton.layer.shadowColor = UIColor.darkGray.cgColor
        agreeButton.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        agreeButton.layer.shadowRadius = 5.0
        agreeButton.layer.shadowOpacity = 0.3
        agreeButton.layer.masksToBounds = false
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func showAlert(title: String, message: String, alertType: AlertType) {
        titleLabel.text = title
        titleLabel.textColor = .black
        messageLabel.text = message
        messageLabel.textColor = .black
        switch alertType {
        case .success:
            agreeButton.isHidden = true
            cancelButton.snp.makeConstraints {
                $0.centerX.equalTo(parentView)
            }
            cancelButton.backgroundColor = R.color.enabled_button_color()
        case .error:
            agreeButton.isHidden = true
            cancelButton.snp.makeConstraints {
                $0.centerX.equalTo(parentView)
            }
            cancelButton.backgroundColor = R.color.cinnabar()
        case .question:
            agreeButton.backgroundColor = R.color.enabled_button_color()
            cancelButton.backgroundColor = R.color.cinnabar()
        }
        UIApplication.shared.windows.first { $0.isKeyWindow == true }?.addSubview(parentView)
    }
    
    @IBAction private func onClickCancelAction(_ sender: Any) {
        parentView.removeFromSuperview()
    }
    
    @IBAction private func onClickAgreeAction(_ sender: Any) {
        delegate?.agreeButtonTapped()
        parentView.removeFromSuperview()
    }
}
