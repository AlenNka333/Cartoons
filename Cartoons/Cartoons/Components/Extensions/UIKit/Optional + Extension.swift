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

extension Optional where Wrapped == UIViewController {
    var unwrapped: UIViewController {
        guard let unwrapped = self else {
            return UIViewController()
        }
        return unwrapped
    }
}

extension Optional where Wrapped == UITabBarController {
    var unwrapped: UITabBarController {
        guard let unwrapped = self else {
            return UITabBarController()
        }
        return unwrapped
    }
}

extension Optional where Wrapped == UIPageViewController {
    var unwrapped: UIPageViewController {
        guard let unwrapped = self else {
            return UIPageViewController()
        }
        return unwrapped
    }
}

extension Optional where Wrapped == BaseNavigationController {
    var unwrapped: BaseNavigationController {
        guard let unwrapped = self else {
            return BaseNavigationController()
        }
        return unwrapped
    }
}

extension Optional where Wrapped == FirebaseManager {
    var unwrapped: FirebaseManager {
        guard let unwrapped = self else {
            return FirebaseManager()
        }
        return unwrapped
    }
}
