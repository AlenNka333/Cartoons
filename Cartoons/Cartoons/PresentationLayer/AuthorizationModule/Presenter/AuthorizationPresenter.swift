//
//  AuthorizationPresenter.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/4/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

class AuthorizationPresenter: AuthorizationViewPresenterProtocol {
    let view: AuthorizationViewProtocol
    let router: RouterProtocol
    let firebaseManager: FirebaseManager
    
    init(view: AuthorizationViewProtocol, router: RouterProtocol, firebaseManager: FirebaseManager) {
        self.view = view
        self.router = router
        self.firebaseManager = firebaseManager
    }
    
    func sendPhoneNumberAction(number: String) {
        view.showActivityIndicatorAction()
        firebaseManager.sendPhoneNumber(number: number) { [weak self] result in
            self?.view.stopActivityIndicatorAction()
            let manager = self?.firebaseManager
            switch result {
            case let .success(verificationId):
                self?.router.showOTPController(verificationId: verificationId, firebaseManager: manager.unwrapped, number: number, animated: true)
            case .failure(let error):
                self?.view.setError(error: error)
            }
        }
    }
    
    func showError(error: Error) {
        view.setError(error: error)
    }
}
