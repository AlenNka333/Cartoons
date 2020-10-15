//
//  StreramingFeatureViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/14/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class StreamingFeatureViewController: UIViewController {
    private lazy var tvModelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.tv_model()
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 4, height: 2)
        imageView.layer.shadowOpacity = 0.6
        return imageView
    }()
    private lazy var princessArielImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.princess_ariel()
        return imageView
    }()
    private lazy var princessCinderellaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.princess_cinderella()
        return imageView
    }()
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: R.string.localizable.onBoarding_first_logo_key(),
                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Alice-Regular", size: 24)!])
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(patternImage: R.image.launch_background()!)
        view.addSubview(tvModelImageView)
        tvModelImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(150)
        }
        view.addSubview(princessArielImageView)
        princessArielImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
        }
        view.addSubview(princessCinderellaImageView)
        princessCinderellaImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-20)
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
