//
//  OnboardingCoordinator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class OnboardingCoordinator: Coordinator {
    var parent: UINavigationController?
    var rootController: UIViewController
    var successSessionClosure: (() -> Void)?
    
    init() {
        self.rootController = UIViewController()
    }
    
    func start() {
        rootController = OnboardingAssembly.makeOnboardingController { [weak self] in
            self?.successSessionClosure?()
        }
    }
}
