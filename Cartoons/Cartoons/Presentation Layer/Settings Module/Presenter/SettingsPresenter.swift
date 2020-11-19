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
        view.showUserPhoneNumber(phoneNumber: service.phoneNumber.unwrapped)
    }
    
    func showUserPhoneNumber() {
        guard let service: AuthorizationService = serviceLocator.resolve(AuthorizationService.self) else {
            return
        }
        view.showUserPhoneNumber(phoneNumber: service.phoneNumber.unwrapped)
    }
    
    func getUserProfileImage() {
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
    
    func saveUserProfileImage(imageData: Data) {
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
    
    func signOut() {
        guard let service: AuthorizationService = serviceLocator.resolve(AuthorizationService.self) else {
            return
        }
        view.showPermissionAlert(message: R.string.localizable.question_to_sign_out()) { result in
            service.signOut { [weak self] result in
                switch result {
                case .success:
                    self?.view.transit()
                case let .failure(error):
                    self?.view.showError(error: error)
                }
            }
        }
    }
    
    func checkCacheIsEmpty() -> Bool {
        guard let service: FilesManager = serviceLocator.resolve(FilesManager.self) else {
            return true
        }
        return service.checkCacheIsEmpty()
    }
    
   func showError(error: Error) {
        view.showError(error: error)
    }
    
    func clearCache() {
        view.showPermissionAlert(message: R.string.localizable.question_to_clear_cache()) { [weak self] result in
            self?.serviceProvider.clearCache()
        }
    }
}

extension SettingsPresenter: SettingsServiceProviderDelegate {
    func cacheUpdated(_ flag: Bool) {
        view.cacheSizeChanged(flag)
    }
}
