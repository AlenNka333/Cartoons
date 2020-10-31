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
    let serviceLocator: Locator
    
    var parent: Coordinator?
    var rootController: UINavigationController?
    var successSessionClosure: (() -> Void)?
    
    init(rootController: UINavigationController, serviceLocator: Locator) {
        self.rootController = rootController
        self.serviceLocator = serviceLocator
    }
    
    func start() {
        let favouritesController = FavouritesAssembly.makeFavouritesController(serviceLocator: serviceLocator)
        rootController?.pushViewController(favouritesController, animated: false)
    }
    
    deinit {
        print("Fav Fail")
    }
}
