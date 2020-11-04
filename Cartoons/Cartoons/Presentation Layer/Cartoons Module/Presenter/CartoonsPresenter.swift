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
    let dataFacade: Facade
    
    init(view: CartoonsViewProtocol, serviceLocator: Locator, dataFacade: DataFacade) {
        self.view = view
        self.serviceLocator = serviceLocator
        self.dataFacade = dataFacade
        dataFacade.cartoonsDataSourceDelegate = self
    }
    
    func getData() {
//        guard let service: StorageDataService = serviceLocator.resolve(StorageDataService.self) else {
//            return
//        }
//        service.checkFoldersExists { [weak self] result in
//            switch result {
//            case .failure(let error):
//                self?.view.showError(error: error)
//            case .success(let array):
//                self?.view.setDataSource(with: array)
//            }
//        }
        dataFacade.getServerData()
    }
    
    func showSuccess(success: String) {
        view.showSuccess(success: success)
    }
    
    func showError(error: Error) {
        view.showError(error: error)
    }
}

extension CartoonsPresenter: DataSourceDelegate {
    func updateDataSource(_ data: [Cartoon]?) {
        guard let data = data else {
            return
        }
        view.setDataSource(with: data)
    }
}
