//
//  ServiceError.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 11/5/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

enum ServiceErrors: Error {
    case operationQueueOverflow
    case fileExists
}

extension ServiceErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .operationQueueOverflow:
            return R.string.localizable.finish_operation()
        case .fileExists:
            return R.string.localizable.existing_file()
        }
    }
}
