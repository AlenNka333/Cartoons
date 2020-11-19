//
//  AuthorizationTransitionDelegate.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/29/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol AuthorizationTransitionProtocol: AnyObject {
    func transit(_ verificationId: String, _ phoneNumber: String)
}
