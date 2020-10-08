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
    let firebaseManager: FirebaseManager
    
    var openVerificationClosure: (String, String) -> Void = { _, _ in }
    
    init(view: AuthorizationViewProtocol, firebaseManager: FirebaseManager) {
        self.view = view
        self.firebaseManager = firebaseManager
    }
    
    func sendPhoneNumberAction(number: String) {
        view.showActivityIndicator()
        firebaseManager.sendPhoneNumber(number: number) { [weak self] result in
            self?.view.stopActivityIndicator()
            switch result {
            case let .success(verificationId):
                self?.openVerificationClosure(verificationId, number)
            case .failure(let error):
                self?.view.showError(error: error)
            }
        }
    }
    
    func showError(error: Error) {
        view.showError(error: error)
    }
}
