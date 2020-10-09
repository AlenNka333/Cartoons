//
//  MainScreenCoordinator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class MainScreenCoordinator: CoordinatorProtocol {
    var root: UIViewController
    let number: String
    let window: UIWindow?
    let storageService = StorageDataService()
    let authorizationService = AuthorizationService()
    
    var successUserSession: () -> Void = {}
    
    init(number: String) {
        self.number = number
        self.window = UIApplication.shared.windows.first { $0.isKeyWindow }
        self.root = UIViewController()
    }
    
    deinit {
        print("Main deinit")
    }
    
    func start() {
        root = MainScreenAssembly.makeTabBarController(number: number,
                                                       storageService: storageService,
                                                       authorizationService: authorizationService,
                                                       completion: {
            self.successUserSession()
        })
        guard let window = window else {
            return
        }
        window.rootViewController = root
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
