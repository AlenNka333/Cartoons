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
    
    var openAuthorizationClosure: () -> Void = {}
    
    init(view: SettingsViewProtocol, firebaseManager: FirebaseManager, number: String) {
        self.view = view
        self.firebaseManager = firebaseManager
        view.showPhoneLabel(number: number)
    }
    
    func showProfileImage() {
        firebaseManager.loadProfileImage { [weak self] result in
            switch result {
            case .failure:
                self?.view.showDefaultImage()
            case .success(let path):
                self?.view.showProfileImage(path: path)
            }
        }
    }
    func saveProfileImage(imageData: Data) {
        firebaseManager.storeUserProfileImage(imageData: imageData) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.view.showError(error: error)
            case .success:
                break
            }
        }
    }
    func agreeButtonTapped() {
        firebaseManager.signOutUser { [weak self] result in
            switch result {
            case .success:
                self?.openAuthorizationClosure()
            case .failure(let error):
                self?.view.showError(error: error)
            }
        }
    }
    func signOut() {
        view.showSignOutAlert(message: R.string.localizable.question_to_sign_out())
    }
    func editProfileImage() {
        view.editProfileImage()
    }
    func showPermissionsAlert(error: Error) {
        view.showPermissionAlert(message: error.localizedDescription)
    }
    func showSuccess(success: String) {
        view.showSuccess(success: success)
    }
    func showError(error: Error) {
        view.showError(error: error)
    }
}
