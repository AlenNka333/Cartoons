//
//  FavouritesPresenter.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/21/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

class SettingsPresenter: SettingsViewPresenterProtocol {
    let view: SettingsViewProtocol
    
    required init(view: SettingsViewProtocol) {
        self.view = view
    }
    
    func showSuccess(success: String) {
        view.setSuccess(success: success)
    }
    
    func showError(error: Error) {
        view.setError(error: error)
    }
}
