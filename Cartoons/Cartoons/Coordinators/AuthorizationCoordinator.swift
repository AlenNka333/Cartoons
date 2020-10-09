//
//  AuthorizationCoordinator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/7/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class AuthorizationCoordinator: CoordinatorProtocol {
    let authorizationService = AuthorizationService()
    
    var root: UIViewController
    var registrationSucceededClosure: (String) -> Void = { _ in }
    
    init() {
        self.root = UINavigationController()
    }
    
    deinit {
        print("Auth deinit")
    }
        
    func start() {
        let view = AuthorizationAssembly.makeAuthorizationController()
        let presenter = AuthorizationPresenter(view: view, authorizationService: authorizationService)
        presenter.openVerificationClosure = { verificationId, number in
            self.openVerificationScreen(verificationId: verificationId, number: number)
        }
        view.presenter = presenter
        (root as? UINavigationController)?.pushViewController(view, animated: true)
    }
    
    func openVerificationScreen(verificationId: String, number: String) {
        let view = AuthorizationAssembly.makeVerificationController()
        let presenter = VerificationPresenter(view: view,
                                              authorizationService: authorizationService,
                                              verificationId: verificationId,
                                              number: number)
        presenter.registrationSucceedClosure = { number in
            self.registrationSucceededClosure(number)
        }
        view.presenter = presenter
        (root as? UINavigationController)?.pushViewController(view, animated: true)
    }
}
