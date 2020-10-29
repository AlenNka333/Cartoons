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
    let serviceLocator: Locator
    
    var successSessionClosure: (() -> Void)?
    
    init(view: SettingsViewProtocol, locator: Locator) {
        self.view = view
        self.serviceLocator = locator
        guard let service: AuthorizationService = serviceLocator.resolve(AuthorizationService.self) else {
            return
        }
        view.showPhoneLabel(number: service.phoneNumber.unwrapped)
    }
    
    func showProfileImage() {
        guard let service: StorageDataService = serviceLocator.resolve(StorageDataService.self) else {
            return
        }
        service.loadImage(folder: "profile_Images") { [weak self] result in
            switch result {
            case .success(let path):
                self?.view.showProfileImage(path: path)
            case .failure:
                self?.view.showDefaultImage()
            }
        }
    }
    func saveProfileImage(imageData: Data) {
        guard let service: StorageDataService = serviceLocator.resolve(StorageDataService.self) else {
            return
        }
        service.saveImage(imageData: imageData) { [weak self] result in
            switch result {
            case .success:
                break
            case .failure(let error):
                self?.view.showError(error: error)
            }
        }
    }
    func agreeButtonTapped() {
        guard let service: AuthorizationService = serviceLocator.resolve(AuthorizationService.self) else {
            return
        }
        service.signOut { [weak self] result in
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
