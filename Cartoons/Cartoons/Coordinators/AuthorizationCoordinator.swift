//
//  AuthorizationCoordinator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/7/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class AuthorizationCoordinator: Coordinator {
    let authorizationService = AuthorizationService()
    
    var parent: UINavigationController?
    var rootController: UIViewController
    var successSessionClosure: (() -> Void)?
    
    init() {
        self.rootController = UINavigationController()
    }
    
    func start() {
        let view = AuthorizationAssembly.makeAuthorizationController(authorizationService: authorizationService) { verificationId, number in
            self.openVerificationScreen(verificationId: verificationId, number: number)
        }
        (rootController as? UINavigationController)?.pushViewController(view, animated: true)
    }
    
    func openVerificationScreen(verificationId: String, number: String) {
        let view = AuthorizationAssembly.makeVerificationController(authorizationService: authorizationService,
                                                                    verificationId: verificationId,
                                                                    number: number) { [weak self] in
            guard let closure = self?.successSessionClosure else {
                return
            }
            closure()
        }
        (rootController as? UINavigationController)?.pushViewController(view, animated: true)
    }
}
