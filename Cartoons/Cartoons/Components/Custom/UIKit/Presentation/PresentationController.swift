//
//  PresentationController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 19.11.20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

class PresentationController: UIPresentationController {
    private var dimmingView: UIView?
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        setupDimmingView()
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else {
            fatalError(R.string.localizable.nil_view())
        }
        let containerViewBounds = containerView.bounds
        var presentedViewFrame: CGRect = .zero
        presentedViewFrame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerViewBounds.size)
        presentedViewFrame.origin.x = (containerViewBounds.size.width - presentedViewFrame.size.width) / 2
        presentedViewFrame.origin.y = (containerViewBounds.size.height - presentedViewFrame.size.height) / 2
        
        return presentedViewFrame
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width * 0.9, height: parentSize.height * 0.8)
    }
    
    override func containerViewWillLayoutSubviews() {
        guard let containerView = containerView else {
            return
        }
        presentedView?.frame = frameOfPresentedViewInContainerView
        dimmingView?.frame = containerView.bounds
    }
}

// MARK: - Presentation Animation

extension PresentationController {
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView,
              let presentedView = presentedView,
              let dimmingView = dimmingView else {
            fatalError(R.string.localizable.nil_view())
        }
        
        containerView.insertSubview(dimmingView, at: 0)
        dimmingView.frame = containerView.bounds
        dimmingView.alpha = 0.0
        
        presentedView.frame = frameOfPresentedViewInContainerView
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }
        
        coordinator.animate { _ in
            self.dimmingView?.alpha = 1.0
        }
    }
}

// MARK: - Dismissing Animation

extension PresentationController {
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView?.alpha = 0.0
            return
        }
        
        coordinator.animate { _ in
            self.dimmingView?.alpha = 0.0
        }
    }
}

extension PresentationController {
    func setupDimmingView() {
        dimmingView = UIView()
        dimmingView?.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        dimmingView?.alpha = 0.0
        dimmingView?.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                 action: #selector(handleTap)))
    }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }
}
