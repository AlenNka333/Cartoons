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
    var rootController: UINavigationController?
    var successSessionClosure: (() -> Void)?
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
    }
    
    func start() {
        let favouritesController = FavouritesAssembly.makeFavouritesController()
        rootController?.pushViewController(favouritesController, animated: false)
    }
    
    deinit {
        print("Fav Fail")
    }
}
