//
//  FavouritesBuilder.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class FavouritesAssembly: Assembly {
    static func makeFavouritesController(serviceLocator: Locator) -> UIViewController {
        let view = FavouritesViewController()
        let presenter = FavouritesPresenter(view: view, serviceLocator: serviceLocator)
        view.presenter = presenter
        let navigation = BaseNavigationController(rootViewController: view)
        navigation.tabBarItem = UITabBarItem(title: R.string.localizable.favourites_screen(), image: R.image.crown(), tag: 0)
        return navigation
    }
}
