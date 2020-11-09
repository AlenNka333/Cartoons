//
//  SettingsAssembly.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class SettingsAssembly: Assembly {
    static func makeSettingsCoordinator(rootController: UINavigationController, serviceLocator: Locator) -> SettingsCoordinator {
        SettingsCoordinator(rootController: rootController, serviceLocator: serviceLocator)
    }
    
    static func makeSettingsController(serviceLocator: Locator) -> SettingsViewController {
        let view = SettingsViewController()
        let presenter = SettingsPresenter(view: view, serviceLocator: serviceLocator)
        view.presenter = presenter
        return view
    }
}
