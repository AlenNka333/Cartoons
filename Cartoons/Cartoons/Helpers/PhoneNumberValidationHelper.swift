//
//  PhoneNumberValidationHelper.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/10/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

class PhoneNumberValidationHelper {
    static func checkValidation(number: String, type: NumberFormat) -> Bool {
        switch type {
        case .bel:
//            let phoneRegex = "^(+375|80) (29|25|44|33) (\\d{3})-(\\d{2})-(\\d{2})$"
//            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
//            let result = phoneTest.evaluate(with: number)
//            return result
            return true
        case .other:
            return false
        }
    }
}
