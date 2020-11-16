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
            return R.string.localizable.empty_phone_number()
        case .invalidPhoneNumber:
            return R.string.localizable.invalid_number()
        case .failedReCaptchaVerification:
            return R.string.localizable.failed_verification()
        case .emptyVerificationID:
            return R.string.localizable.invalid_verificationId()
        case .emptyUser:
            return R.string.localizable.invalid_user()
        }
    }
}
