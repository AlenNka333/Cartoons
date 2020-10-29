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
    
    var openVerificationClosure: ((String, String) -> Void)?
    
    init(view: AuthorizationViewProtocol, locator: Locator) {
        self.view = view
        self.serviceLocator = locator
    }
    
    func sendPhoneNumberAction(number: String) {
        guard let service: AuthorizationService = serviceLocator.resolve(AuthorizationService.self) else {
            return
        }
        view.showActivityIndicator()
        service.verifyUser(number: number) { [weak self] result in
            self?.view.stopActivityIndicator()
            switch result {
            case let .success(verificationId):
                guard let closure = self?.openVerificationClosure else {
                    return
                }
                closure(verificationId, number)
            case .failure(let error):
                self?.view.showError(error: error)
            }
        }
    }
    
    func showError(error: Error) {
        view.showError(error: error)
    }
}
