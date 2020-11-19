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
    private var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = R.color.wisteria()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    private var titleLabel: UILabel = {
        let label = BorderedLabel(with: .init(top: 5, left: 10, bottom: 10, right: 5))
        label.textColor = .white
        label.clipsToBounds = true
        label.layer.cornerRadius = 15
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.font = UIFont(name: R.font.cinzelDecorativeBold.fontName, size: 25)
        label.backgroundColor = R.color.downriver()?.withAlphaComponent(0.6)
        label.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        return label
    }()
    private var loadingIndicatorImageView: UIImageView = {
        let view = UIImageView()
        view.image = R.image.star()
        return view
    }()
    
    var video: Cartoon? {
        didSet {
            if let title = video?.title, let thumbnail = video?.thumbnailImageURL {
                thumbnailImageView.kf.setImage(with: thumbnail)
                titleLabel.text = title
            } else if let title = video?.title, let link = video?.globalCartoonLink {
                generateThumbnailImage(with: link)
                titleLabel.text = title
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 3, height: 8)
        contentView.layer.shadowOpacity = 0.6
        contentView.layer.shadowRadius = 10
        
        contentView.addSubview(thumbnailImageView)
        thumbnailImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentView.addSubview(titleLabel)
        titleLabel.sizeToFit()
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalTo(contentView.frame.width * 0.7)
        }
        contentView.addSubview(loadingIndicatorImageView)
        loadingIndicatorImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(10)
            $0.size.equalTo(40)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
        loadingIndicatorImageView.image = R.image.star()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animate(isHighlighted: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animate(isHighlighted: false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animate(isHighlighted: false)
    }
}

extension CartoonCollectionViewCell {
    private func animate(isHighlighted: Bool, completion: ((Bool) -> Void)? = nil) {
        isHighlighted ? (UIView.animate(withDuration: 0.5,
                                        delay: 0,
                                        usingSpringWithDamping: 1,
                                        initialSpringVelocity: 0,
                                        options: [.allowUserInteraction],
                                        animations: {
                                            self.transform = .init(scaleX: 0.96, y: 0.96)
                                        },
                                        completion: completion))
            : (UIView.animate(withDuration: 0.5,
                              delay: 0,
                              usingSpringWithDamping: 1,
                              initialSpringVelocity: 0,
                              options: [.allowUserInteraction],
                              animations: {
                                self.transform = .identity
                              },
                              completion: completion))
    }
    
    func generateThumbnailImage(with url: URL) {
        let avAsset = AVURLAsset(url: url)
        DispatchQueue.global(qos: .userInteractive).async {
            let image = UIImage.generateThumbnail(asset: avAsset)
            DispatchQueue.main.async {
                self.thumbnailImageView.image = image
            }
        }
    }
    
    func highlightIndicator() {
        loadingIndicatorImageView.image = loadingIndicatorImageView.image?.withRenderingMode(.alwaysTemplate)
        loadingIndicatorImageView.tintColor = UIColor.yellow
    }
}
