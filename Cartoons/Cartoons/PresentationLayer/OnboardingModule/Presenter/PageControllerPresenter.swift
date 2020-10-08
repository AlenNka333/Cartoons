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
    let firebaseManager: FirebaseManager
    
    var openAuthorizationScreen: () -> Void = {}
    
    init(view: PageViewControllerProtocol, firebaseManager: FirebaseManager) {
        self.view = view
        self.firebaseManager = firebaseManager
    }
    
    func saveUserCame() {
        AppData.shouldShowOnBoarding = false
    }
    
    func showAuthorizationScreen() {
        openAuthorizationScreen()
    }
}
