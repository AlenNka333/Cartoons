//
//  AppNavigationRouter.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/4/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//
import FirebaseAuth
import Foundation
import UIKit

class Router: RouterProtocol {
    internal var assemblyBuilder: AssemblyBuilderProtocol?
    internal var navigationController: UINavigationController?
    internal var onBoarding: UIPageViewController?
    internal var tabBarController: UITabBarController?
    
    static var appState: ApplicationState?
    
    init(window: UIWindow) {
        navigationController = UINavigationController()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        assemblyBuilder = ModuleBuilder()
    }
    
    func changeRootViewController(with rootViewController: UIViewController) {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
    }
    
    func showOnBoarding() {
        onBoarding = assemblyBuilder?.createOnBoarding(router: self)
        guard let onBoard = onBoarding else {
            return
        }
        changeRootViewController(with: onBoard)
    }
    
    func showTabBarController() {
        tabBarController = assemblyBuilder?.createTabBarController(router: self)
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
    
    func showOTPController(animated: Bool, verificationId: String) {
        guard let mainViewController = assemblyBuilder?.createVerification(router: self, verificationId: verificationId) else {
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
