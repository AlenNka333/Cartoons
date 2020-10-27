//
//  AuthorizationCoordinator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/7/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class AuthorizationCoordinator: Coordinator {
    let authorizationService = AuthorizationService()
    
    var parent: Coordinator?
    var rootController: UIViewController
    var successSessionClosure: (() -> Void)?
    
    init() {
        self.rootController = UINavigationController()
    }
    
    func start() {
       let view = AuthorizationAssembly.makeAuthorizationController()
        let presenter = AuthorizationPresenter(view: view, authorizationService: authorizationService)
        presenter.openVerificationClosure = { verificationId, number in
            self.openVerificationScreen(verificationId: verificationId, number: number)
        }
        view.presenter = presenter
        (rootController as? UINavigationController)?.pushViewController(view, animated: true)
    }
    
    func openVerificationScreen(verificationId: String, number: String) {
        let view = AuthorizationAssembly.makeVerificationController()
        let presenter = VerificationPresenter(view: view,
                                              authorizationService: authorizationService,
                                              verificationId: verificationId,
                                              number: number)
        presenter.successSessionClosure = { [weak self] in
            guard let closure = self?.successSessionClosure else {
                return
            }
            closure()
        }
        view.presenter = presenter
        (rootController as? UINavigationController)?.pushViewController(view, animated: true)
    }
}
