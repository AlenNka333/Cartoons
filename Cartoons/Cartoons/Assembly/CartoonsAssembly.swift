//
//  CartoonsAssembly.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class CartoonsAssembly: Assembly {
    static func makeCartoonsController(storageService: StorageDataService,
                                       completion: @escaping((Cartoon) -> Void)) -> UIViewController {
        let view = CartoonsViewController()
        let presenter = CartoonsPresenter(view: view, storageService: storageService)
        view.presenter = presenter
        presenter.openDetailsClosure = completion
        let navigation = BaseNavigationController(rootViewController: view)
        navigation.tabBarItem = UITabBarItem(title: R.string.localizable.cartoons_screen(), image: R.image.clapperboard(), tag: 0)
        return navigation
    }
}
