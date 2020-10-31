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
    var rootController: UIViewController
    var successSessionClosure: (() -> Void)?
    
    init(serviceLocator: Locator) {
        self.rootController = UINavigationController()
        self.serviceLocator = serviceLocator
    }
    
    func start() {
        let view = AuthorizationAssembly.makeAuthorizationController(serviceLocator: serviceLocator)
        view.transitionDelegate = self
        (rootController as? UINavigationController)?.pushViewController(view, animated: true)
    }
    
    func openVerificationScreen(verificationId: String) {
        let view = AuthorizationAssembly.makeVerificationController(serviceLocator: serviceLocator,
                                                                    verificationId: verificationId)
        view.transitionDelegate = self
        (rootController as? UINavigationController)?.pushViewController(view, animated: true)
    }
}

extension AuthorizationCoordinator: AuthorizationTransitionDelegate {
    func transit(_ verificationId: String) {
        openVerificationScreen(verificationId: verificationId)
    }
}

extension AuthorizationCoordinator: VerificationTransitionDelegate {
    func transit() {
        successSessionClosure?()
    }
}
