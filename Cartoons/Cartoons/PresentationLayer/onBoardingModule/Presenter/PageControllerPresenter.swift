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
    let firebaseManager: FirebaseManager?
    
    init(view: PageViewControllerProtocol, router: RouterProtocol, firebaseManager: FirebaseManager) {
        self.view = view
        self.router = router
        self.firebaseManager = firebaseManager
    }
    func saveUserCame() {
        AppData.shouldShowOnBoarding = false
    }
    func showAuthorizationScreen() {
        guard let manager = firebaseManager else {
            return
        }
        router?.showAuthorizationController(firebaseManager: manager)
    }
}
