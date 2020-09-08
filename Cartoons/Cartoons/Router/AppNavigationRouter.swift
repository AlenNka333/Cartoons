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
    
    func initialViewController() {
        guard let mainViewController = assemblyBuilder?.createAuthorization(router: self) else {
                return
            }
        navigationController?.viewControllers = [mainViewController]
        }
    
    func createVerification(animated: Bool) {
        guard let mainViewController = assemblyBuilder?.createVerification(router: self) else {
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
