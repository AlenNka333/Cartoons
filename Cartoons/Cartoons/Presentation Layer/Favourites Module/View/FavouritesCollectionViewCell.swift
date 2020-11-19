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
    private var titleLabel: UILabel = {
        let label = BorderedLabel(with: .init(top: 10, left: 5, bottom: 10, right: 5))
        label.textColor = .white
        label.clipsToBounds = true
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.font = UIFont(name: R.font.cinzelDecorativeBold.fontName, size: 20)
        label.backgroundColor = UIColor.darkGray.withAlphaComponent(0.4)
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

extension FavouritesCollectionViewCell {
    private func animate(isHighlighted: Bool, completion: ((Bool) -> Void)?=nil) {
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
