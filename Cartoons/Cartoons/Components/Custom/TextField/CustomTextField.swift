//
//  CustomTextField.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/17/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTextField() {
        snp.makeConstraints {
            $0.width.equalTo(300)
            $0.height.equalTo(50)
        }
        keyboardType = .numberPad
        borderStyle = .none
        textColor = .black
        layer.cornerRadius = 10
        backgroundColor = .white
        attributedPlaceholder =
            NSAttributedString(string: R.string.localizable.phone_label_key(),
                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.48), NSAttributedString.Key.font: R.font.aliceRegular(size: 15)!])
        setLeftPaddingPoints(10)
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
