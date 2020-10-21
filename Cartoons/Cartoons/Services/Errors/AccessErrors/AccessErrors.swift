//
//  AccessErrors.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/29/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

enum AccessErrors: Error {
    case cameraNotAvailable
    case libraryNotAvailable
    case noCameraPermission
    case noLibraryPermission
}

extension AccessErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .cameraNotAvailable:
            return NSLocalizedString("Camera is not available to use", comment: "Description of camera failure usage")
        case .libraryNotAvailable:
            return NSLocalizedString("Library is not available to use", comment: "Description of library failure usage")
        case .noCameraPermission:
            return NSLocalizedString("Camera access required for capturing photos", comment: "Description of camera permission error")
        case .noLibraryPermission:
            return NSLocalizedString("Library access required for capturing photos", comment: "Description of library permission error")
        }
    }
}
