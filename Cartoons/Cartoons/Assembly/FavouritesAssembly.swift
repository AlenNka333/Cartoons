//
//  FavouritesBuilder.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class FavouritesAssembly: Assembly {
    static func makeFavouritesCoordinator(rootController: UINavigationController, serviceLocator: Locator) -> FavouritesCoordinator {
        FavouritesCoordinator(rootController: rootController, serviceLocator: serviceLocator)
    }
    
    static func makeFavouritesController(serviceLocator: Locator) -> FavouritesViewController {
        let view = FavouritesViewController()
        let presenter = FavouritesPresenter(view: view, serviceLocator: serviceLocator)
        view.presenter = presenter
        return view
    }
}
