//
//  AuthorizationCoordinatorProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/7/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol AuthorizationCoordinatorProtocol: CoordinatorProtocol {
    func openVerificationScreen(verificationId: String, number: String)
}
