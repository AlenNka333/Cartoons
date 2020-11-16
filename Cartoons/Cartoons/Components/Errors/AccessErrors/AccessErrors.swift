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
            return R.string.localizable.camera_not_available()
        case .libraryNotAvailable:
            return R.string.localizable.library_not_available()
        case .noCameraPermission:
            return R.string.localizable.no_camera_permissions()
        case .noLibraryPermission:
            return R.string.localizable.no_library_permission()
        }
    }
}
