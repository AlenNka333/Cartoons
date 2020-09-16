//
//  AppNavigationRouter.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/4/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//
import Foundation
import UIKit

class Router: RouterProtocol {
    var assemblyBuilder: AssemblyBuilderProtocol?
    var navigationController: UINavigationController?
    var onBoarding: UIPageViewController?
    var tabBarController: UITabBarController?
    let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
        window?.makeKeyAndVisible()
        navigationController = UINavigationController()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        assemblyBuilder = ModuleBuilder()
    }
    
    func start() {
        if AppData.shouldShowOnBoarding {
            showOnBoarding()
        } else {
            let firebaseManager = FirebaseManager()
            switch firebaseManager.shouldAuthorize {
            case true:
                showAuthorizationController()
            case false:
                showTabBarController()
            }
        }
    }
    
    func changeRootViewController(with rootViewController: UIViewController) {
        guard let window = self.window else {
            return
        }
        window.rootViewController = rootViewController
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    func showOnBoarding() {
        onBoarding = assemblyBuilder?.createOnBoarding(router: self) as? UIPageViewController
        guard let onBoard = onBoarding else {
            return
        }
        changeRootViewController(with: onBoard)
    }
    
    func showTabBarController() {
        tabBarController = assemblyBuilder?.createTabBarController(router: self) as? UITabBarController
        guard let tabBar = tabBarController else {
            return
        }
        changeRootViewController(with: tabBar)
    }

    func showAuthorizationController() {
        guard let mainViewController = assemblyBuilder?.createAuthorization(router: self) else {
                return
            }
        navigationController?.viewControllers = [mainViewController]
        guard let navigation = navigationController else {
            return
        }
       changeRootViewController(with: navigation)
    }
    
    func showOTPController(verificationId: String, number: String, animated: Bool) {
        guard let mainViewController = assemblyBuilder?.createVerification(router: self, verificationId: verificationId, number: number) else {
                return
            }
        navigationController?.pushViewController(mainViewController, animated: animated)
    }
    
    func popToRoot(animated: Bool) {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: animated)
        }
    }
}
