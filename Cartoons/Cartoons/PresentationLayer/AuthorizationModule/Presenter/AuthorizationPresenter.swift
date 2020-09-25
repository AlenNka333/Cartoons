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
    let router: RouterProtocol?
    let firebaseManager: FirebaseManager?
    
    init(view: AuthorizationViewProtocol, router: RouterProtocol, firebaseManager: FirebaseManager) {
        self.view = view
        self.router = router
        self.firebaseManager = firebaseManager
    }
    
    func sendPhoneNumberAction(number: String) {
        guard let manager = firebaseManager else {
            return
        }
        view.showActivityIndicatorAction()
        manager.sendPhoneNumber(number: number) { [weak self] result in
            self?.view.stopActivityIndicatorAction()
            switch result {
            case let .success(verificationId):
                self?.router?.showOTPController(verificationId: verificationId, firebaseManager: manager, number: number, animated: true)
            case .failure(let error):
                self?.view.setError(error: error)
            }
        }
    }
    
    func showError(error: Error) {
        view.setError(error: error)
    }
}
