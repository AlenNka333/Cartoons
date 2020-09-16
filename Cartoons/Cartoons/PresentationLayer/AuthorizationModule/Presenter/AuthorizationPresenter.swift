//
//  AuthorizationPresenter.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/4/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

class AuthorizationPresenter: AuthorizationViewPresenterProtocol {
    let view: AuthorizationViewProtocol
    let router: RouterProtocol?
    let firebaseManager = FirebaseManager()
    
    required init(view: AuthorizationViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func sendPhoneNumberAction(number: String) {
        view.showActivityIndicatorAction()
        firebaseManager.sendPhoneNumber(number: number) { [weak self] result in
            self?.view.stopActivityIndicatorAction()
            switch result {
            case let .success(verificationId):
                self?.router?.showOTPController(verificationId: verificationId, animated: true)
            case .failure(let error):
                self?.view.setError(error: error)
            }
        }
    }
    
    func showError(error: Error) {
        view.setError(error: error)
    }
}
