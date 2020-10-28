//
//  OnboardingCoordinator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class OnboardingCoordinator: CoordinatorProtocol {
    var parent: CoordinatorProtocol?
    var root: UIViewController
    var successSessionClosure: (() -> Void)?
    
    init() {
        self.root = UIViewController()
    }
    
    func start() {
        root = OnboardingAssembly.makeOnboardingController { [weak self] in
            self?.successSessionClosure?()
        }
    }
}
