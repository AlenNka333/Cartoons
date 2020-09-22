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
    
    init(view: SettingsViewProtocol) {
        self.view = view
    }
    
    func signOut() {
        firebaseManager.signOutUser { [weak self] result in
            switch result{
            case .success(_):
                self?.view.setSuccess(success: "Signed out")
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
