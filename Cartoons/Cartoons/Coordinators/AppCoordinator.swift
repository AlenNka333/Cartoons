//
//  RootCoordinator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/5/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class AppCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController?
    var presenter: PresenterProtocol?
    var childCoordinators: [CoordinatorProtocol]
    fileprivate var window: UIWindow?
    
    init(window: UIWindow?) {
        navigationController = BaseNavigationController()
        self.window = window
        self.window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        navigationController?.isNavigationBarHidden = true
    }
    
    func start() {
        let firebaseManager = FirebaseManager()
        if AppData.shouldShowOnBoarding {
            showOnBoarding(firebaseManager: firebaseManager)
        } else {
            switch firebaseManager.shouldAuthorize {
            case true:
                showAuthorizationController(firebaseManager: firebaseManager)
            case false:
                let number = firebaseManager.getUserInfo()
                showTabBarController(firebaseManager: firebaseManager, number: number ?? "")
            }
        }
    }
}
