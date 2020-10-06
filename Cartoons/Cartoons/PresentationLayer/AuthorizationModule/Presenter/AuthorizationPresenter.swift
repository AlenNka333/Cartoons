//
//  AuthorizationPresenter.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/4/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

class AuthorizationPresenter: AuthorizationViewPresenterProtocol {
    let view: ViewProtocol
    let coordinator: CoordinatorProtocol
    let firebaseManager: FirebaseManager
    
    init(view: ViewProtocol, coordinator: CoordinatorProtocol, firebaseManager: FirebaseManager) {
        self.view = view
        self.coordinator = coordinator
        self.firebaseManager = firebaseManager
    }
    
    func sendPhoneNumberAction(number: String) {
        view.showActivityIndicator()
        firebaseManager.sendPhoneNumber(number: number) { [weak self] result in
            self?.view.stopActivityIndicator()
            guard let manager = self?.firebaseManager else {
                return
            }
            switch result {
            case let .success(verificationId):
                self?.coordinator.showOTPController(verificationId: verificationId, firebaseManager: manager, number: number, animated: true)
            case .failure(let error):
                self?.view.showError(error: error)
            }
        }
    }
    
    func showError(error: Error) {
        view.showError(error: error)
    }
}
