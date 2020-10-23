//
//  CartoonPosterView.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/23/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

class CartoonPosterView: UIView {
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = R.color.wisteria()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var gradientView = UIImageView(image: R.image.gradient_borders())
    
    init(frame: CGRect, link: URL) {
        super.init(frame: frame)
        setupUI(link: link)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(link: URL) {
        addSubview(mainImageView)
        mainImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        mainImageView.kf.setImage(with: link)
        mainImageView.addSubview(gradientView)
        gradientView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
