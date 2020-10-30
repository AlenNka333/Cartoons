//
//  AuthorizationAssembly.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/7/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class AuthorizationAssembly: Assembly {
    static func makeAuthorizationCoordinator(serviceLocator: Locator) -> AuthorizationCoordinator {
        return AuthorizationCoordinator(serviceLocator: serviceLocator)
    }
    
    static func makeAuthorizationController(serviceLocator: Locator, completion: @escaping (String, String) -> Void) -> AuthorizationViewController {
        let view = AuthorizationViewController()
        let presenter = AuthorizationPresenter(view: view, serviceLocator: serviceLocator)
        presenter.openVerificationClosure = completion
        view.presenter = presenter
        return view
    }
    
    static func makeVerificationController(serviceLocator: Locator,
                                           verificationId: String,
                                           number: String,
                                           completion: @escaping (() -> Void)) -> VerificationViewController {
        let view = VerificationViewController()
        let presenter = VerificationPresenter(view: view,
                                              serviceLocator: serviceLocator,
                                              verificationId: verificationId,
                                              number: number)
        presenter.successSessionClosure = completion
        view.presenter = presenter
        return view
    }
}
