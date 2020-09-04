//
//  VerificationVIewPresenter.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/5/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

protocol VerificationViewProtocol: AnyObject {
    func setError (error: Error)
}

protocol VerificationViewPresenterProtocol: AnyObject {
    init(view: VerificationViewProtocol, router: RouterProtocol)
    func showError()
}

class VerificationPresenter: VerificationViewPresenterProtocol {
    
    let view: VerificationViewProtocol?
    var router: RouterProtocol?
    
    required init(view: VerificationViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func showError() {
        //self.view.setError(error: e)
    }
}

extension VerificationCodeViewController: VerificationViewProtocol {
    func setError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
