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
        onBoarding = assemblyBuilder?.createOnBoarding(router: self, firebaseManager: firebaseManager) as? UIPageViewController
        guard let onBoard = onBoarding else {
            return
        }
        changeRootViewController(with: onBoard)
    }
    
    func showTabBarController(firebaseManager: FirebaseManager, number: String) {
        tabBarController = assemblyBuilder?.createTabBarController(router: self, manager: firebaseManager, number: number) as? UITabBarController
        guard let tabBar = tabBarController else {
            return
        }
        changeRootViewController(with: tabBar)
    }

    func showAuthorizationController(firebaseManager: FirebaseManager) {
        guard let mainViewController = assemblyBuilder?.createAuthorization(router: self, firebaseManager: firebaseManager) else {
                return
            }
        navigationController?.viewControllers = [mainViewController]
        guard let navigation = navigationController else {
            return
        }
       changeRootViewController(with: navigation)
    }
    
    func showOTPController(verificationId: String, firebaseManager: FirebaseManager, number: String, animated: Bool) {
        guard let mainViewController = assemblyBuilder?.createVerification( router: self,
                                                                            firebaseManager: firebaseManager,
                                                                            verificationId: verificationId,
                                                                            number: number) else {
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
