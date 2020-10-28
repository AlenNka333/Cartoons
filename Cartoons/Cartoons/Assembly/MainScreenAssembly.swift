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
    static func makeMainScreenCoordinator(locator: Locator) -> MainScreenCoordinator {
        return MainScreenCoordinator(locator: locator)
    }
    
    static func makeTabBarController(locator: Locator,
                                     completion: @escaping((Action, URL?) -> Void)) -> TabBarViewController {
        var controllers = [UIViewController]()
        let cartoons = CartoonsAssembly.makeCartoonsController(locator: locator) { url in
            completion(Action.openPlayer, url)
        }
        controllers.append(cartoons)
        controllers.append(FavouritesAssembly.makeFavouritesController())
        let settings = SettingsAssembly.makeSettingsController(locator: locator) {
            completion(Action.successSession, nil)
        }
        controllers.append(settings)
        let view = TabBarViewController(controllers: controllers)
        return view
    }
}
