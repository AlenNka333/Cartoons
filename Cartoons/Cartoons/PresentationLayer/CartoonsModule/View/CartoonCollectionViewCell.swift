//
//  CartoonCollectionViewCell.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/13/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import AVFoundation
import Foundation
import UIKit

class CartoonCollectionViewCell: UICollectionViewCell {
    static var reuseIdentifier: String {
      return String(describing: CartoonCollectionViewCell.self)
    }
    var thumbnailView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    var titleLabel: UILabel = {
        let label = BorderedLabel(withInsets: 5, 5, 10, 10)
        label.textColor = .white
        label.clipsToBounds = true
        label.font = UIFont(name: R.font.cinzelDecorativeBold.fontName, size: 25)
        label.backgroundColor = R.color.navigation_bar_color()?.withAlphaComponent(0.6)
        label.layer.cornerRadius = 10
        label.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        label.numberOfLines = .zero
        label.textAlignment = .center
        return label
    }()
    
    var video: Cartoon? {
      didSet {
        if (video?.title != nil) && (video?.link != nil) {
            generateThumbnail(with: video?.link)
            titleLabel.text = video?.title
        }
      }
    }
    
    func generateThumbnail(with url: URL?) {
        guard let url = url else {
            return
        }
        let avAsset = AVURLAsset(url: url)
        thumbnailView.image = UIImage.generateThumbnail(asset: avAsset)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 5, height: 10)
        self.layer.shadowRadius = 1
        contentView.addSubview(thumbnailView)
        thumbnailView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        contentView.addSubview(titleLabel)
        titleLabel.sizeToFit()
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.lessThanOrEqualTo(thumbnailView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
