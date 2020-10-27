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
    let storageService: StorageDataServiceProtocol
    let authorizationService: AuthorizationServiceProtocol
    
    var successSessionClosure: (() -> Void)?
    
    init(view: SettingsViewProtocol, storageService: StorageDataServiceProtocol, authorizationService: AuthorizationServiceProtocol) {
        self.view = view
        self.storageService = storageService
        self.authorizationService = authorizationService
        view.showPhoneLabel(number: authorizationService.phoneNumber.unwrapped)
    }
    
    func showProfileImage() {
        storageService.loadImage(folder: "profile_Images") { [weak self] result in
            switch result {
            case .success(let path):
                self?.view.showProfileImage(path: path)
            case .failure:
                self?.view.showDefaultImage()
            }
        }
    }
    func saveProfileImage(imageData: Data) {
        storageService.saveImage(imageData: imageData) { [weak self] result in
            switch result {
            case .success:
                break
            case .failure(let error):
                self?.view.showError(error: error)
            }
        }
    }
    func agreeButtonTapped() {
        authorizationService.signOut { [weak self] result in
            switch result {
            case .success:
                guard let closure = self?.successSessionClosure else {
                    return
                }
                closure()
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
