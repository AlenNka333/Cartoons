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
    
    func showError(error: Error) {
        view.showError(error: error)
    }
    
    func getDataList() {
        serviceProviderFacade.getLocalDataList()
    }
    
    func transit(with videoUrl: URL) {
        view.transit(with: videoUrl)
    }
}

extension FavouritesPresenter: FavouritesServiceProviderDelegate {
    func setBytesLoadedPercentage(_ percent: Float) {
        view.setBytesLoadedPercentage(percent)
    }
    
    func updateDataList(_ data: [Cartoon]?) {
        view.updateDataList(data: data ?? [Cartoon]())
    }
}
