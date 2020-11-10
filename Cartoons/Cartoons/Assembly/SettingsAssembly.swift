//
//  SettingsAssembly.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class SettingsAssembly: Assembly {
    static func makeSettingsCoordinator(rootController: UINavigationController,
                                        serviceLocator: Locator,
                                        serviceProvider: ServiceProviderFacade) -> SettingsCoordinator {
        SettingsCoordinator(rootController: rootController,
                            serviceLocator: serviceLocator,
                            serviceProvider: serviceProvider)
    }
    
    static func makeSettingsController(serviceLocator: Locator,
                                       serviceProvider: ServiceProviderFacade) -> SettingsViewController {
        let view = SettingsViewController()
        let presenter = SettingsPresenter(view: view,
                                          serviceLocator: serviceLocator,
                                          serviceProvider: serviceProvider)
        view.presenter = presenter
        return view
    }
}
