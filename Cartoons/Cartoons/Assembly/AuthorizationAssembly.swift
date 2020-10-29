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
    
    static func makeAuthorizationController(authorizationService: AuthorizationService) -> AuthorizationViewController {
        let view = AuthorizationViewController()
        let presenter = AuthorizationPresenter(view: view,
                                               authorizationService: authorizationService)
        view.presenter = presenter
        return view
    }
    
    static func makeVerificationController(authorizationService: AuthorizationService,
                                           verificationId: String) -> VerificationViewController {
        let view = VerificationViewController()
        let presenter = VerificationPresenter(view: view,
                                              authorizationService: authorizationService,
                                              verificationId: verificationId)
        view.presenter = presenter
        return view
    }
}
