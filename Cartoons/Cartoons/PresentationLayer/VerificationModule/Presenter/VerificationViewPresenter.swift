//
//  VerificationVIewPresenter.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/5/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

class VerificationPresenter: VerificationViewPresenterProtocol {
    enum Constant {
        static let totalTime = 60
    }

    var view: VerificationViewProtocol
    let authorizationService: AuthorizationServiceProtocol
    let verificationId: String
    var timer = Constant.totalTime
    
    var successSessionClosure: (() -> Void)?
    
    init(view: VerificationViewProtocol, authorizationService: AuthorizationServiceProtocol, verificationId: String) {
        self.view = view
        self.authorizationService = authorizationService
        self.verificationId = verificationId
        view.setLabelText(number: authorizationService.phoneNumber.unwrapped)
    }
    
    func startTimer() {
        timer = Constant.totalTime
        view.startTimer(timer: Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true), time: timer)
    }
    
    func endTimer() {
        view.endTimer()
    }

    func showError(error: Error) {
        view.showError(error: error)
    }
    
    func resendVerificationCode() {
        authorizationService.verifyUser(number: authorizationService.phoneNumber.unwrapped) { [weak self] result in
            switch result {
            case .success:
                break
            case .failure(let error):
                self?.view.showError(error: error)
            }
        }
    }
    
    func verifyUser(verificationCode: String) {
        authorizationService.signIn(verificationId: verificationId, verifyCode: verificationCode) { [weak self] result in
            switch result {
            case .success:
                self?.view.transit()
            case let .failure(error):
                self?.view.showError(error: error)
            }
        }
    }
}

extension VerificationPresenter {
    @objc func updateTime() {
        view.updateTime(timer: timer)
        if timer != 0 {
            timer -= 1
        } else {
            view.endTimer()
        }
    }
}
