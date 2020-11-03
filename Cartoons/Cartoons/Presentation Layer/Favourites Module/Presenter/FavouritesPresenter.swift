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
    let serviceLocator: Locator
    
    init(view: FavouritesViewProtocol, serviceLocator: Locator) {
        self.view = view
        self.serviceLocator = serviceLocator
        getData()
    }
    
    func showSuccess(success: String) {
        view.showSuccess(success: success)
    }
    
    func showError(error: Error) {
        view.showError(error: error)
    }
    
    func getData() {
        guard let storageService: StorageDataService = serviceLocator.resolve(StorageDataService.self),
              let fileManager: FilesManager = serviceLocator.resolve(FilesManager.self) else {
            return
        }
        let files = fileManager.getLocalData()
        view.setData(data: storageService.cartoons)
        
    }
}
