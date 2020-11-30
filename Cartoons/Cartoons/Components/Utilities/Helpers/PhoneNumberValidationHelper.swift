//
//  PhoneNumberValidationHelper.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/10/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

class PhoneNumberValidationHelper {
    static func checkValidation(phoneNumber: String, type: NumberFormat) -> Bool {
        switch type {
        case .bel:
            let phoneRegex = "^[+][0-9]{12}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            let result = phoneTest.evaluate(with: phoneNumber)
            return result
        case .other:
           let phoneRegex = "^[+][0-9]{11}$"
           let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
           let result = phoneTest.evaluate(with: phoneNumber)
           return result
        }
    }
}
