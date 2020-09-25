//
//  Optional + Extension.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/25/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

protocol SimplyInitializable {
    init()
}

extension Optional where Wrapped == String {
    var isNilOrEmpty: String {
        guard let unwrapped = self else {
            return ""
        }
        return unwrapped
    }
}

extension Optional where Wrapped == UIColor {
    var isNilOrEmpty: UIColor {
        guard let unwrapped = self else {
            return UIColor()
        }
        return unwrapped
    }
}

extension Optional where Wrapped == UIImage {
    var isNilOrEmpty: UIImage {
        guard let unwrapped = self else {
            return UIImage()
        }
        return unwrapped
    }
}

extension Optional where Wrapped == UIFont {
    var isNilOrEmpty: UIFont {
        guard let unwrapped = self else {
            return UIFont()
        }
        return unwrapped
    }
}
