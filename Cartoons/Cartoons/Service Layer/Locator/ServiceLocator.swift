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
    
    func resolve<T>(_ type: T.Type) -> T? {
        switch type {
        case is AuthorizationService.Type:
            return authorizationService as? T
        case is StorageDataService.Type:
            return storageService as? T
        case is UserDataService.Type:
            return userService as? T
        default:
            return nil
        }
    }
}
