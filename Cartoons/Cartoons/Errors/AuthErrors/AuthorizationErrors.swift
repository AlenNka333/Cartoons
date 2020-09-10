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
    case failedReCaptchaVerification
    case emptyVerificationID
    case emptyUser
}

extension AuthorizationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .emptyPhoneNumber:
            return NSLocalizedString("Description of empty phone number", comment: "Phone number field is empty")
        case .invalidPhoneNumber:
            return NSLocalizedString("Description of invalid phone number", comment: "Incorrect phone number. Please, check your input")
        case .failedReCaptchaVerification:
            return NSLocalizedString("Description of failed reCaptcha verification", comment: "Failed reCaptcha verification. Please, try again")
        case .emptyVerificationID:
            return NSLocalizedString("Description of empty response from firebase", comment: "Server error. Please, try again")
            case .emptyUser:
            return NSLocalizedString("Description of empty response from firebase", comment: "Server error. Please, try again")
        }
    }
}
