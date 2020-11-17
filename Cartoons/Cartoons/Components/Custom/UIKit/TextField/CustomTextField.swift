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
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
    func setupTextField() {
        keyboardType = .numberPad
        borderStyle = .none
        textColor = .black
        layer.cornerRadius = 10
        backgroundColor = .white
        attributedPlaceholder =
            NSAttributedString(string: R.string.localizable.phone_label_key(),
                               attributes: [.foregroundColor: UIColor.black.withAlphaComponent(0.48),
                                            .font: R.font.aliceRegular(size: 15).unwrapped])
        setLeftPaddingPoints(10)
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
