//
//  BaseNavigationController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/22/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Kingfisher
import UIKit

class BaseNavigationController: UINavigationController {
    private enum NavigationBarStyle {
        case system
        case custom
    }
    
    private enum Const {
        static let titleSize: CGFloat = 40
        static let subtitleSize: CGFloat = 14
        static let bottomOffset: CGFloat = -16
    }
    
    private let activityIndicator = UIActivityIndicatorView()
    private let subtitleLabel = UILabel()
    private let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage())
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var navigationBarStyle = NavigationBarStyle.system
    private lazy var navigationBarAppearance: UINavigationBarAppearance = {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = R.color.downriver()
        appearance.largeTitleTextAttributes = [ .foregroundColor: UIColor.white,
                                                .font: R.font.aliceRegular(size: Const.titleSize).unwrapped]
        appearance.shadowColor = .black
        return appearance
    }()
    
    var changeProfileIconClosure: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
        interactivePopGestureRecognizer?.isEnabled = true
        delegate = self
        setupUI()
    }
    
    func setupUI() {
        navigationBar.prefersLargeTitles = true
        navigationBar.tintColor = .white
        
        navigationBarStyle = NavigationBarStyle.system
        
        navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        navigationBar.layer.shadowRadius = 4.0
        navigationBar.layer.shadowOpacity = 1.0
        
        navigationBar.standardAppearance = navigationBarAppearance
        navigationBar.compactAppearance = navigationBarAppearance
        navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
}

extension BaseNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            profileImageView.removeFromSuperview()
            subtitleLabel.removeFromSuperview()
            setNavigationBarHidden(false, animated: false)
            return nil
        } else if operation == .pop {
            navigationBar.isHidden = false
            return nil
        } else {
            setupUI()
            return nil
        }
    }
}

extension BaseNavigationController {
    func setupCustomizedUI(image: UIImage, subtitle: String, isUserInteractionEnabled: Bool) {
        interactivePopGestureRecognizer?.delegate = nil
        interactivePopGestureRecognizer?.isEnabled = true
        subtitleLabel.attributedText = NSAttributedString(string: subtitle,
                                                          attributes: [ .foregroundColor: UIColor.white.withAlphaComponent(0.48),
                                                                        .font: R.font.aliceRegular(size: 14).unwrapped])
        profileImageView.image = image
        profileImageView.isUserInteractionEnabled = isUserInteractionEnabled
        
        updateUI()
    }
    
    func updateUI() {
        navigationBarStyle = NavigationBarStyle.custom
        
        navigationBar.tintColor = .white
        navigationBar.prefersLargeTitles = true
        
        navigationBar.standardAppearance = navigationBarAppearance
        navigationBar.compactAppearance = navigationBarAppearance
        navigationBar.scrollEdgeAppearance = navigationBarAppearance
        
        navigationBar.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.leading.equalToSuperview().offset(20)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(editProfileImage))
        profileImageView.addGestureRecognizer(tap)
        navigationBar.addSubview(profileImageView)
        profileImageView.snp.makeConstraints {
            $0.height.width.equalTo(70)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(Const.bottomOffset)
        }
        
        navigationBar.addSubview(activityIndicator)
        activityIndicator.color = .white
        activityIndicator.snp.makeConstraints {
            $0.center.equalTo(profileImageView)
        }
    }
   
    func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func setProfileImage(image: UIImage?) {
        profileImageView.isUserInteractionEnabled = true
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.image = image
    }
    
    func setProfileImage(path: URL?) {
        profileImageView.isUserInteractionEnabled = true
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.kf.setImage(with: path)
    }
    
    func setDefaultImage() {
        profileImageView.isUserInteractionEnabled = true
        profileImageView.image = R.image.profile_icon()
    }
    
    @objc func editProfileImage() {
        changeProfileIconClosure?()
    }
}
