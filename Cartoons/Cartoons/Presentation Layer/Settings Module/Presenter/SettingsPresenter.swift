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
    let serviceProvider: ServiceProviderFacade
    
    init(view: SettingsViewProtocol, serviceLocator: Locator, serviceProvider: ServiceProviderFacade) {
        self.view = view
        self.serviceLocator = serviceLocator
        self.serviceProvider = serviceProvider
        serviceProvider.settingsDelegate = self
        guard let service: AuthorizationService = serviceLocator.resolve(AuthorizationService.self) else {
            return
        }
        view.showPhoneLabel(number: service.phoneNumber.unwrapped)
    }
    
    func showPhoneNumber() {
        guard let service: AuthorizationService = serviceLocator.resolve(AuthorizationService.self) else {
            return
        }
        view.showPhoneLabel(number: service.phoneNumber.unwrapped)
    }
    
    func showProfileImage() {
        guard let service: StorageDataService = serviceLocator.resolve(StorageDataService.self) else {
            return
        }
        service.loadImage(folder: "profile_images") { [weak self] result in
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
                self?.view.transit()
            case .failure(let error):
                self?.view.showError(error: error)
            }
        }
    }
    func checkCache() -> Bool {
        guard let service: FilesManager = serviceLocator.resolve(FilesManager.self) else {
            return true
        }
        return service.checkCache()
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
    func askPermission() {
        view.showClearCachePermissionAlert(message: R.string.localizable.question_to_clear_cache())
    }
    func clearCache() {
        serviceProvider.clearCache()
    }
}

extension SettingsPresenter: SettingsServiceProviderDelegate {
    func cacheUpdated(_ flag: Bool) {
        view.cacheUpdated(flag)
    }
}
