//
//  TabBarController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/10/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

enum TabState: String {
    case media = "Cartoons"
    case favourites = "Favourites"
    case settings = "Settings"
}

class TabBarViewController: UITabBarController {
    private var tabBarList = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        }
    
    func setupUi() {
        tabBar.unselectedItemTintColor = .white
        tabBar.tintColor = R.color.wisteria()
        tabBar.backgroundColor = R.color.navigation_bar_color()?.withAlphaComponent(0.7)
        tabBar.backgroundImage = UIImage()
    }
}
