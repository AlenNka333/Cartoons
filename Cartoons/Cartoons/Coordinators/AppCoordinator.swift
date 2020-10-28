//
//  RootCoordinator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/5/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    let authorizationService = AuthorizationService()
    let userService = UserDataService()
    
    var root: UIViewController
    var parent: UINavigationController?
    fileprivate var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
        self.root = UINavigationController()
        window?.rootViewController = root
        window?.makeKeyAndVisible()
    }
    
    func start() {
        AppData.shouldShowOnBoarding
            ? showOnboarding()
            : authorizationService.shouldAuthorize ? showAuthorizationScreen() : showMainScreen()
    }
}

extension AppCoordinator {
    func showOnboarding() {
        guard let window = window else {
            return
        }
        let coordinator = OnboardingAssembly.makeOnboardingCoordinator()
        coordinator.successSessionClosure = { [weak self] in
            AppData.shouldShowOnBoarding = false
            self?.showAuthorizationScreen()
        }
        coordinator.start()
        window.rootViewController = coordinator.rootController
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    func showAuthorizationScreen() {
        guard let window = window else {
            return
        }
        let coordinator = AuthorizationAssembly.makeAuthorizationCoordinator()
        coordinator.successSessionClosure = { [weak self] in
            self?.showMainScreen()
        }
        coordinator.start()
        window.rootViewController = coordinator.rootController
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    func showMainScreen() {
        guard let window = window else {
            return
        }
        let coordinator = MainScreenAssembly.makeMainScreenCoordinator()
        coordinator.successSessionClosure = { [weak self] in
            self?.showAuthorizationScreen()
        }
        coordinator.start()
        window.rootViewController = coordinator.rootController
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
