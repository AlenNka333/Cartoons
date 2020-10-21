//
//  MainScreenAssembly.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

enum Action {
    case openPlayer
    case successSession
}

class MainScreenAssembly: Assembly {
    static func makeMainScreenCoordinator(number: String) -> MainScreenCoordinator {
        return MainScreenCoordinator(number: number)
    }
    
    static func makeTabBarController(number: String,
                                     storageService: StorageDataService,
                                     authorizationService: AuthorizationService,
                                     completion: @escaping((Action, URL?) -> Void)) -> TabBarViewController {
        var controllers = [UIViewController]()
        let cartoons = CartoonsAssembly.makeCartoonsController(storageService: storageService) { url in
            completion(Action.openPlayer, url)
        }
        controllers.append(cartoons)
        controllers.append(FavouritesAssembly.makeFavouritesController())
        let settings = SettingsAssembly.makeSettingsController(number: number, storageService: storageService, authorizationService: authorizationService) {
            completion(Action.successSession, nil)
        }
        controllers.append(settings)
        let view = TabBarViewController(controllers: controllers)
        return view
    }
}
