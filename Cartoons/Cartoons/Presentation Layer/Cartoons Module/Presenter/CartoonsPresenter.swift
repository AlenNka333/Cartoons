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
    let serviceLocator: Locator
    let serviceProviderFacade: Facade
    
    init(view: CartoonsViewProtocol, serviceLocator: Locator, serviceProviderFacade: ServiceProviderFacade) {
        self.view = view
        self.serviceLocator = serviceLocator
        self.serviceProviderFacade = serviceProviderFacade
        
        serviceProviderFacade.cartoonsDataSourceDelegate = self
    }
    
    func getDataList() {
        serviceProviderFacade.getServerDataList()
    }
    
    func transit(with cartoon: Cartoon) {
        view.transit(with: cartoon)
    }
    
    func showError(error: Error) {
        view.showError(error: error)
    }
}

extension CartoonsPresenter: ServiceProviderDelegate {
    func updateDataList(_ data: [Cartoon]?) {
        guard let data = data else {
            return
        }
        view.updateDataList(with: data)
    }
}
