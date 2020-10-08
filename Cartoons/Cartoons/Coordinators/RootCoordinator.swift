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
    var root: UIViewController
    let firebaseManager = FirebaseManager()
    fileprivate var window: UIWindow?
    
    init(window: UIWindow?) {
        self.root = UINavigationController()
        self.window = window
        self.window?.rootViewController = root
    }
    
    func start() {
        if AppData.shouldShowOnBoarding {
            showOnboarding()
        } else {
            if firebaseManager.shouldAuthorize {
                showAuthorizationScreen()
            } else {
                showMainScreen()
            }
        }
        self.window?.makeKeyAndVisible()
    }
    
    func showOnboarding() {
        guard let window = window else {
            return
        }
        let onboardingCoordinator = OnboardingAssembly.makeOnboardingCoordinator()
        onboardingCoordinator.successOnboardingSession = {
            self.showAuthorizationScreen()
        }
        onboardingCoordinator.start()
        window.rootViewController = onboardingCoordinator.root
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
    
    func showAuthorizationScreen() {
        guard let window = window else {
            return
        }
        let authCoordinator = AuthorizationAssembly.makeAuthorizationCoordinator()
        authCoordinator.registrationSucceededClosure = { number in
            self.showMainScreen()
        }
        authCoordinator.start()
        window.rootViewController = authCoordinator.root
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
    
    func showMainScreen() {
        guard let window = window else {
            return
        }
        let number = firebaseManager.getUserInfo()
        let mainCoordinator = MainScreenAssembly.makeMainScreenCoordinator(number: number.unwrapped)
        mainCoordinator.successUserSession = {
            self.showAuthorizationScreen()
        }
        mainCoordinator.start()
        window.rootViewController = mainCoordinator.root
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}
