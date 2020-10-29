//
//  MainScreenCoordinator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class MainScreenCoordinator: Coordinator {
    let storageService = StorageDataService()
    let authorizationService = AuthorizationService()
    
    var childCoordinators: [Coordinator?]
    var parent: Coordinator?
    var rootController: UIViewController
    var successSessionClosure: (() -> Void)?
    
    init() {
        self.rootController = UINavigationController()
        self.childCoordinators = [Coordinator?]()
    }
    
    func addChild(_ coordinator: Coordinator?) {
        coordinator?.parent = self
        childCoordinators.append(coordinator)
    }
    
    func start() {
        let cartoons = BaseNavigationController()
        cartoons.tabBarItem = UITabBarItem(title: R.string.localizable.cartoons_screen(), image: R.image.clapperboard(), tag: 0)
        
        let favourites = BaseNavigationController()
        favourites.tabBarItem = UITabBarItem(title: R.string.localizable.favourites_screen(), image: R.image.crown(), tag: 0)
        
        let settings = BaseNavigationController()
        settings.tabBarItem = UITabBarItem(title: R.string.localizable.settings_screen(), image: R.image.flower(), tag: 0)
        
        let tabBarController = TabBarViewController(controllers: [cartoons, favourites, settings])
        rootController = tabBarController
        
        let cartoonsCoordinator = CartoonsAssembly.makeCartoonsCoordinator(rootController: cartoons)
        addChild(cartoonsCoordinator)
        let favouritesCoordinator = FavouritesAssembly.makeFavouritesCoordinator(rootController: favourites)
        addChild(favouritesCoordinator)
        let settingsCoordinator = SettingsAssembly.makeSettingsCoordinator(rootController: settings)
        addChild(settingsCoordinator)
        settingsCoordinator.transitionDelegate = self
        
        cartoonsCoordinator.start()
        favouritesCoordinator.start()
        settingsCoordinator.start()
    }
    deinit {
        print("Main Fail")
    }
}

extension MainScreenCoordinator: TransitionDelegate {
    func transit() {
        successSessionClosure?()
        childCoordinators.forEach {  $0?.parent = nil }
        childCoordinators.removeAll()
    }
}
