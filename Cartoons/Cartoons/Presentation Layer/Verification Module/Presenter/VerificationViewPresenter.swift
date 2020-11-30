//
//  VerificationVIewPresenter.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/5/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

class VerificationPresenter {
    enum Constant {
        static let totalTime = 60
    }
    
    let serviceLocator: Locator
    let verificationId: String
    let phoneNumber: String
    
    var view: VerificationViewProtocol
    var time = Constant.totalTime
    var successSessionClosure: (() -> Void)?
    
    init(view: VerificationViewProtocol, serviceLocator: Locator, verificationId: String, phoneNumber: String) {
        self.view = view
        self.serviceLocator = serviceLocator
        self.verificationId = verificationId
        self.phoneNumber = phoneNumber
        
        view.appendPhoneNumber(phoneNumber: phoneNumber)
    }
    
    func startTimer() {
        time = Constant.totalTime
        view.startTimer(timer: Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true),
                        time: time)
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
        service.verifyPhoneNumber(phoneNumber: phoneNumber) { [weak self] result in
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
                self?.view.transit()
            case let .failure(error):
                self?.view.showError(error: error)
                self?.view.endTimer()
            }
        }
    }
}

extension VerificationPresenter: VerificationViewPresenterProtocol {
    @objc func updateTime() {
        view.updateTimerLabel(time: time)
        if time != 0 {
            time -= 1
        } else {
            view.endTimer()
        }
    }
}
