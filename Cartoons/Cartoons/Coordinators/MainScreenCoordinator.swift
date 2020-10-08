//
//  MainScreenCoordinator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class MainScreenCoordinator: MainScreenCoordinatorProtocol {
    var root: UIViewController
    let number: String
    let window: UIWindow?
    let firebaseManager = FirebaseManager()
    
    var successUserSession: () -> Void = {}
    
    init(number: String) {
        self.root = TabBarViewController()
        self.number = number
        self.window = UIApplication.shared.windows.first { $0.isKeyWindow }
    }
    
    func start() {
        var controllers = [UIViewController]()
        let cartoons = CartoonsAssembly.makeCartoonsController()
        let favourites = FavouritesAssembly.makeFavouritesController()
        
        let settings = SettingsAssembly.makeSettingsController()
        let presenter = SettingsPresenter(view: (settings as? SettingsViewController)!, firebaseManager: firebaseManager, number: number)
        presenter.openAuthorizationClosure = { [weak self] in
            self?.successUserSession()
        }
        (settings as? SettingsViewController)?.presenter = presenter
        
        controllers.append(cartoons)
        controllers.append(favourites)
        controllers.append(settings)
        (self.root as? TabBarViewController)?.viewControllers = controllers
        guard let window = window else {
            return
        }
        window.rootViewController = root
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
