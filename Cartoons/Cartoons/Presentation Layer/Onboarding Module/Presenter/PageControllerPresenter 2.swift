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
    
    init(view: PageViewControllerProtocol) {
        self.view = view
    }
}
