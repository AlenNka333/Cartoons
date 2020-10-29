//
//  CartoonsAssembly.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class CartoonsAssembly: Assembly {
    static func makeCartoonsCoordinator(parent: UINavigationController) -> CartoonsCoordinator {
        CartoonsCoordinator(parent: parent)
    }
    
    static func makeCartoonsController(storageService: StorageDataService) -> CartoonsViewController {
        let view = CartoonsViewController()
        let presenter = CartoonsPresenter(view: view, storageService: storageService)
        view.presenter = presenter
        return view
    }
}
