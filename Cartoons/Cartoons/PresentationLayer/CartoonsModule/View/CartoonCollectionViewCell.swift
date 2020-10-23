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
        imageView.backgroundColor = R.color.wisteria()
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
    var favouritesIndicatorImage: UIImageView = {
        let view = UIImageView()
        view.image = R.image.star()
        return view
    }()
    
    var video: Cartoon? {
      didSet {
        if let title = video?.title, let thumbnail = video?.thumbnail {
            thumbnailView.kf.setImage(with: thumbnail)
            titleLabel.text = title
        } else if let title = video?.title, let link = video?.link {
            generateThumbnail(with: link)
            titleLabel.text = title
        }
      }
    }
    
    func generateThumbnail(with url: URL) {
        let avAsset = AVURLAsset(url: url)
        DispatchQueue.global(qos: .userInteractive).async {
            let image = UIImage.generateThumbnail(asset: avAsset)
            DispatchQueue.main.async {
                self.thumbnailView.image = image
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 3, height: 8)
        contentView.layer.shadowOpacity = 0.6
        contentView.layer.shadowRadius = 10
        contentView.layer.masksToBounds = false
        
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
        contentView.addSubview(favouritesIndicatorImage)
        favouritesIndicatorImage.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(10)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        thumbnailView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
