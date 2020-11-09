//
//  RootAssembly.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/7/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class RootAssembly: Assembly {
    static func makeRootCoordinator(window: UIWindow?, serviceLocator: Locator) -> AppCoordinator {
        return AppCoordinator(window: window, serviceLocator: serviceLocator)
    }
}
