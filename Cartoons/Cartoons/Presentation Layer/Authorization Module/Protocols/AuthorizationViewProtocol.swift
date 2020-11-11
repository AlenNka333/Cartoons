//
//  AuthorizationViewProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/7/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol AuthorizationViewProtocol: BaseViewProtocol, AnyObject {
    func transit(verificationId: String, number: String)
}
