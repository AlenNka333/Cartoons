//
//  VerificationViewProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol VerificationViewProtocol: BaseViewProtocol, AnyObject {
    func setLabelText(number: String)
    func startTimer(timer: Timer, time: Int)
    func endTimer()
    func updateTime(timer: Int)
    func transit()
}
