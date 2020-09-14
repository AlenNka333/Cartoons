//
//  AppNavigationRouterProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/7/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
    var onBoarding: UIPageViewController? { get set }
}

protocol RouterProtocol: RouterMain {
    func initOnBoarding()
    func initialViewController()
    func createVerificationController(animated: Bool, verificationId: String)
    func openCartoonsController(animated: Bool)
    func popToRoot(animated: Bool)
}
