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
        setupUI()
    }
    
    func setupUI() {
        tabBar.unselectedItemTintColor = .white
        tabBar.tintColor = R.color.wisteria()
        tabBar.backgroundColor = R.color.navigation_bar_color()?.withAlphaComponent(0.7)
        tabBar.backgroundImage = UIImage()
    }
}
