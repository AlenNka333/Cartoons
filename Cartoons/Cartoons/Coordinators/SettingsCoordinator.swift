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
    var parent: Coordinator?
    var rootController: UINavigationController?
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
    }
    
    func start() {
        let settingsController = SettingsAssembly.makeSettingsController(storageService: storageService,
                                                                         authorizationService: authorizationService)
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
