//
//  FavouritesBuilder.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class FavouritesAssembly: Assembly {
    static func makeFavouritesCoordinator(rootController: UINavigationController) -> FavouritesCoordinator {
        FavouritesCoordinator(rootController: rootController)
    }
    
    static func makeFavouritesController() -> FavouritesViewController {
        let view = FavouritesViewController()
        let presenter = FavouritesPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
