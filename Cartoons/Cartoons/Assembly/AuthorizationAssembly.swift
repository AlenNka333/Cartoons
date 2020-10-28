//
//  AuthorizationAssembly.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/7/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class AuthorizationAssembly: Assembly {
    static func makeAuthorizationCoordinator(locator: Locator) -> AuthorizationCoordinator {
        return AuthorizationCoordinator(locator: locator)
    }
    
    static func makeAuthorizationController(locator: Locator, completion: @escaping (String, String) -> Void) -> AuthorizationViewController {
        let view = AuthorizationViewController()
        let presenter = AuthorizationPresenter(view: view, locator: locator)
        presenter.openVerificationClosure = completion
        view.presenter = presenter
        return view
    }
    
    static func makeVerificationController(locator: Locator,
                                           verificationId: String,
                                           number: String,
                                           completion: @escaping (() -> Void)) -> VerificationViewController {
        let view = VerificationViewController()
        let presenter = VerificationPresenter(view: view,
                                              locator: locator,
                                              verificationId: verificationId,
                                              number: number)
        presenter.successSessionClosure = completion
        view.presenter = presenter
        return view
    }
}
