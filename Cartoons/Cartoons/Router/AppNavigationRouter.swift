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
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController(isAuthorised: Bool) {
        switch isAuthorised {
        case true:
            guard let mainViewController = assemblyBuilder?.createAuthorization(router: self) else {
                return
            }
            navigationController?.viewControllers = [mainViewController]
        case false:
            guard let mainViewController = assemblyBuilder?.createTabBarController(router: self) else {
                return
            }
            navigationController?.viewControllers = [mainViewController]
        }
    }
    
    func createVerificationController(animated: Bool, verificationId: String) {
        guard let mainViewController = assemblyBuilder?.createVerification(router: self, verificationId: verificationId) else {
                return
            }
        navigationController?.pushViewController(mainViewController, animated: animated)
        }
    func openCartoonsController(animated: Bool) {
        guard let mainViewController = assemblyBuilder?.createCartoons(router: self) else {
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
