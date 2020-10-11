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
    
    var openAuthorizationScreen: () -> Void = {}
    
    init(view: PageViewControllerProtocol) {
        self.view = view
    }
    func showAuthorizationScreen() {
        openAuthorizationScreen()
    }
}
