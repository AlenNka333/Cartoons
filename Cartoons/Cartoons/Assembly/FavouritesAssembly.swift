//
//  FavouritesBuilder.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class FavouritesAssembly: Assembly {
    static func makeFavouritesCoordinator(rootController: UINavigationController,
                                          serviceProviderFacade: ServiceProviderFacade) -> FavouritesCoordinator {
        FavouritesCoordinator(rootController: rootController, serviceProviderFacade: serviceProviderFacade)
    }
    
    static func makeFavouritesController(serviceProviderFacade: ServiceProviderFacade) -> FavouritesViewController {
        let view = FavouritesViewController()
        let presenter = FavouritesPresenter(view: view, serviceProviderFacade: serviceProviderFacade)
        view.presenter = presenter
        return view
    }
}
