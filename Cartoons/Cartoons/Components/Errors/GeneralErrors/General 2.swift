//
//  General.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/24/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

enum GeneralError: Error {
    case emptyPhoneNumber
    case invalidUrl
    case noSuchPath
    case emptyData
    case invalidLink
}

extension GeneralError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .emptyPhoneNumber:
            return NSLocalizedString("Sorry, something wrong on server. Try to authorize again", comment: "Description of empty phone number")
        case .invalidUrl:
            return NSLocalizedString("Invalid url", comment: "Description of url error")
        case .noSuchPath:
            return NSLocalizedString("We can't find such path to file", comment: "Description of wrong file path")
        case .emptyData:
            return NSLocalizedString("No files in fireStore", comment: "Description of empty data from firebase")
        case .invalidLink:
            return NSLocalizedString("Server error", comment: "Description of invalid or empty response from firebase")
        }
    }
}
