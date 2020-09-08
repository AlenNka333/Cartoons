//
//  VerificationVIewPresenter.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/5/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

class VerificationPresenter: VerificationViewPresenterProtocol {
    let view: VerificationViewProtocol?
    let router: RouterProtocol?
    
    required init(view: VerificationViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func showError(error: Error) {
       view?.setError(error: error)
    }
}

extension VerificationCodeViewController: VerificationViewProtocol {
    func setError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
