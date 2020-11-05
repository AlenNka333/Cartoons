//
//  MainScreenCoordinator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class MainScreenCoordinator: Coordinator {
    let serviceLocator: Locator
    
    var serviceProviderFacade: ServiceProviderFacade?
    var childCoordinators: [Coordinator?]
    var parent: Coordinator?
    var rootController: UIViewController
    var successSessionClosure: (() -> Void)?
    
    init(serviceLocator: Locator) {
        self.serviceLocator = serviceLocator
        self.rootController = UINavigationController()
        self.childCoordinators = [Coordinator?]()
        
        guard let storageService: StorageDataService = serviceLocator.resolve(StorageDataService.self),
              let loadingService: LoadingService = serviceLocator.resolve(LoadingService.self),
              let fileManager: FilesManager = serviceLocator.resolve(FilesManager.self) else {
            return
        }
        self.serviceProviderFacade = ServiceProviderFacade(storageService: storageService,
                                                loadingService: loadingService,
                                                fileManager: fileManager)
        serviceProviderFacade?.errorDelegate = self
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
        
        guard let serviceProviderFacade = serviceProviderFacade else {
            return
        }
        let cartoonsCoordinator = CartoonsAssembly.makeCartoonsCoordinator(rootController: cartoons,
                                                                           serviceLocator: serviceLocator,
                                                                           serviceProviderFacade: serviceProviderFacade)
        addChild(cartoonsCoordinator)
        let favouritesCoordinator = FavouritesAssembly.makeFavouritesCoordinator(rootController: favourites,
                                                                                 serviceProviderFacade: serviceProviderFacade)
        addChild(favouritesCoordinator)
        let settingsCoordinator = SettingsAssembly.makeSettingsCoordinator(rootController: settings, serviceLocator: serviceLocator)
        addChild(settingsCoordinator)
        settingsCoordinator.transitionDelegate = self
        
        cartoonsCoordinator.start()
        favouritesCoordinator.start()
        settingsCoordinator.start()
    }
}

extension MainScreenCoordinator: TransitionDelegate {
    func transit() {
        successSessionClosure?()
        childCoordinators.forEach {  $0?.parent = nil }
        childCoordinators.removeAll()
    }
}

extension MainScreenCoordinator: ErrorPresentable {
    func show(error: Error) {
        let alert = AlertService.alert(title: R.string.localizable.error(), body: error.localizedDescription, alertType: .error) { _ in
            return
        }
        rootController.present(alert, animated: true)
    }
}

protocol ErrorPresentable: Coordinator {
    func show(error: Error)
}
