//
//  SettingsAssembly.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class SettingsAssembly: Assembly {
    static func makeSettingsController() -> UIViewController {
        let view = SettingsViewController()
        let navigation = BaseNavigationController(rootViewController: view)
        navigation.tabBarItem = UITabBarItem(title: R.string.localizable.favourites_screen(), image: R.image.clapperboard(), tag: 0)
        return navigation
    }
}
