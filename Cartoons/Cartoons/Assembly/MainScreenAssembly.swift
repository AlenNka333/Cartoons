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
    
    static func makeTabBarController(number: String, firebaseManager: FirebaseManager, completion: @escaping(() -> Void)) -> TabBarViewController {
        var controllers = [UIViewController]()
        controllers.append(CartoonsAssembly.makeCartoonsController())
        controllers.append(FavouritesAssembly.makeFavouritesController())
        let settings = SettingsAssembly.makeSettingsController(number: number, firebaseManager: firebaseManager) {
            completion()
        }
        controllers.append(settings)
        let view = TabBarViewController(controllers: controllers)
        return view
    }
}
