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
            return NSLocalizedString("Phone number field is empty", comment: "Description of empty phone number")
        case .invalidPhoneNumber:
            return NSLocalizedString("Incorrect phone number. Please, check your input", comment: "Description of invalid phone number")
        case .failedReCaptchaVerification:
            return NSLocalizedString("Failed reCaptcha verification. Please, try again", comment: "Description of failed reCaptcha verification")
        case .emptyVerificationID:
            return NSLocalizedString("Server error. Please, try again", comment: "Description of empty response from firebase")
            case .emptyUser:
            return NSLocalizedString( "Server error. Please, try again", comment: "Description of empty response from firebase")
        }
    }
}
