//
//  Resolver.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/9/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

public protocol Resolvable {
    // Empty
}

public protocol Resolver: AnyObject {
    func resolve<ServiceType: Resolvable>(_: ServiceType.Type, keypath: AnyHashable?) -> ServiceType
}

extension Resolver {
    func resolve<ServiceType: Resolvable>(_: ServiceType.Type) -> ServiceType {
        return resolve(ServiceType.self, keypath: nil)
    }
}
