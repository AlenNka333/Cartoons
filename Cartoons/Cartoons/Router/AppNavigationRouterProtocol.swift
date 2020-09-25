//
//  AppNavigationRouterProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/7/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

protocol RouterMain {
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
    var navigationController: BaseNavigationController? { get set }
    var onBoarding: UIPageViewController? { get set }
    var tabBarController: UITabBarController? { get set }
}

protocol RouterProtocol: RouterMain {
    func start()
    func changeRootViewController(with rootViewController: UIViewController)
    func showOnBoarding(firebaseManager: FirebaseManager)
    func showAuthorizationController(firebaseManager: FirebaseManager)
    func showOTPController(verificationId: String, firebaseManager: FirebaseManager, number: String, animated: Bool)
    func showTabBarController(firebaseManager: FirebaseManager, number: String)
    func popToRoot(animated: Bool)
}
