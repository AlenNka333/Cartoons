//
//  CartoonsPresenter.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/10/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

class CartoonsPresenter: CartoonsViewPresenterProtocol {
    let view: CartoonsViewProtocol
    let router: RouterProtocol?
    
    required init(view: CartoonsViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
}
