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
    
    var parentCoordinator: Coordinator?
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
    
    func openVerificationScreen(verificationId: String, phoneNumber: String) {
        let view = AuthorizationAssembly.makeVerificationController(serviceLocator: serviceLocator,
                                                                    verificationId: verificationId,
                                                                    phoneNumber: phoneNumber)
        view.transitionDelegate = self
        view.modalPresentationStyle = .fullScreen
        rootController.pushViewController(view, animated: true)
    }
}

extension AuthorizationCoordinator: AuthorizationTransitionProtocol {
    func transit(_ verificationId: String, _ phoneNumber: String) {
        openVerificationScreen(verificationId: verificationId, phoneNumber: phoneNumber)
    }
}

extension AuthorizationCoordinator: VerificationTransitionDelegate {
    func transit() {
        successSessionClosure?()
    }
}
