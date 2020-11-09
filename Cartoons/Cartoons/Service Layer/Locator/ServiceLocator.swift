//
//  Locator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/28/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol Locator {
    func resolve<T>(_ type: T.Type) -> T?
}

class ServiceLocator: Locator {
    private lazy var authorizationService: AuthorizationService = { AuthorizationService() }()
    private lazy var storageService: StorageDataService = { StorageDataService() }()
    private lazy var userService: UserDataService = { UserDataService() }()
    private lazy var loadingService: LoadingService = { LoadingService() }()
    private lazy var fileManager: FilesManager = { FilesManager() }()
    
    func resolve<T>(_ type: T.Type) -> T? {
        switch type {
        case is AuthorizationService.Type:
            return authorizationService as? T
        case is StorageDataService.Type:
            return storageService as? T
        case is UserDataService.Type:
            return userService as? T
        case is LoadingService.Type:
            return loadingService as? T
        case is FilesManager.Type:
            return fileManager as? T
        default:
            return nil
        }
    }
}
