//
//  UserInfoHeader.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/22/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

class UserInfoHeader: UIView {
    var imageAction: (() -> Void)?
    
    private let activityIndicator = UIActivityIndicatorView()
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage())
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = ""
        label.clipsToBounds = true
        return label
    }()
    private lazy var separatorView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(imageView)
        backgroundColor = R.color.picotee_blue()
        let tap = UITapGestureRecognizer(target: self, action: #selector(editProfileImage))
        imageView.addGestureRecognizer(tap)
        imageView.snp.makeConstraints {
            $0.height.width.equalTo(60)
            $0.center.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(20)
        }
        addSubview(activityIndicator)
        activityIndicator.color = .white
        activityIndicator.style = .medium
        activityIndicator.snp.makeConstraints {
            $0.center.equalTo(imageView)
        }
        addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        addSubview(separatorView)
    }
    
    func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func setProfileImage(image: UIImage?) {
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.image = image
    }
    
    func setProfileImage(path: URL?) {
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.kf.setImage(with: path)
    }
    
    func setDefaultImage() {
        imageView.isUserInteractionEnabled = true
        imageView.image = R.image.profile_icon()
    }
    
    func setPhoneNumber(number: String) {
        phoneLabel.attributedText = NSAttributedString(string: number,
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                                    NSAttributedString.Key.font: R.font.aliceRegular(size: 15).unwrapped])
    }
    
    @objc func editProfileImage() {
        imageAction?()
    }
}
