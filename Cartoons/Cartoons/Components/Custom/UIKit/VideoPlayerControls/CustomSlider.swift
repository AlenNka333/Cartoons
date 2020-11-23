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
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: thumbHeight))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSlider()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSlider()
    }
    
    func setupSlider() {
        setThumbImage(R.image.thumb_slider_image()?.withTintColor(R.color.cinnabar().unwrapped), for: .normal)
        setMinimumTrackImage(R.image.slider_progress(), for: .normal)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setThumbImage(R.image.thumb_slider_image()?.withTintColor(R.color.cinnabar().unwrapped), for: .normal)
        setMinimumTrackImage(R.image.slider_progress(), for: .normal)
    }
}
