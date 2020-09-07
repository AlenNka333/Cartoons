//
//  AuthorizationPresenter.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/4/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

class AuthorizationPresenter: AuthorizationViewPresenterProtocol {
    let view: AuthorizationViewProtocol
    var router: RouterProtocol?
    let firebaseManager: FirebaseManager
    
    required init(view: AuthorizationViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
        self.firebaseManager = FirebaseManager()
    }
    
    func sendPhoneNumberAction(number: String) {
        router?.createVerification()
        firebaseManager.sendPhoneNumber(number: number) { [weak self] error in
            error == nil ? () : self?.view.setError(error: error)
        }
    }
}
