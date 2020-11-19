//
//  CustomAlertView.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/9/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

enum BTAction {
    case cancel
    case accept
}

class CustomAlertViewController: UIViewController {
    @IBOutlet private var parentView: UIView!
    @IBOutlet private weak var alertView: UIView!
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var agreeButton: UIButton!
    
    var alertTitle = String()
    var alertBody = String()
    var alertType: AlertType?
    var buttonAction: ((BTAction) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        alertView.layer.cornerRadius = 10
        
        cancelButton.layer.cornerRadius = 10
        cancelButton.layer.shadowColor = UIColor.darkGray.cgColor
        cancelButton.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        cancelButton.layer.shadowRadius = 5.0
        cancelButton.layer.shadowOpacity = 0.3
        
        agreeButton.layer.cornerRadius = 10
        agreeButton.layer.shadowColor = UIColor.darkGray.cgColor
        agreeButton.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        agreeButton.layer.shadowRadius = 5.0
        agreeButton.layer.shadowOpacity = 0.3
        
        titleLabel.textColor = .black
        titleLabel.text = alertTitle
        messageLabel.textColor = .black
        messageLabel.text = alertBody
        
        guard let type = alertType else {
            dismiss(animated: true, completion: nil)
            return
        }
        switch type {
            case .success:
                agreeButton.isHidden = true
                cancelButton.backgroundColor = R.color.picton_blue()
            case .error:
                agreeButton.isHidden = true
                cancelButton.backgroundColor = R.color.cinnabar()
            case .question:
                agreeButton.backgroundColor = R.color.picton_blue()
                cancelButton.backgroundColor = R.color.cinnabar()
            case .permission:
                agreeButton.setTitle(R.string.localizable.allow(), for: .normal)
                agreeButton.backgroundColor = R.color.picton_blue()
                cancelButton.backgroundColor = R.color.cinnabar()
        }
    }
    
    @IBAction private func onClickCancelAction(_ sender: Any) {
        dismiss(animated: true)
        buttonAction?(BTAction.cancel)
    }
    
    @IBAction private func onClickAgreeAction(_ sender: Any) {
        dismiss(animated: true)
        buttonAction?(BTAction.accept)
    }
}
