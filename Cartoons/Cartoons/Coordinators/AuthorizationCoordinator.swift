//
//  AuthorizationCoordinator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/7/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class AuthorizationCoordinator: CoordinatorProtocol {
    let locator: Locator
    
    var parent: CoordinatorProtocol?
    var rootController: UIViewController
    var successSessionClosure: (() -> Void)?
    
    init(locator: Locator) {
        self.rootController = UINavigationController()
        self.locator = locator
    }
    
    func start() {
        let view = AuthorizationAssembly.makeAuthorizationController(locator: locator) { [weak self] verificationId, number in
            self?.openVerificationScreen(verificationId: verificationId, number: number)
        }
        
        (rootController as? UINavigationController)?.pushViewController(view, animated: true)
    }
    
    func openVerificationScreen(verificationId: String, number: String) {
        let view = AuthorizationAssembly.makeVerificationController(locator: locator,
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
