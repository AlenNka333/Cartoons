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
    let router: RouterProtocol
    let verificationId: String
    let firebaseManager: FirebaseManager
    let number: String
    
    init(view: VerificationViewProtocol, router: RouterProtocol, manager: FirebaseManager, verificationId: String, number: String) {
        self.view = view
        self.router = router
        self.firebaseManager = manager
        self.verificationId = verificationId
        self.number = number
        view.setLabelText(number: number)
    }
    func showError(error: Error) {
        view.setError(error: error)
    }
    func verifyUser(verificationCode: String) {
        firebaseManager.authorizeUser(verificationId: verificationId, verifyCode: verificationCode) { [weak self] result in
            guard let manager = self?.firebaseManager else {
                return
            }
            guard let number = self?.number else {
                return
            }
            switch result {
            case .success:
                self?.router.showTabBarController(firebaseManager: manager, number: number)
            case let .failure(error):
                self?.view.setError(error: error)
            }
        }
    }
}
