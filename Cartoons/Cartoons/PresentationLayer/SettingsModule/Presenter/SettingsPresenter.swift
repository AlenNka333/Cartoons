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
    let firebaseManager: FirebaseManager
    let router: RouterProtocol
    
    init(view: SettingsViewProtocol, router: RouterProtocol, manager: FirebaseManager, number: String) {
        self.view = view
        self.router = router
        self.firebaseManager = manager
        view.setPhoneLabel(number: number)
    }
    
    func showPermissionsAlert(error: Error){
        view.setPermissionAlert(message: error.localizedDescription)
    }
    
    func signOut() {
        view.setSignOutAlert(message: R.string.localizable.question_to_sign_out())
    }
    
    func showSuccess(success: String) {
        view.setSuccess(success: success)
    }
    
    func showError(error: Error) {
        view.setError(error: error)
    }
    
    func editProfileImage() {
        view.editProfileImage()
    }
    
    func agreeButtonTapped() {
        firebaseManager.signOutUser { [weak self] result in
            guard let manager = self?.firebaseManager else {
                return
            }
            switch result {
            case .success:
                self?.router.showAuthorizationController(firebaseManager: manager)
            case .failure(let error):
                self?.view.setError(error: error)
            }
        }
    }
}
