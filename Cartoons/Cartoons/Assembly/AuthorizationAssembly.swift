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
    
    static func makeAuthorizationController(serviceLocator: Locator) -> AuthorizationViewController {
        let view = AuthorizationViewController()
        let presenter = AuthorizationPresenter(view: view, serviceLocator: serviceLocator)
        view.presenter = presenter
        return view
    }
    
    static func makeVerificationController(serviceLocator: Locator,
                                           verificationId: String,
                                           phoneNumber: String) -> VerificationViewController {
        let view = VerificationViewController()
        let presenter = VerificationPresenter(view: view,
                                              serviceLocator: serviceLocator,
                                              verificationId: verificationId,
                                              phoneNumber: phoneNumber)
        view.presenter = presenter
        return view
    }
}
