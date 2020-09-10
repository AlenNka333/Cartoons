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
    let view: VerificationViewProtocol
    let router: RouterProtocol?
    let verificationId: String
    let firebaseManager = FirebaseManager()
    
    required init(view: VerificationViewProtocol, router: RouterProtocol, verificationId: String) {
        self.view = view
        self.router = router
        self.verificationId = verificationId
    }
    func showError(error: Error) {
        view.setError(error: error)
    }
    func verifyUser(verificationCode: String) {
        firebaseManager.authorizeUser(verificationId: verificationId, verifyCode: verificationCode) { [weak self] result in
            switch result {
            case let .success(user):
                //move to another screen
                print("data: \(String(describing: user?.user.phoneNumber))")
                CustomAlertView.instance.showAlert(title: "Error", message: "Works", alertType: .success)
            case let .failure(error):
                self?.view.setError(error: error)
            }
        }
    }
}
