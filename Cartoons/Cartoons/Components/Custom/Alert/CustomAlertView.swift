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
    
    @IBOutlet private var parentView: UIView!
    @IBOutlet private weak var alertView: UIView!
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var doneButton: UIButton!
    
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
        doneButton.layer.cornerRadius = 20
        doneButton.layer.shadowColor = UIColor.darkGray.cgColor
        doneButton.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        doneButton.layer.shadowRadius = 5.0
        doneButton.layer.shadowOpacity = 0.3
        doneButton.layer.masksToBounds = false
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func showAlert(title: String, message: String, alertType: AlertType) {
        titleLabel.text = title
        messageLabel.text = message
        switch alertType {
        case .success:
            doneButton.backgroundColor = R.color.green_yellow()
        case .error:
            doneButton.backgroundColor = R.color.cinnabar()
        }
        UIApplication.shared.windows.first { $0.isKeyWindow == true }?.addSubview(parentView)
    }
    
    @IBAction private func onClickDone(_ sender: Any) {
        parentView.removeFromSuperview()
    }
}
