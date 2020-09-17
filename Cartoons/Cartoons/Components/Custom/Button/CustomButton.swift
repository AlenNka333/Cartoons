//
//  CustomButton.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/17/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButton() {
        snp.makeConstraints {
            $0.width.equalTo(300)
            $0.height.equalTo(50)
        }
        isEnabled = true
        setTitle(R.string.localizable.get_code_button_key(), for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.layer.shadowColor = UIColor.black.cgColor
        titleLabel?.layer.shadowOffset = CGSize(width: 2.0, height: 1.0)
        titleLabel?.font = UIFont(name: "Alice-Regular", size: 15)
        titleLabel?.layer.masksToBounds = false
        layer.cornerRadius = 20
        layer.borderColor = .none
        backgroundColor = R.color.enabled_button_color()
    }
}
