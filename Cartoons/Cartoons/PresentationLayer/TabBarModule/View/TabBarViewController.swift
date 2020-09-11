//
//  TabBarController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/10/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let firstViewController = CartoonsViewController()
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        let tabBarList = [firstViewController]
        viewControllers = tabBarList
    }
}
