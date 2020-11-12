//
//  SettingsCoordinator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/27/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

class SettingsCoordinator: Coordinator {
    let serviceLocator: Locator
    let serviceProvider: ServiceProviderFacade
    
    weak var transitionDelegate: TransitionDelegate?
    var parent: Coordinator?
    var rootController: UINavigationController?
    
    init(rootController: UINavigationController, serviceLocator: Locator, serviceProvider: ServiceProviderFacade) {
        self.rootController = rootController
        self.serviceLocator = serviceLocator
        self.serviceProvider = serviceProvider
    }
    
    func start() {
        let settingsController = SettingsAssembly.makeSettingsController(serviceLocator: serviceLocator, serviceProvider: serviceProvider)
        //settingsController.transitionDelegate = self
        rootController?.pushViewController(settingsController, animated: false)
    }
}

extension SettingsCoordinator: SettingsTransitionDelegate {
    func transit() {
        transitionDelegate?.transit()
    }
}
