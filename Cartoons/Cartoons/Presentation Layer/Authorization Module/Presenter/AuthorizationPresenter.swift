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
    let serviceLocator: Locator
    
    init(view: AuthorizationViewProtocol, serviceLocator: Locator) {
        self.view = view
        self.serviceLocator = serviceLocator
    }
    
    func sendRequest(with phoneNumber: String) {
        guard let service: AuthorizationService = serviceLocator.resolve(AuthorizationService.self) else {
            return
        }
        
        view.showActivityIndicator()
        service.verifyPhoneNumber(phoneNumber: phoneNumber) { [weak self] result in
            self?.view.stopActivityIndicator()
            switch result {
            case let .success(verificationId):
                self?.view.transit(verificationId, phoneNumber)
            case .failure(let error):
                self?.view.showError(error: error)
            }
        }
    }
    
    func showError(error: Error) {
        view.showError(error: error)
    }
}
