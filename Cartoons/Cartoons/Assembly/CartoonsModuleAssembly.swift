//
//  CartoonsAssembly.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class CartoonsModuleAssembly: Assembly {
    static func makeCartoonsCoordinator(rootController: UINavigationController,
                                        serviceLocator: Locator,
                                        serviceProviderFacade: ServiceProviderFacade) -> CartoonsCoordinator {
        CartoonsCoordinator(rootController: rootController,
                            serviceLocator: serviceLocator,
                            serviceProviderFacade: serviceProviderFacade)
    }
    
    static func makeCartoonsController(serviceLocator: Locator,
                                       serviceProviderFacade: ServiceProviderFacade) -> CartoonsViewController {
        let view = CartoonsViewController()
        view.hidesBottomBarWhenPushed = true
        let presenter = CartoonsPresenter(view: view,
                                          serviceLocator: serviceLocator,
                                          serviceProviderFacade: serviceProviderFacade)
        view.presenter = presenter
        return view
    }
}
