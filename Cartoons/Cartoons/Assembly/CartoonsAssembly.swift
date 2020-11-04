//
//  CartoonsAssembly.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class CartoonsAssembly: Assembly {
    static func makeCartoonsCoordinator(rootController: UINavigationController, serviceLocator: Locator, dataFacade: DataFacade) -> CartoonsCoordinator {
        CartoonsCoordinator(rootController: rootController, serviceLocator: serviceLocator, dataFacade: dataFacade)
    }
    
    static func makeCartoonsController(serviceLocator: Locator, dataFacade: DataFacade) -> CartoonsViewController {
        let view = CartoonsViewController()
        let presenter = CartoonsPresenter(view: view, serviceLocator: serviceLocator, dataFacade: dataFacade)
        view.presenter = presenter
        return view
    }
}
