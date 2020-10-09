//
//  VerificationVIewPresenter.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/5/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

class VerificationPresenter: VerificationViewPresenterProtocol {
    var view: VerificationViewProtocol
    let authorizationService: AuthorizationService
    let verificationId: String
    let number: String
    
    var registrationSucceedClosure: (String) -> Void = { _ in }
    
    init(view: VerificationViewProtocol, authorizationService: AuthorizationService, verificationId: String, number: String) {
        self.view = view
        self.authorizationService = authorizationService
        self.verificationId = verificationId
        self.number = number
        view.setLabelText(number: number)
    }
    func showError(error: Error) {
        view.showError(error: error)
    }
    func resendVerificationCode() {
        authorizationService.verifyUser(number: number) { [weak self] result in
            switch result {
            case .success:
                break
            case .failure(let error):
                self?.view.showError(error: error)
            }
        }
    }
    func verifyUser(verificationCode: String) {
        authorizationService.signIn(verificationId: verificationId, verifyCode: verificationCode) { [weak self] result in
            guard let number = self?.number else {
                return
            }
            switch result {
            case .success:
                self?.registrationSucceedClosure(number)
            case let .failure(error):
                self?.view.showError(error: error)
            }
        }
    }
}
