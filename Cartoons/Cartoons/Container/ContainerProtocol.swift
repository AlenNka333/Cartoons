//
//  ServiceContainerProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/9/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol Container: Resolver {
    var parentResolver: Resolver? { get }
    var containers: [ContainerItem] { get set }

    func register<ContentType: Resolvable>(_ content: ContentType, keypath: AnyHashable?)
    func remove<ContentType: Resolvable>(_ content: ContentType, keypath: AnyHashable?)
    func renew<ContentType: Resolvable>(_ content: ContentType, keypath: AnyHashable?)
}

extension Container {
    func register<ContentType: Resolvable>(_ content: ContentType, keypath: AnyHashable?) {
        if index(of: ContentType.self, keypath: keypath) != nil {
            assertionFailure("Attempt to register the same content \(content)" +
                " of type: \(ContentType.self) kaypath: \(String(describing: keypath))")
        }
        containers.append(ContainerItem(content: content, identifier: keypath))
    }

    func remove<ContentType: Resolvable>(_ content: ContentType, keypath: AnyHashable?) {
        guard let index = index(of: ContentType.self, keypath: keypath) else {
            assertionFailure("Attempt to remove content \(content)" +
                " of type: \(ContentType.self) kaypath: \(String(describing: keypath))" +
                " which does not exists")
            return
        }
        containers.remove(at: index)
    }

    func renew<ContentType: Resolvable>(_ content: ContentType, keypath: AnyHashable?) {
        if let index = index(of: ContentType.self, keypath: keypath),
            let oldContent = containers[index].content as? ContentType {
            remove(oldContent, keypath: keypath)
        }
        register(content, keypath: keypath)
    }
    
    func resolve<ContentType: Resolvable>(_: ContentType.Type, keypath: AnyHashable?) -> ContentType {
        guard let index = index(of: ContentType.self, keypath: keypath) else {
            guard let parent = parentResolver else {
                fatalError("Unable to resolve \(ContentType.self), keypath: \(String(describing: keypath))")
            }
            return parent.resolve(ContentType.self, keypath: keypath)
        }
        guard let content = containers[index].content as? ContentType else {
            fatalError("Unable to cast conten: \(containers[index].content), to \(ContentType.self), keypath: \(String(describing: keypath))")
        }
        return content
    }
    
    func register<ContentType: Resolvable>(_ content: ContentType) {
        register(content, keypath: nil)
    }
    
    func remove<ContentType: Resolvable>(_ content: ContentType) {
        remove(content, keypath: nil)
    }
    
    func renew<ContentType: Resolvable>(_ content: ContentType) {
        renew(content, keypath: nil)
    }
}

// MARK: - Private
extension Container {
    func index<ContentType>(of _: ContentType.Type, keypath: AnyHashable?) -> Int? {
        containers.firstIndex(where: { $0.content is ContentType && $0.identifier == keypath })
    }
}
