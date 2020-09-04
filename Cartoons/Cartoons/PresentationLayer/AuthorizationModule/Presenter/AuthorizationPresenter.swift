//
//  AuthorizationPresenter.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/4/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

protocol AuthorizationViewProtocol: AnyObject {
    func setError (error: Error)
}

protocol AuthorizationViewPresenterProtocol: AnyObject {
    init(view: AuthorizationViewProtocol, router: RouterProtocol)
    func showError()
    func tabSendCode()
}

class AuthorizationPresenter: AuthorizationViewPresenterProtocol {
    let view: AuthorizationViewProtocol
    var router: RouterProtocol?
    
    required init(view: AuthorizationViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func showError() {
        //self.view.setError(error: e)
    }
    
    func tabSendCode() {
        router?.createVerification()
    }
}

extension AuthorizationViewController: AuthorizationViewProtocol {
    func setError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
