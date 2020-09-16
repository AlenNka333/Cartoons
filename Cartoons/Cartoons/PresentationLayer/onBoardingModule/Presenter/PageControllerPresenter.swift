//
//  PageControllerPresenter.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/14/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
 
class PageControllerPresenter: PagePresenterProtocol {
    let view: PageViewControllerProtocol
    let router: RouterProtocol?
    
    required init(view: PageViewControllerProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    func saveUserCame() {
        AppData.isFirstComing = false
    }
    func showAuthorizationScreen() {
        router?.showAuthorizationController()
    }
}
