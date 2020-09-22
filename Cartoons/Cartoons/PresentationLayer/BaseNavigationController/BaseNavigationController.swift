//
//  BaseNavigationController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/22/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    private enum Const {
        static let titleSize: CGFloat = 40
        static let subtitleSize: CGFloat = 14
        static let ImageSize: CGFloat = 80
        static let ImageRightMargin: CGFloat = 20
        static let ImageBottomMargin: CGFloat = 10
    }
    
    private lazy var appearance: UINavigationBarAppearance = {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = R.color.navigation_bar_color()
        appearance.largeTitleTextAttributes = [ NSAttributedString.Key.foregroundColor:
            UIColor.white, NSAttributedString.Key.font: R.font.aliceRegular(size: Const.titleSize) ]
        appearance.shadowColor = .black
        return appearance
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        navigationBar.prefersLargeTitles = true
        navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        navigationBar.layer.shadowRadius = 4.0
        navigationBar.layer.shadowOpacity = 1.0
        navigationBar.layer.masksToBounds = false
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}

extension UINavigationController {
    var subtitle: UILabel {
        let firstFrame = CGRect(x: 0, y: 0, width: navigationBar.frame.width / 2, height: navigationBar.frame.height / 2)
        let subtitle = UILabel(frame: firstFrame)
        subtitle.attributedText = NSAttributedString(string: R.string.localizable.cartoons_screen_subtitle(), attributes: [NSAttributedString.Key.foregroundColor:
            UIColor.white.withAlphaComponent(0.48), NSAttributedString.Key.font: R.font.aliceRegular(size: 14)])
        navigationBar.addSubview(subtitle)
        subtitle.snp.makeConstraints {
            $0.top.equalTo(navigationBar).offset(25)
            $0.leading.equalTo(navigationBar).offset(20)
        }
        return subtitle
    }
    
    var imageView: UIImageView {
        let imageView = UIImageView(image: UIImage())
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.trailing.equalTo(navigationBar).offset(-20)
            $0.bottom.equalTo(navigationBar).offset(-10)
        }
        return imageView
    }
    
    func setSubTitle(title: String) {
        subtitle.text = title
    }
    
    func setImageView(image: UIImage?) {
        imageView.image = image
    }
}
