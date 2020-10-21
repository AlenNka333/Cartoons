//
//  RootCoordinator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/5/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

class RootCoordinator: CoordinatorProtocol {
    let authorizationService = AuthorizationService()
    let userService = UserDataService()
    
    var child: CoordinatorProtocol?
    var root: UIViewController
    var parent: CoordinatorProtocol?
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
    
    func setChild(_ coordinator: CoordinatorProtocol?) {
        if child != nil {
            removeChild()
        }
        coordinator?.parent = self
        child = coordinator
    }
    
    func removeChild() {
        guard let child = child else {
            return
        }
        
        child.removeParent()
        self.child = nil
    }
}

extension RootCoordinator {
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
        setChild(coordinator)
        window.rootViewController = coordinator.root
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
        setChild(coordinator)
        window.rootViewController = coordinator.rootController
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    func showMainScreen() {
        guard let window = window else {
            return
        }
        let number = userService.userPhoneNumber
        let coordinator = MainScreenAssembly.makeMainScreenCoordinator(number: number.unwrapped)
        coordinator.successSessionClosure = { [weak self] in
            self?.showAuthorizationScreen()
        }
        coordinator.start()
        setChild(coordinator)
        window.rootViewController = coordinator.rootController
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
