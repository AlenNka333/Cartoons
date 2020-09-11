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
    let firebaseManager = FirebaseManager()
    
    required init(view: CartoonsViewProtocol) {
        self.view = view
    }
    func signOutUserAction() {
        firebaseManager.signOutUser { [weak self] result in
            switch result {
            case .success(_):
                self?.view.setSuccess(success: R.string.localizable.success())
            case let .failure(error):
                self?.view.setError(error: error)
            }
        }
    }
    
    func showSuccess(success: String) {
        view.setSuccess(success: success)
    }
    
    func showError(error: Error) {
        view.setError(error: error)
    }
}
