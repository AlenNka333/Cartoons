//
//  AuthorizationErrors.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/7/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

enum AuthorizationError: Error {
    case emptyPhoneNumber
    case invalidPhoneNumber
    case failReCapchaVerification
}
