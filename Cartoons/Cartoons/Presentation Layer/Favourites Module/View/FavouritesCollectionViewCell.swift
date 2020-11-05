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
            contentView.addSubview(titleLabel)
            titleLabel.sizeToFit()
            titleLabel.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.center.equalToSuperview()
            }
        }
      }
    }
    
    var state: ProgressState = .done
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = R.color.main_blue()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
