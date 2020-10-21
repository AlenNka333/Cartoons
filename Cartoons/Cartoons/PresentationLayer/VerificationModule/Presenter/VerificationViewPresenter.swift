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
    let number: String
    var timer = Constant.totalTime
    
    var successSessionClosure: (() -> Void)?
    
    init(view: VerificationViewProtocol, authorizationService: AuthorizationServiceProtocol, verificationId: String, number: String) {
        self.view = view
        self.authorizationService = authorizationService
        self.verificationId = verificationId
        self.number = number
        view.setLabelText(number: number)
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
        authorizationService.verifyUser(number: number) { [weak self] result in
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
                guard let closure = self?.successSessionClosure else {
                    return
                }
                closure()
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
