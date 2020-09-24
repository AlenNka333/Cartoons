//
//  ModuleBuilder.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/4/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

class ModuleBuilder: AssemblyBuilderProtocol {
    func createOnBoarding(router: RouterProtocol) -> UIViewController {
        let view = PageViewController()
        let presenter = PageControllerPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createAuthorization(router: RouterProtocol) -> UIViewController {
        let view = AuthorizationViewController()
        let presenter = AuthorizationPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createVerification(router: RouterProtocol, verificationId: String, number: String) -> UIViewController {
        let view = VerificationCodeViewController()
        let presenter = VerificationPresenter(view: view, router: router, verificationId: verificationId, number: number)
        view.presenter = presenter
        return view
    }
    
    func createCartoons() -> UIViewController {
        let view = CartoonsViewController()
        let presenter = CartoonsPresenter(view: view)
        view.presenter = presenter
        let navigation = BaseNavigationController(rootViewController: view)
        navigation.tabBarItem = UITabBarItem(title: TabState.media.rawValue, image: R.image.clapperboard(), tag: 0)
        return navigation
    }
    
    func createFavourites() -> UIViewController {
        let view = FavouritesViewController()
        let presenter = FavouritesPresenter(view: view)
        view.presenter = presenter
        let navigation = BaseNavigationController(rootViewController: view)
        navigation.tabBarItem = UITabBarItem(title: TabState.favourites.rawValue, image: R.image.crown(), tag: 1)
        return navigation
    }
    
    func createSettings(router: RouterProtocol) -> UIViewController {
        let view = SettingsViewController()
        let presenter = SettingsPresenter(view: view, router: router)
        view.presenter = presenter
        let navigation = UINavigationController(rootViewController: view)
        navigation.tabBarItem = UITabBarItem(title: TabState.settings.rawValue, image: R.image.flower(), tag: 2)
        return navigation
    }
    
    func createTabBarController(router: RouterProtocol) -> UIViewController {
        let view = TabBarViewController()
        view.viewControllers = [createCartoons(), createFavourites(), createSettings(router: router)]
        return view
    }
}
