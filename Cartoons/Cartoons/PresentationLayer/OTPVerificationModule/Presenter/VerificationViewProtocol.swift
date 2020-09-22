//
//  VerificationViewProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol VerificationViewProtocol: AnyObject {
    func setError (error: Error)
    func setLabelText(number: String)
    func showActivityIndicatorAction()
    func stopActivityIndicatorAction()
}
