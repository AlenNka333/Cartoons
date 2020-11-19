//
//  FavouritesCoordinator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/27/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

class FavouritesCoordinator: Coordinator {
    let serviceProviderFacade: ServiceProviderFacade
    
    var parentCoordinator: Coordinator?
    var rootController: UINavigationController?
    
    init(rootController: UINavigationController, serviceProviderFacade: ServiceProviderFacade) {
        self.rootController = rootController
        self.serviceProviderFacade = serviceProviderFacade
    }
    
    func start() {
        let favouritesController = FavouritesModuleAssembly.makeFavouritesController(serviceProviderFacade: serviceProviderFacade)
        favouritesController.transitionDelegate = self
        rootController?.pushViewController(favouritesController, animated: false)
    }
}

extension FavouritesCoordinator {
    func openVideoPlayer(with link: URL?) {
        let player = PlayerModuleAssembly.makePlayerController(with: link)
        player.transitionDelegate = self
        rootController?.pushViewController(player, animated: true)
    }
}

extension FavouritesCoordinator: FavouritesTransitionDelegate {
    func transit(link: URL) {
        openVideoPlayer(with: link)
    }
}

extension FavouritesCoordinator: PlayerTransitionDelegate {
    func transit() {
        rootController?.popViewController(animated: true)
    }
}
