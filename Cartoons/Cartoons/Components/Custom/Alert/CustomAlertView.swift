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
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
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
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func showAlert(title: String, message: String, alertType: AlertType) {
        titleLabel.text = title
        messageLabel.text = message
        
        switch alertType {
        case .success:
            doneButton.backgroundColor = UIColor.clear
            doneButton.layer.insertSublayer(GradientLayer.gradient(startColor: R.color.green_yellow()!.cgColor, endColor: R.color.coconut_cream()!.cgColor), at: 0) //need to deal with worse unwrapp
        case .error:
            doneButton.layer.insertSublayer(GradientLayer.gradient(startColor: R.color.cinnabar()!.cgColor, endColor: R.color.linen()!.cgColor), at: 0) //need to deal with worse unwrapp
        }
        
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    @IBAction func onClickDone(_ sender: Any) {
        parentView.removeFromSuperview()
    }
}
