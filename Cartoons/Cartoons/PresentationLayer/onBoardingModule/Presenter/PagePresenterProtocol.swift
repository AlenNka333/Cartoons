//
//  PageControllerPresenterProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/14/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol PagePresenterProtocol: AnyObject {
    init(view: PageViewControllerProtocol, router: RouterProtocol)
    func showAuthorizationScreen()
    func saveUserCame()
}
