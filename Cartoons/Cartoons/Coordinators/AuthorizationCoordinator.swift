//
//  AuthorizationCoordinator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/7/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class AuthorizationCoordinator: CoordinatorProtocol {
    let serviceLocator: Locator
    
    var parent: CoordinatorProtocol?
    var rootController: UIViewController
    var successSessionClosure: (() -> Void)?
    
    init(serviceLocator: Locator) {
        self.rootController = UINavigationController()
        self.serviceLocator = serviceLocator
    }
    
    func start() {
        let view = AuthorizationAssembly.makeAuthorizationController(serviceLocator: serviceLocator) { [weak self] verificationId, number in
            self?.openVerificationScreen(verificationId: verificationId, number: number)
        }
        
        (rootController as? UINavigationController)?.pushViewController(view, animated: true)
    }
    
    func openVerificationScreen(verificationId: String, number: String) {
        let view = AuthorizationAssembly.makeVerificationController(serviceLocator: serviceLocator,
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
