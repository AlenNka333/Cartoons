//
//  CoordinatorProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/6/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    
    func start()
    func removeParent()
}

extension Coordinator {
    func removeParent() {
        parentCoordinator = nil
    }
}
