//
//  OnboardingCoordinator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class OnboardingCoordinator: CoordinatorProtocol {
    let firebaseManager = FirebaseManager()
    var root: UIViewController
    var successOnboardingSession: (() -> Void)?
    
    init() {
        self.root = UIViewController()
    }
    
    func start() {
        root = OnboardingAssembly.makeOnboardingController()
        guard let view = (root as? PageViewController) else {
            return
        }
        let presenter = PageControllerPresenter(view: view, firebaseManager: firebaseManager)
        presenter.openAuthorizationScreen = {
            self.successOnboardingSession?()
        }
        (root as? PageViewController)?.presenter = presenter       
    }
}
