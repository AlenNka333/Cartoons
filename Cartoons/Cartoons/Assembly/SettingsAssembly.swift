//
//  SettingsAssembly.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class SettingsAssembly: Assembly {
    static func makeSettingsCoordinator(rootController: UINavigationController) -> SettingsCoordinator {
        SettingsCoordinator(rootController: rootController)
    }
    
    static func makeSettingsController(storageService: StorageDataService,
                                       authorizationService: AuthorizationService) -> SettingsViewController {
        let view = SettingsViewController()
        let presenter = SettingsPresenter(view: view, storageService: storageService, authorizationService: authorizationService)
        view.presenter = presenter
        return view
    }
}
