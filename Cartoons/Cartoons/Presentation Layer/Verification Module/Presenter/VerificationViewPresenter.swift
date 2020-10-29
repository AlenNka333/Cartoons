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
    let serviceLocator: Locator
    let verificationId: String
    let number: String
    var timer = Constant.totalTime
    
    var successSessionClosure: (() -> Void)?
    
    init(view: VerificationViewProtocol, locator: Locator, verificationId: String, number: String) {
        self.view = view
        self.serviceLocator = locator
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
        guard let service: AuthorizationService = serviceLocator.resolve(AuthorizationService.self) else {
            return
        }
        service.verifyUser(number: number) { [weak self] result in
            switch result {
            case .success:
                break
            case .failure(let error):
                self?.view.showError(error: error)
            }
        }
    }
    
    func verifyUser(verificationCode: String) {
        guard let service: AuthorizationService = serviceLocator.resolve(AuthorizationService.self) else {
            return
        }
        service.signIn(verificationId: verificationId, verifyCode: verificationCode) { [weak self] result in
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
