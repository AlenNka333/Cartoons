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
    public var errorDescription: String? {
        switch self {
        case .operationQueueOverflow:
            return NSLocalizedString("Please, wait until current operation will be finished", comment: "Description of operation queue overflow")
        case .fileExists:
            return NSLocalizedString("Such file already exists in local folder", comment: "Description of double loading file")
        }
    }
}
