//
//  VerificationViewPresenterProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol VerificationViewPresenterProtocol: PresenterProtocol, AnyObject {
    func verifyUser(verificationCode: String)
    func resendVerificationCode()
}
