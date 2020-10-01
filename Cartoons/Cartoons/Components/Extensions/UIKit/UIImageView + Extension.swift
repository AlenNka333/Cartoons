//
//  UIImage + Extension.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/30/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import SDWebImage

extension UIImageView {
    /// Start an async image download from URL
    ///
    /// - Parameters:
    ///   - path: URL path.
    func loadImage(from path: String) {
        sd_setImage(with: URL(string: path))
    }

    /// Set placeholderImage. Start an async image download from URL.
    /// - Parameters:
    ///   - path: URL path.
    ///   - placeholder: Image for placeholder
    func loadImage(from path: String, with placeholder: UIImage?) {
        sd_setImage(with: URL(string: path), placeholderImage: placeholder)
    }

    /// Stops the async download of the image
    ///
    /// To avoid dirty response reading inside the reusable cell
    /// need to call this function inside the prepareForReuse:
    ///
    ///    override func prepareForReuse() {
    ///        super.prepareForReuse()
    ///        iconImageView.cancelImageLoading()
    ///    }
    func cancelImageLoading() {
        sd_cancelCurrentImageLoad()
    }
}
