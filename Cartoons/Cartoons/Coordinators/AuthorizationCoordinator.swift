//
//  AuthorizationCoordinator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/7/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class AuthorizationCoordinator: Coordinator {
    let serviceLocator: Locator
    
    var parent: Coordinator?
    var rootController: UINavigationController
    var successSessionClosure: (() -> Void)?
    
    init(serviceLocator: Locator) {
        self.rootController = UINavigationController()
        self.serviceLocator = serviceLocator
    }
    
    func start() {
        let view = AuthorizationAssembly.makeAuthorizationController(serviceLocator: serviceLocator)
        view.transitionDelegate = self
        rootController.pushViewController(view, animated: true)
    }
    
    func openVerificationScreen(verificationId: String, number: String) {
        let view = AuthorizationAssembly.makeVerificationController(serviceLocator: serviceLocator,
                                                                    verificationId: verificationId,
                                                                    number: number)
        view.transitionDelegate = self
        view.modalPresentationStyle = .fullScreen
        rootController.pushViewController(view, animated: true)
    }
}

extension AuthorizationCoordinator: AuthorizationTransitionDelegate {
    func transit(_ verificationId: String, number: String) {
        openVerificationScreen(verificationId: verificationId, number: number)
    }
}

extension AuthorizationCoordinator: VerificationTransitionDelegate {
    func transit() {
        successSessionClosure?()
    }
}
