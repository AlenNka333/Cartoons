//
//  OnboardingCoordinator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class OnboardingCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var rootController: UIViewController
    var successSessionClosure: (() -> Void)?
    
    init() {
        self.rootController = UIViewController()
    }
    
    func start() {
        let view = OnboardingAssembly.makeOnboardingController()
        view.transitionDelegate = self
        rootController = view
    }
}

extension OnboardingCoordinator: OnboardingTransitionDelegate {
    func transit() {
        successSessionClosure?()
    }
}
