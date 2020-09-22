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
    func createOnBoarding(router: RouterProtocol) -> UIViewController
    func createAuthorization(router: RouterProtocol) -> UIViewController
    func createVerification(router: RouterProtocol, verificationId: String, number: String) -> UIViewController
    func createTabBarController(router: RouterProtocol) -> UIViewController
    func createCartoons() -> UIViewController
    func createFavourites() -> UIViewController
    func createSettings() -> UIViewController
}
