//
//  CartoonsAssembly.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class CartoonsAssembly: Assembly {
    static func makeCartoonsController(serviceLocator: Locator,
                                       completion: @escaping((URL) -> Void)) -> UIViewController {
        let view = CartoonsViewController()
        let presenter = CartoonsPresenter(view: view, serviceLocator: serviceLocator)
        view.presenter = presenter
        presenter.openPlayerClosure = completion
        let navigation = BaseNavigationController(rootViewController: view)
        navigation.tabBarItem = UITabBarItem(title: R.string.localizable.cartoons_screen(), image: R.image.clapperboard(), tag: 0)
        return navigation
    }
}
