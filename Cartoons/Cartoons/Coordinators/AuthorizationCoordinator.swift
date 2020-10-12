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
    
    var parent: CoordinatorProtocol?
    var root: UIViewController
    var successSessionClosure: () -> Void = {}
    
    init() {
        self.root = UINavigationController()
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
        presenter.successSessionClosure = { [weak self] in
            self?.successSessionClosure()
        }
        view.presenter = presenter
        (root as? UINavigationController)?.pushViewController(view, animated: true)
    }
}
