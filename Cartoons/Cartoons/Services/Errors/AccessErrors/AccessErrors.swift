//
//  AccessErrors.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/29/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

enum AccessErrors: Error {
    case noCameraPermission
    case noLibraryPermission
}

extension AccessErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noCameraPermission:
            return NSLocalizedString("Camera access required for capturing photos", comment: "Description of camera permission error")
        case .noLibraryPermission:
            return NSLocalizedString("Library access required for capturing photos", comment: "Description of library permission error")
        }
    }
}
