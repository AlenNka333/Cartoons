//
//  VerificationViewPresenterProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol VerificationViewPresenterProtocol: AnyObject {
    init(view: VerificationViewProtocol, router: RouterProtocol)
    func showError(error: Error)
}

