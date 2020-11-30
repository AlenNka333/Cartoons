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
    let serviceLocator: Locator
    let serviceProviderFacade: ServiceProviderFacade
    
    var parentCoordinator: Coordinator?
    var rootController: UINavigationController?
    
    init(rootController: UINavigationController, serviceLocator: Locator, serviceProviderFacade: ServiceProviderFacade) {
        self.rootController = rootController
        self.serviceLocator = serviceLocator
        self.serviceProviderFacade = serviceProviderFacade
    }
    
    func start() {
        let cartoonsController = CartoonsModuleAssembly.makeCartoonsController(serviceLocator: serviceLocator,
                                                                               serviceProviderFacade: serviceProviderFacade)
        cartoonsController.transitionDelegate = self
        rootController?.pushViewController(cartoonsController, animated: false)
    }
}

extension CartoonsCoordinator {
    func openDetailsScreen(with video: Cartoon?) {
        guard let cartoon = video else {
            return
        }
        let detailsController = DetailsModuleAssembly.makeDetailsController(with: cartoon, serviceLocator: serviceLocator)
        detailsController.transitionDelegate = self
        rootController?.pushViewController(detailsController, animated: true)
    }
    
    func openVideoPlayer(with link: URL?) {
        let player = PlayerModuleAssembly.makePlayerController(with: link)
        player.transitionDelegate = self
        rootController?.pushViewController(player, animated: true)
    }
}

extension CartoonsCoordinator: CartoonsTransitionDelegate {
    func transit(with cartoon: Cartoon) {
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
        rootController?.popViewController(animated: true)
    }
}
