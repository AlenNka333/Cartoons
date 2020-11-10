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
    private let serviceLocator: Locator
    
    var child: Coordinator?
    var root: UIViewController
    var parent: Coordinator?
    fileprivate var window: UIWindow?
    
    init(window: UIWindow?, serviceLocator: Locator) {
        self.window = window
        self.serviceLocator = serviceLocator
        self.root = UINavigationController()
        window?.rootViewController = root
        window?.makeKeyAndVisible()
    }
    
    func start() {
        guard let service: AuthorizationService = serviceLocator.resolve(AuthorizationService.self) else {
            return
        }
        AppData.shouldShowOnBoarding
            ? showOnboarding()
            : service.shouldAuthorize ? showAuthorizationScreen() : showMainScreen()
    }
    
    func setChild(_ coordinator: Coordinator?) {
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

extension AppCoordinator {
    func showOnboarding() {
        guard let window = window else {
            return
        }
        removeChild()
        let coordinator = OnboardingAssembly.makeOnboardingCoordinator()
        coordinator.successSessionClosure = { [weak self] in
            AppData.shouldShowOnBoarding = false
            self?.showAuthorizationScreen()
        }
        setChild(coordinator)
        coordinator.start()
        window.rootViewController = coordinator.rootController
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    func showAuthorizationScreen() {
        guard let window = window else {
            return
        }
        removeChild()
        let coordinator = AuthorizationAssembly.makeAuthorizationCoordinator(serviceLocator: serviceLocator)
        coordinator.successSessionClosure = { [weak self] in
            self?.showMainScreen()
        }
        setChild(coordinator)
        coordinator.start()
        window.rootViewController = coordinator.rootController
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    func showMainScreen() {
        guard let window = window else {
            return
        }
        removeChild()
        let coordinator = MainScreenAssembly.makeMainScreenCoordinator(serviceLocator: serviceLocator)
        coordinator.successSessionClosure = { [weak self] in
            self?.showAuthorizationScreen()
        }
        setChild(coordinator)
        coordinator.start()
        window.rootViewController = coordinator.rootController
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
