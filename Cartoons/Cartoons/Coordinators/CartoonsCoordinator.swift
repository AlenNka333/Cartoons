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
    let storageService = StorageDataService()
    
    var parent: UINavigationController?
    
    init(parent: UINavigationController) {
        self.parent = parent
    }
    
    func start() {
        let cartoonsController = CartoonsAssembly.makeCartoonsController(storageService: storageService)
        cartoonsController.transitionDelegate = self
        parent?.pushViewController(cartoonsController, animated: false)
    }
}

extension CartoonsCoordinator {
    func openDetailsScreen(with video: Cartoon?) {
        guard let cartoon = video else {
            return
        }
        let detailsController = DetailsAssembly.makeDetailsController(with: cartoon)
        detailsController.transitionDelegate = self
        parent?.pushViewController(detailsController, animated: true)
    }
    
    func openVideoPlayer(with link: URL?) {
        let player = PlayerAssembly.makePlayerController(with: link)
        player.transitionDelegate = self
        parent?.pushViewController(player, animated: true)
    }
}

extension CartoonsCoordinator: CartoonsTransitionDelegate {
    func transit(cartoon: Cartoon) {
        openDetailsScreen(with: cartoon)
    }
}

extension CartoonsCoordinator: DetailsTransitionDelegate {
    func transit(with link: URL) {
        openVideoPlayer(with: link)
    }
}

extension CartoonsCoordinator: PlayerTransitionDelegate {
    func transit() {
        parent?.popViewController(animated: true)
    }
}
