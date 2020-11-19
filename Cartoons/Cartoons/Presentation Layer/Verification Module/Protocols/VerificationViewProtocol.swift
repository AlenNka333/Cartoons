//
//  VerificationViewProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol VerificationViewProtocol: BaseViewControllerProtocol, VerificationTransitionDelegate {
    func appendPhoneNumber(phoneNumber: String)
    func startTimer(timer: Timer, time: Int)
    func endTimer()
    func stopTimer()
    func updateTimerLabel(time: Int)
}
