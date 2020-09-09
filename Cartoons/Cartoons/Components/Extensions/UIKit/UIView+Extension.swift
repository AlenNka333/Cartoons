import Foundation
import SnapKit
import UIKit

extension UIView {
    func setAnchor(width: CGFloat, height: CGFloat) {
        setAnchor(top: nil,
                  left: nil,
                  bottom: nil,
                  right: nil,
                  paddingTop: 0,
                  paddingLeft: 0,
                  paddingBottom: 0,
                  paddingRight: 0,
                  width: width,
                  height: height)
    }

    func setAnchor(top: NSLayoutYAxisAnchor?,
                   left: NSLayoutXAxisAnchor?,
                   bottom: NSLayoutYAxisAnchor?,
                   right: NSLayoutXAxisAnchor?,
                   paddingTop: CGFloat, paddingLeft: CGFloat,
                   paddingBottom: CGFloat, paddingRight: CGFloat,
                   width: CGFloat = 0, height: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }

        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }

        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: paddingRight).isActive = true
        }

        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }

        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
}
