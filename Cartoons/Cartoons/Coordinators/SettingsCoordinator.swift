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
    let storageService = StorageDataService()
    let authorizationService = AuthorizationService()
    
    weak var transitionDelegate: TransitionDelegate?
    var parent: UINavigationController?
    
    init(parent: UINavigationController) {
        self.parent = parent
    }
    
    func start() {
        let settingsController = SettingsAssembly.makeSettingsController(storageService: storageService,
                                                                         authorizationService: authorizationService)
        settingsController.transitionDelegate = self
        parent?.pushViewController(settingsController, animated: false)
    }
}

extension SettingsCoordinator: SettingsTransitionDelegate {
    func transit() {
        transitionDelegate?.transit()
    }
}
