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
    private lazy var activityIndicator = UIActivityIndicatorView()
    
    var isInProgress: Bool {
        didSet {
            if isInProgress {
                activityIndicator.color = .white
                addSubview(activityIndicator)
                activityIndicator.snp.makeConstraints {
                    $0.leading.equalToSuperview().offset(30)
                    $0.centerY.equalToSuperview()
                }
                activityIndicator.startAnimating()
            } else {
                activityIndicator.removeFromSuperview()
            }
        }
    }
    
    override init(frame: CGRect) {
        self.isInProgress = false
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButton() {
        isEnabled = true
        setTitleColor(.white, for: .normal)
        titleLabel?.layer.shadowColor = UIColor.black.cgColor
        titleLabel?.layer.shadowOffset = CGSize(width: 2.0, height: 1.0)
        titleLabel?.font = R.font.aliceRegular(size: 15)
        layer.cornerRadius = 20
        layer.borderColor = .none
        backgroundColor = R.color.downriver()
    }
}
