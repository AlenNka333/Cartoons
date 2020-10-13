//
//  CartoonCollectionViewCell.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/13/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

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
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    var video: Cartoon? {
      didSet {
        thumbnailView.image = UIImage()
        titleLabel.text = video?.title
      }
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
        titleLabel.snp.makeConstraints {
            $0.center.equalTo(thumbnailView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
