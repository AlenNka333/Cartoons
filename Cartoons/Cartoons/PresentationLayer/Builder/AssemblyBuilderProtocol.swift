//
//  AssemblyBuilderProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/10/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

protocol AssemblyBuilderProtocol {
    func createOnBoarding(router: RouterProtocol, firebaseManager: FirebaseManager) -> UIViewController
    func createAuthorization(router: RouterProtocol, firebaseManager: FirebaseManager) -> UIViewController
    func createVerification(router: RouterProtocol, firebaseManager: FirebaseManager, verificationId: String, number: String) -> UIViewController
    func createTabBarController(router: RouterProtocol, manager: FirebaseManager, number: String) -> UIViewController
    func createCartoons() -> UIViewController
    func createFavourites() -> UIViewController
    func createSettings(router: RouterProtocol, manager: FirebaseManager, number: String) -> UIViewController
}
