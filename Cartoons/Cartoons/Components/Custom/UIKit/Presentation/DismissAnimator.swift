//
//  DismissAnimator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 20.11.20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Dismiss Animation

class DismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let controller = transitionContext.viewController(forKey: .from) else {
            return
        }
        
        let animationDuration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: animationDuration) {
            controller.view.alpha = 0.0
        }
        completion: { finished in
            controller.view.removeFromSuperview()
            transitionContext.completeTransition(finished)
        }
    }
}
