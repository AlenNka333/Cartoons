//
//  BorderedLabel.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/21/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

class BorderedLabel: UILabel {
    var topInset: CGFloat
        var bottomInset: CGFloat
        var leftInset: CGFloat
        var rightInset: CGFloat

        required init(with inset: UIEdgeInsets) {
            topInset = inset.top
            bottomInset = inset.bottom
            leftInset = inset.left
            rightInset = inset.right
            super.init(frame: CGRect.zero)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func drawText(in rect: CGRect) {
            let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
            super.drawText(in: rect.inset(by: insets))
        }

        override var intrinsicContentSize: CGSize {
            get {
                var contentSize = super.intrinsicContentSize
                contentSize.height += topInset + bottomInset
                contentSize.width += leftInset + rightInset
                return contentSize
            }
        }
}
