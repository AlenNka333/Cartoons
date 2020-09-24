//
//  ProfileView.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/24/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

class ProfileView: UIView {
    var delegate: ProfileViewDelegate?
    var profileImageView = UIImageView()
    var phoneLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = R.color.navigation_bar_color()
        snp.makeConstraints {
            $0.width.equalTo(300)
            $0.height.equalTo(220)
        }
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints {
            $0.height.width.equalTo(120)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(50)
        }
        profileImageView.layer.cornerRadius = 60
        profileImageView.layer.borderWidth = 3
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(changeProfileImageAction)))
        
        addSubview(phoneLabel)
        phoneLabel.attributedText = NSAttributedString(string: R.string.localizable.phone_label_key(),
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: R.font.aliceRegular(size: 20)!])
        phoneLabel.textAlignment = .center
        phoneLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func setPhone(phone: String) {
        phoneLabel.text = phone
    }
    
    @objc func changeProfileImageAction() {
        delegate?.changeProfileImageTapped()
    }
}
