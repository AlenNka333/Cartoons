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

enum ProgressState {
    case inProgress
    case stopped
    case done
}

class FavouritesCollectionViewCell: UICollectionViewCell {
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = R.color.wisteria()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    private lazy var progressView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor.black.withAlphaComponent(0.6).cgColor
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        return view
    }()
    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.download_button(), for: .normal)
        return button
    }()
    private var titleLabel: UILabel = {
        let label = BorderedLabel(with: .init(top: 5, left: 10, bottom: 10, right: 5))
        label.textColor = .white
        label.clipsToBounds = true
        label.font = UIFont(name: R.font.cinzelDecorativeBold.fontName, size: 18)
        label.backgroundColor = R.color.navigation_bar_color()?.withAlphaComponent(0.6)
        label.layer.cornerRadius = 15
        label.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        label.numberOfLines = .zero
        label.textAlignment = .center
        return label
    }()
    
    var video: Cartoon? {
      didSet {
        if let title = video?.title, let thumbnail = video?.thumbnail {
            thumbnailImageView.kf.setImage(with: thumbnail)
            titleLabel.text = title
        } else if let title = video?.title, let link = video?.link {
            generateThumbnail(with: link)
            titleLabel.text = title
        }
      }
    }
    
    var state: ProgressState = .done
    
    func generateThumbnail(with url: URL) {
        let avAsset = AVURLAsset(url: url)
        DispatchQueue.global(qos: .userInteractive).async {
            let image = UIImage.generateThumbnail(asset: avAsset)
            DispatchQueue.main.async {
                self.thumbnailImageView.image = image
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 15
        
        contentView.addSubview(thumbnailImageView)
        thumbnailImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentView.addSubview(titleLabel)
        titleLabel.sizeToFit()
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
    }
}

extension FavouritesCollectionViewCell {
    func setProgressView() {
        contentView.addSubview(progressView)
        progressView.addSubview(downloadButton)
        downloadButton.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.center.equalToSuperview()
        }
        progressView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setProgress() {
    }
    
    func setState(state: ProgressState) {
        self.state = state
        switch state {
        case .inProgress:
            setProgressView()
        case .done:
            progressView.removeFromSuperview()
        case .stopped:
            downloadButton.setImage(R.image.pause(), for: .normal)
        }
    }
}
