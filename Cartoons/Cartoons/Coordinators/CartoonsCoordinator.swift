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
        let cartoonsController = CartoonsAssembly.makeCartoonsController(storageService: storageService) { movie in
            self.openDetailsScreen(with: movie)
        }
        parent?.pushViewController(cartoonsController, animated: false)
    }
}

extension CartoonsCoordinator {
    func openDetailsScreen(with video: Cartoon?) {
        guard let cartoon = video else {
            return
        }
        let detailsCoordinator = DetailsAssembly.makeDetailsController(with: cartoon) { [weak self] in
            self?.openVideoPlayer(with: $0)
        }
        parent?.pushViewController(detailsCoordinator, animated: true)
    }
    
    func openVideoPlayer(with link: URL?) {
        let view = PlayerAssembly.makePlayerController(with: link)
        
        view.transitions.close = { [weak self] in
            self?.parent?.popViewController(animated: true)
        }
        parent?.pushViewController(view, animated: true)
    }
}
