//
//  Optional + Extension.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/25/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

extension Optional where Wrapped == String {
    var unwrapped: String {
        guard let unwrapped = self else {
            return ""
        }
        return unwrapped
    }
}

extension Optional where Wrapped == UIColor {
    var unwrapped: UIColor {
        guard let unwrapped = self else {
            return UIColor()
        }
        return unwrapped
    }
}

extension Optional where Wrapped == UIImage {
    var unwrapped: UIImage {
        guard let unwrapped = self else {
            return UIImage()
        }
        return unwrapped
    }
}

extension Optional where Wrapped == UIFont {
    var unwrapped: UIFont {
        guard let unwrapped = self else {
            return UIFont()
        }
        return unwrapped
    }
}
