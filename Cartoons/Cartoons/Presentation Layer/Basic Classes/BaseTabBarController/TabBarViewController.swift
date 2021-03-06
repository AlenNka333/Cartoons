//
//  TabBarController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/10/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    init(controllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        viewControllers = controllers
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
