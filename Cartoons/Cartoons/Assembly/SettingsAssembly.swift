//
//  SettingsAssembly.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class SettingsAssembly: Assembly {
    static func makeSettingsCoordinator(parent: UINavigationController) -> SettingsCoordinator {
        SettingsCoordinator(parent: parent)
    }
    
    static func makeSettingsController(storageService: StorageDataService,
                                       authorizationService: AuthorizationService,
                                       completion: @escaping(() -> Void)) -> UIViewController {
        let view = SettingsViewController()
        let presenter = SettingsPresenter(view: view, storageService: storageService, authorizationService: authorizationService)
        presenter.successSessionClosure = {
            completion()
        }
        view.presenter = presenter
        return view
    }
}
