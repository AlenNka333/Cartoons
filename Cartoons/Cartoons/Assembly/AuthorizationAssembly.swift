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
    
    static func makeAuthorizationController() -> AuthorizationViewController {
        let view = AuthorizationViewController()
        return view
    }
    
    static func makeVerificationController() -> VerificationViewController {
        let view = VerificationViewController()
        return view
    }
}
