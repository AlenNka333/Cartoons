//
//  SettingsAssembly.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class SettingsAssembly: Assembly {
    static func makeSettingsController(number: String, firebaseManager: FirebaseManager, completion: @escaping(() -> Void)) -> UIViewController {
        let view = SettingsViewController()
        let presenter = SettingsPresenter(view: view, firebaseManager: firebaseManager, number: number)
        presenter.openAuthorizationClosure = {
            completion()
        }
        view.presenter = presenter
        let navigation = BaseNavigationController(rootViewController: view)
        navigation.tabBarItem = UITabBarItem(title: R.string.localizable.favourites_screen(), image: R.image.flower(), tag: 0)
        return navigation
    }
}
