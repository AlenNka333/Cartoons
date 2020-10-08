//
//  MainScreenAssembly.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class MainScreenAssembly: Assembly {
    static func makeMainScreenCoordinator(number: String) -> MainScreenCoordinator {
        return MainScreenCoordinator(number: number)
    }
    
    static func makeTabBarController() -> TabBarViewController {
        let view = TabBarViewController()
        return view
    }
}
