//
//  Locator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/28/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol Locator {
    func resolve<T>() -> T?
    func register<T>(_ service: T)
}

final class ServiceLocator: Locator {
    private var services: [ObjectIdentifier: Any] = [:]
    
    func register<T>(_ service: T) {
        services[key(for: T.self)] = service
    }
    
    func resolve<T>() -> T? {
        return services[key(for: T.self)] as? T
    }

    private func key<T>(for type: T.Type) -> ObjectIdentifier {
        return ObjectIdentifier(T.self)
    }
}
