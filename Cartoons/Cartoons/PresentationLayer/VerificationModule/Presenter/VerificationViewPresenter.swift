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
    let authorizationService: AuthorizationServiceProtocol
    let verificationId: String
    let number: String
    
    var registrationSucceedClosure: () -> Void = {}
    
    init(view: VerificationViewProtocol, authorizationService: AuthorizationServiceProtocol, verificationId: String, number: String) {
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
            switch result {
            case .success:
                self?.registrationSucceedClosure()
            case let .failure(error):
                self?.view.showError(error: error)
            }
        }
    }
}
