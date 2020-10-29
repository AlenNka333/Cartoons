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
    var parent: Coordinator? { get set }
    
    func start()
    func removeParent()
}

extension Coordinator {
    func removeParent() {
        parent = nil
    }
}
