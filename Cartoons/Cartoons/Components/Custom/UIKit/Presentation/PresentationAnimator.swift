//
//  PresentationAnimator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 19.11.20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Presentation Animation

class PresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let controller = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        controller.view.alpha = 0.0
        transitionContext.containerView.addSubview(controller.view)
        let animationDuration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: animationDuration) {
            controller.view.alpha = 1.0
        }
        completion: { finished in
            transitionContext.completeTransition(finished)
        }
    }
}
