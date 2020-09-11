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
    func createAuthorization(router: RouterProtocol) -> UIViewController
    func createVerification(router: RouterProtocol, verificationId: String) -> UIViewController
    func createCartoons(router: RouterProtocol) -> UIViewController
    func createTabBarController(router: RouterProtocol) -> UITabBarController
}
