//
//  CustomSlider.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/14/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CustomSlider: UISlider {
    @IBInspectable var thumbHeight: CGFloat = 10
    
    override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
        return CGRect(x: 0, y: 0, width: frame.width, height: thumbHeight)
    }
    
    override func prepareForInterfaceBuilder() {
        setThumbImage(R.image.thumb_slider_image()?.withTintColor(R.color.cinnabar().unwrapped), for: .normal)
        setMinimumTrackImage(R.image.slider_progress(), for: .normal)
    }
}
