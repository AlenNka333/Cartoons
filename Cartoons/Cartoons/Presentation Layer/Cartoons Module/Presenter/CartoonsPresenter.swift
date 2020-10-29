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
    let locator: Locator
    
    var openPlayerClosure: ((URL) -> Void)?
    
    init(view: CartoonsViewProtocol, locator: Locator) {
        self.view = view
        self.locator = locator
    }
    
    func getData() {
        guard let service: StorageDataService = locator.resolve(StorageDataService.self) else {
            return
        }
        service.checkFoldersExists { [weak self] result in
            switch result {
            case .failure(let error):
                self?.view.showError(error: error)
            case .success(let array):
                self?.view.setDataSource(with: array)
            }
        }
    }
    
    func showSuccess(success: String) {
        view.showSuccess(success: success)
    }
    
    func showError(error: Error) {
        view.showError(error: error)
    }
    
    func openPlayer(with link: URL) {
        guard let closure = openPlayerClosure else {
            return
        }
        closure(link)
    }
}
