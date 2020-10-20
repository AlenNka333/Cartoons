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
    let storage: StorageDataService
    
    var folders = [String]()
    var openPlayerClosure: () -> Void = {}
    
    init(view: CartoonsViewProtocol, storageService: StorageDataService) {
        self.view = view
        self.storage = storageService
    }
    
    func getData() {
        storage.checkListAvailable { [weak self] result in
            switch result {
            case .failure(let error):
                self?.view.showError(error: error)
            case .success:
                self?.sendRequest()
            }
        }
    }
    
    func sendRequest() {
        storage.sendRequest { [weak self] result in
            switch result {
            case .failure(let error):
                self?.view.showError(error: error)
                return
            case .success(let array):
                Cartoon.allVideos = array
            }
        }
    }
    
    func showSuccess(success: String) {
        view.showSuccess(success: success)
    }
    
    func showError(error: Error) {
        view.showError(error: error)
    }
    
    func openPlayer() {
        openPlayerClosure()
    }
}
