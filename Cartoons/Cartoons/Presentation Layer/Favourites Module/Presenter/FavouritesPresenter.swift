//
//  FavouritesPresenter.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/21/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

class FavouritesPresenter: FavouritesViewPresenterProtocol {
    let view: FavouritesViewProtocol
    let serviceProviderFacade: ServiceProviderFacade
    
    init(view: FavouritesViewProtocol, serviceProviderFacade: ServiceProviderFacade) {
        self.view = view
        self.serviceProviderFacade = serviceProviderFacade
        serviceProviderFacade.favouritesDataSourceDelegate = self
    }
    
    func showSuccess(success: String) {
        view.showSuccess(success: success)
    }
    
    func showError(error: Error) {
        view.showError(error: error)
    }
    
    func getData() {
        serviceProviderFacade.getLocalData()
    }
}

extension FavouritesPresenter: FavouritesServiceProviderDelegate {
    func updateProgress(_ progress: Float) {
        view.updateProgress(progress)
    }
    
    func updateDataList(_ data: [Cartoon]?) {
        view.setData(data: data ?? [Cartoon]())
    }
}
