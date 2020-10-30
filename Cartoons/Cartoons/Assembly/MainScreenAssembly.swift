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
    static func makeMainScreenCoordinator(serviceLocator: Locator) -> MainScreenCoordinator {
        return MainScreenCoordinator(serviceLocator: serviceLocator)
    }
    
    static func makeTabBarController(serviceLocator: Locator,
                                     completion: @escaping((Action, URL?) -> Void)) -> TabBarViewController {
        var controllers = [UIViewController]()
        let cartoons = CartoonsAssembly.makeCartoonsController(serviceLocator: serviceLocator) { url in
            completion(Action.openPlayer, url)
        }
        controllers.append(cartoons)
        controllers.append(FavouritesAssembly.makeFavouritesController())
        let settings = SettingsAssembly.makeSettingsController(serviceLocator: serviceLocator) {
            completion(Action.successSession, nil)
        }
        controllers.append(settings)
        let view = TabBarViewController(controllers: controllers)
        return view
    }
}
