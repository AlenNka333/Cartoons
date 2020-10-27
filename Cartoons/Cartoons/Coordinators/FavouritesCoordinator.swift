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
    var parent: Coordinator?
    
    var navigationController: UINavigationController
    var successSessionClosure: (() -> Void)?
    
    init(parent: UINavigationController) {
        navigationController = parent
    }
    
    func start() {
        let favouritesController = FavouritesAssembly.makeFavouritesController()
        navigationController.pushViewController(favouritesController, animated: false)
    }
}
