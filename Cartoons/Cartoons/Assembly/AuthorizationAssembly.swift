//
//  AuthorizationAssembly.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/7/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class AuthorizationAssembly: Assembly {
    static func makeAuthorizationCoordinator() -> AuthorizationCoordinator {
        return AuthorizationCoordinator()
    }
    
    static func makeAuthorizationController(authorizationService: AuthorizationService, completion: @escaping ((String, String) -> Void)) -> AuthorizationViewController {
        let view = AuthorizationViewController()
        let presenter = AuthorizationPresenter(view: view, authorizationService: authorizationService)
        presenter.openVerificationClosure = completion
        view.presenter = presenter
        return view
    }
    
    static func makeVerificationController(authorizationService: AuthorizationService,
                                           verificationId: String,
                                           number: String, completion: @escaping (() -> Void)) -> VerificationViewController {
        let view = VerificationViewController()
        let presenter = VerificationPresenter(view: view,
                                              authorizationService: authorizationService,
                                              verificationId: verificationId,
                                              number: number)
        presenter.successSessionClosure = completion
        view.presenter = presenter
        return view
    }
}
