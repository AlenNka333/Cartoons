//
//  OfflineWatchingFeatureViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/14/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class OfflineWatchingFeatureViewController: UIViewController {
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.frozen_onBoarding()
        return imageView
    }()
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: R.string.localizable.onBoarding_second_logo_key(),
                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                               NSAttributedString.Key.font: UIFont(name: "Alice-Regular", size: 24).unwrapped])
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(patternImage: R.image.launch_background().unwrapped)
        view.addSubview(mainImageView)
        mainImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-100)
        }
        view.addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview().offset(150)
        }
    }
}
