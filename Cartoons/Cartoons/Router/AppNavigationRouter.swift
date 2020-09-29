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
    var navigationController: BaseNavigationController?
    var onBoarding: UIPageViewController?
    var tabBarController: UITabBarController?
    let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
        window?.makeKeyAndVisible()
        navigationController = BaseNavigationController()
        navigationController?.isNavigationBarHidden = true
        assemblyBuilder = ModuleBuilder()
    }
    
    func start() {
        let firebaseManager = FirebaseManager()
        //showTabBarController(firebaseManager: firebaseManager, number: "+375298939122")
        
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
    
    func changeRootViewController(with rootViewController: UIViewController) {
        guard let window = self.window else {
            return
        }
        window.rootViewController = rootViewController
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    func showOnBoarding(firebaseManager: FirebaseManager) {
        onBoarding = assemblyBuilder?.createOnBoarding(router: self, firebaseManager: firebaseManager) as? PageViewController
        guard let onBoarding = onBoarding else {
            return
        }
        changeRootViewController(with: onBoarding)
    }
    
    func showTabBarController(firebaseManager: FirebaseManager, number: String) {
        tabBarController = assemblyBuilder?.createTabBarController(router: self, manager: firebaseManager, number: number) as? TabBarViewController
        guard let tabBar = tabBarController else {
            return
        }
        var controllers = [UIViewController]()
        let cartoons = assemblyBuilder?.createCartoons()
        let favourites = assemblyBuilder?.createFavourites()
        let settings = assemblyBuilder?.createSettings(router: self, manager: firebaseManager, number: number)
        guard let cartoon = cartoons, let favourite = favourites, let setting = settings else {
            return
        }
        controllers.append(cartoon)
        controllers.append(favourite)
        controllers.append(setting)
        tabBarController?.viewControllers = controllers
        changeRootViewController(with: tabBar)
    }

    func showAuthorizationController(firebaseManager: FirebaseManager) {
        let mainViewController = assemblyBuilder?.createAuthorization(router: self, firebaseManager: firebaseManager)
        guard let main = mainViewController, let navigation = navigationController else {
            return
        }
        navigationController?.viewControllers = [main]
        changeRootViewController(with: navigation)
    }
    
    func showOTPController(verificationId: String, firebaseManager: FirebaseManager, number: String, animated: Bool) {
        let mainViewController = assemblyBuilder?.createVerification( router: self,
                                                                      firebaseManager: firebaseManager,
                                                                      verificationId: verificationId,
                                                                      number: number)
        guard let main = mainViewController else {
            return
        }
        navigationController?.pushViewController(main, animated: animated)
    }
    
    func popToRoot(animated: Bool) {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: animated)
        }
    }
}
