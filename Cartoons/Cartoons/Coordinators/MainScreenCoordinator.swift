//
//  MainScreenCoordinator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class MainScreenCoordinator: CoordinatorProtocol {
    let number: String
    let storageService = StorageDataService()
    let authorizationService = AuthorizationService()
    
    var parent: CoordinatorProtocol?
    var root: UIViewController
    var successUserSession: () -> Void = {}
    
    init(number: String) {
        self.number = number
        self.root = UINavigationController()
    }
    
    func start() {
        root = MainScreenAssembly.makeTabBarController(number: number,
                                                       storageService: storageService,
                                                       authorizationService: authorizationService,
                                                       completion: { [weak self] in
            self?.successUserSession()
        })
    }
}
