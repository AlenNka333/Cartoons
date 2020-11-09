//
//  FavouritesCollectionViewCell.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/30/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import AVFoundation
import Foundation
import UIKit

class FavouritesCollectionViewCell: UICollectionViewCell {
    private lazy var progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.progressTintColor = .white
        progress.transform = CGAffineTransform(scaleX: 1, y: 2)
        progress.clipsToBounds = true
        return progress
    }()
    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.download_button(), for: .normal)
        return button
    }()
    private var titleLabel: UILabel = {
        let label = BorderedLabel(with: .init(top: 10, left: 5, bottom: 10, right: 5))
        label.textColor = .white
        label.clipsToBounds = true
        label.font = UIFont(name: R.font.cinzelDecorativeBold.fontName, size: 20)
        label.backgroundColor = UIColor.darkGray.withAlphaComponent(0.4)
        label.numberOfLines = .zero
        label.textAlignment = .center
        return label
    }()
    
    var video: Cartoon? {
      didSet {
        if let title = video?.title {
            titleLabel.text = title
        }
      }
    }
    var progress: Float? {
        willSet(newValue) {
            progressView.progress = newValue ?? 0.0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = R.color.main_blue()
        contentView.addSubview(titleLabel)
        titleLabel.sizeToFit()
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavouritesCollectionViewCell {
    func setProgressView() {
        let darkView = UIView()
        darkView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        darkView.addSubview(progressView)
        progressView.layer.cornerRadius = 3
        progressView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().offset(-40)
        }
        contentView.addSubview(darkView)
        darkView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
