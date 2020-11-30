//
//  General.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/24/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

enum GeneralError: Error {
    case noSuchPath
    case emptyData
    case invalidUrl
}

extension GeneralError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return R.string.localizable.invalid_url()
        case .noSuchPath:
            return R.string.localizable.invalid_path()
        case .emptyData:
            return R.string.localizable.empty_storage()
        }
    }
}
