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
    
    init(view: SettingsViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func signOut() {
        firebaseManager.signOutUser { [weak self] result in
            switch result {
            case .success(_):
                self?.router.showAuthorizationController()
            case .failure(let error):
                self?.view.setError(error: error)
            }
        }
    }
    
    func showSuccess(success: String) {
        view.setSuccess(success: success)
    }
    
    func showError(error: Error) {
        view.setError(error: error)
    }
}
