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
    private enum Const {
        static let titleSize: CGFloat = 40
        static let subtitleSize: CGFloat = 14
        static let bottomOffset: CGFloat = -16
    }
    
    var imageAction: (() -> Void)?
    
    private lazy var appearance: UINavigationBarAppearance = {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = R.color.navigation_bar_color()
        appearance.largeTitleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.white,
                                                NSAttributedString.Key.font: R.font.aliceRegular(size: Const.titleSize).unwrapped]
        appearance.shadowColor = .black
        return appearance
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage())
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let subtitle: UILabel = {
        let subtitle = UILabel()
        return subtitle
    }()
    
    private let activityIndicator = UIActivityIndicatorView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setupUI()
    }
    
    func setupUI() {
        navigationBar.prefersLargeTitles = true
        delegate = self
        navigationItem.largeTitleDisplayMode = .always
        navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        navigationBar.layer.shadowRadius = 4.0
        navigationBar.layer.shadowOpacity = 1.0
        navigationBar.layer.masksToBounds = false
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.addSubview(subtitle)
        subtitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.leading.equalToSuperview().offset(20)
        }
        navigationBar.addSubview(imageView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(editProfileImage))
        imageView.addGestureRecognizer(tap)
        imageView.snp.makeConstraints {
            $0.height.width.equalTo(70)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(Const.bottomOffset)
        }
        navigationBar.addSubview(activityIndicator)
        activityIndicator.color = .white
        activityIndicator.snp.makeConstraints {
            $0.center.equalTo(imageView)
        }
    }
}

extension BaseNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            navigationBar.largeContentTitle = ""
            imageView.removeFromSuperview()
            subtitle.removeFromSuperview()
            return nil
        } else {
            setupUI()
            return nil
        }        
    }
}

extension BaseNavigationController {
    func setSubTitle(title: String) {
        subtitle.attributedText = NSAttributedString(string: title,
                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.48),
                                                                  NSAttributedString.Key.font: R.font.aliceRegular(size: 14).unwrapped])
    }
    
    func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func setImage(image: UIImage?, isEnabled: Bool) {
        imageView.image = image
        imageView.isUserInteractionEnabled = isEnabled
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
    
    func setDefaultImage(image: UIImage?) {
        imageView.isUserInteractionEnabled = true
        imageView.image = image
    }
    
    @objc func editProfileImage() {
        imageAction?()
    }
}
