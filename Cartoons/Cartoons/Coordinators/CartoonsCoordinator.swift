//
//  CartoonsCoordinator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/27/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

class CartoonsCoordinator: Coordinator {
    var parent: Coordinator?
    
    var navigationController: UINavigationController
    let storageService = StorageDataService()
    
    init(parent: UINavigationController) {
        navigationController = parent
    }
    
    func start() {
        let cartoonsController = CartoonsAssembly.makeCartoonsController(storageService: storageService) { movie in
            self.openDetailsScreen(with: movie)
        }
        navigationController.pushViewController(cartoonsController, animated: false)
    }
}

extension CartoonsCoordinator {
    func openDetailsScreen(with video: Cartoon?) {
        guard let cartoon = video else {
            return
        }
        let detailsCoordinator = DetailsAssembly.makeDetailsCoordinator(parent: navigationController, movie: cartoon)
        detailsCoordinator.start()
    }
}
