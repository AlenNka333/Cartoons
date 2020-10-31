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
    
    weak var transitionDelegate: TransitionDelegate?
    var parent: Coordinator?
    var rootController: UINavigationController?
    
    init(rootController: UINavigationController, serviceLocator: Locator) {
        self.rootController = rootController
        self.serviceLocator = serviceLocator
    }
    
    func start() {
        let settingsController = SettingsAssembly.makeSettingsController(serviceLocator: serviceLocator)
        settingsController.transitionDelegate = self
        rootController?.pushViewController(settingsController, animated: false)
    }
    
    deinit {
        print("Settings Fail")
    }
}

extension SettingsCoordinator: SettingsTransitionDelegate {
    func transit() {
        transitionDelegate?.transit()
    }
}
