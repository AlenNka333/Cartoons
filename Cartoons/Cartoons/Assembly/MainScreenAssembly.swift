//
//  MainScreenAssembly.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class MainScreenAssembly: Assembly {
    static func makeMainScreenCoordinator(number: String) -> MainScreenCoordinator {
        return MainScreenCoordinator(number: number)
    }
    
    static func makeTabBarController(number: String,
                                     storageService: StorageDataService,
                                     authorizationService: AuthorizationService,
                                     completion: @escaping(() -> Void)) -> TabBarViewController {
        var controllers = [UIViewController]()
        controllers.append(CartoonsAssembly.makeCartoonsController())
        controllers.append(FavouritesAssembly.makeFavouritesController())
        let settings = SettingsAssembly.makeSettingsController(number: number, storageService: storageService, authorizationService: authorizationService) {
            completion()
        }
        controllers.append(settings)
        let view = TabBarViewController(controllers: controllers)
        return view
    }
}
