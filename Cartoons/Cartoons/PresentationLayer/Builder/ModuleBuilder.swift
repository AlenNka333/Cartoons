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
    
    func createTabBarController(router: RouterProtocol) -> UIViewController {
        let view = TabBarViewController()
        return view
    }
}
