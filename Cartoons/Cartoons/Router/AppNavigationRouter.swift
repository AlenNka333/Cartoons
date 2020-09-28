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
        showTabBarController(firebaseManager: firebaseManager, number: "+375298939122")
        
//        if AppData.shouldShowOnBoarding {
//            showOnBoarding(firebaseManager: firebaseManager)
//        } else {
//            switch firebaseManager.shouldAuthorize {
//            case true:
//                showAuthorizationController(firebaseManager: firebaseManager)
//            case false:
//                let number = firebaseManager.getUserInfo()
//                showTabBarController(firebaseManager: firebaseManager, number: number ?? "")
//            }
//        }
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
        changeRootViewController(with: onBoarding.unwrapped)
    }
    
    func showTabBarController(firebaseManager: FirebaseManager, number: String) {
        tabBarController = assemblyBuilder?.createTabBarController(router: self, manager: firebaseManager, number: number) as? TabBarViewController
        var controllers = [UIViewController]()
        let cartoons = assemblyBuilder?.createCartoons()
        let favourites = assemblyBuilder?.createFavourites()
        let setting = assemblyBuilder?.createSettings(router: self, manager: firebaseManager, number: number)
        controllers.append(cartoons.unwrapped)
        controllers.append(favourites.unwrapped)
        controllers.append(setting.unwrapped)
        tabBarController?.viewControllers = controllers
        changeRootViewController(with: tabBarController.unwrapped)
    }

    func showAuthorizationController(firebaseManager: FirebaseManager) {
        let mainViewController = assemblyBuilder?.createAuthorization(router: self, firebaseManager: firebaseManager)
        navigationController?.viewControllers = [mainViewController.unwrapped]
        changeRootViewController(with: navigationController.unwrapped)
    }
    
    func showOTPController(verificationId: String, firebaseManager: FirebaseManager, number: String, animated: Bool) {
        let mainViewController = assemblyBuilder?.createVerification( router: self,
                                                                      firebaseManager: firebaseManager,
                                                                      verificationId: verificationId,
                                                                      number: number)
        navigationController?.pushViewController(mainViewController.unwrapped, animated: animated)
    }
    
    func popToRoot(animated: Bool) {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: animated)
        }
    }
}
