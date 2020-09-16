//
//  VerificationVIewPresenter.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/5/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

class VerificationPresenter: VerificationViewPresenterProtocol {
    let view: VerificationViewProtocol
    let router: RouterProtocol?
    let verificationId: String
    let firebaseManager = FirebaseManager()
    
    init(view: VerificationViewProtocol, router: RouterProtocol, verificationId: String, number: String) {
        self.view = view
        self.router = router
        self.verificationId = verificationId
        view.setLabelText(number: number)
    }
    func showError(error: Error) {
        view.setError(error: error)
    }
    func verifyUser(verificationCode: String) {
        firebaseManager.authorizeUser(verificationId: verificationId, verifyCode: verificationCode) { [weak self] result in
            switch result {
            case .success(_):
                self?.router?.showTabBarController()
            case let .failure(error):
                self?.view.setError(error: error)
            }
        }
    }
}
