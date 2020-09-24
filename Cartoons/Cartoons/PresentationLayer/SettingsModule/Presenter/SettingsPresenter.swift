//
//  FavouritesPresenter.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/21/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

class SettingsPresenter: SettingsViewPresenterProtocol {
    let view: SettingsViewProtocol
    let firebaseManager = FirebaseManager()
    let router: RouterProtocol
    
    init(view: SettingsViewProtocol, router: RouterProtocol, number: String) {
        self.view = view
        self.router = router
        CustomAlertView.instance.delegate = self
        view.setPhoneLabel(number: number)
    }
    
    func signOut() {
        view.setQuestion(question: "Are you sure to sign out?")
    }
    
    func showSuccess(success: String) {
        view.setSuccess(success: success)
    }
    
    func showError(error: Error) {
        view.setError(error: error)
    }
}

extension SettingsPresenter: CustomAlertViewDelegate {
    func agreeButtonTapped() {
        firebaseManager.signOutUser { [weak self] result in
            switch result {
            case .success(_):
                self?.router.showAuthorizationController()
            case .failure(let error):
                self?.view.setError(error: error)
            }
        }
    }
}
