//
//  TabBarController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/10/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    private var builder = ModuleBuilder()
    private var tabBarList = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        initTabBarList()
        setViewControllers(tabBarList, animated: false)
        setupUi()
    }
    
    func initTabBarList() {
        let firstViewController = builder.createCartoons()
        let navigationF = BaseNavigationController(rootViewController: firstViewController)
        navigationF.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        tabBarList.append(navigationF)
        
        let secondViewController = builder.createFavourites()
        let navigationS = BaseNavigationController(rootViewController: secondViewController)
        navigationS.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        tabBarList.append(navigationS)
        
        let thirdViewController = builder.createSettings()
        let navigationT = BaseNavigationController(rootViewController: thirdViewController)
        navigationT.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        tabBarList.append(navigationT)
    }
    
    func setupUi() {
        tabBar.barTintColor = R.color.tab_bar_color()?.withAlphaComponent(0.3)
    }
}
