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
    
    func getData() {
        serviceProviderFacade.getServerData()
    }
    
    func showSuccess(success: String) {
        view.showSuccess(success: success)
    }
    
    func showError(error: Error) {
        view.showError(error: error)
    }
}

extension CartoonsPresenter: ServiceProviderDelegate {
    func updateProgress(_ progress: String) {
    }
    
    func updateDataSource(_ data: [Cartoon]?) {
        guard let data = data else {
            return
        }
        view.setDataSource(with: data)
    }
}
