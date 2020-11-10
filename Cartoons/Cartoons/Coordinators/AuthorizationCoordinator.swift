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
        self.rootController = UIViewController()
        self.serviceLocator = serviceLocator
    }
    
    func start() {
        let view = AuthorizationAssembly.makeAuthorizationController(serviceLocator: serviceLocator)
        view.transitionDelegate = self
        rootController = view
    }
    
    func openVerificationScreen(verificationId: String, number: String) {
        let view = AuthorizationAssembly.makeVerificationController(serviceLocator: serviceLocator,
                                                                    verificationId: verificationId,
                                                                    number: number)
        view.transitionDelegate = self
        view.modalPresentationStyle = .fullScreen
        rootController.present(view, animated: true, completion: nil)
    }
}

extension AuthorizationCoordinator: AuthorizationTransitionDelegate {
    func transit(_ verificationId: String, _ number: String) {
        openVerificationScreen(verificationId: verificationId, number: number)
    }
}

extension AuthorizationCoordinator: VerificationTransitionDelegate {
    func transit() {
        successSessionClosure?()
    }
}
