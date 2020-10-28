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
    
    var parent: UINavigationController?
    var successSessionClosure: (() -> Void)?
    
    init(parent: UINavigationController) {
        self.parent = parent
    }
    
    func start() {
        let settingsController = SettingsAssembly.makeSettingsController(storageService: storageService,
                                                                         authorizationService: authorizationService) { [weak self] in
            guard let closure = self?.successSessionClosure else {
                return
            }
            closure()
        }
        parent?.pushViewController(settingsController, animated: false)
    }
}
