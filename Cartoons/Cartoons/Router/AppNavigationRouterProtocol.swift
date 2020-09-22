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
    func showOnBoarding()
    func showAuthorizationController()
    func showOTPController(verificationId: String, number: String, animated: Bool)
    func showTabBarController()
    func popToRoot(animated: Bool)
}
