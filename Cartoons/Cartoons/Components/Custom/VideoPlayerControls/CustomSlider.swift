//
//  CustomProgressView.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/14/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CustomSlider: UISlider {
    @IBInspectable var trackHeight: CGFloat = 8
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
            return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: trackHeight))
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setThumbImage(R.image.thumb_slider_image()?.withTintColor(R.color.cinnabar().unwrapped), for: .normal)
        setMinimumTrackImage(R.image.slider_progress(), for: .normal)
    }
}
