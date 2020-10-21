//
//  CoordinatorProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/6/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

protocol CoordinatorProtocol: AnyObject {
    var parent: CoordinatorProtocol? { get set }
    
    func start()
    func removeParent()
}

extension CoordinatorProtocol {
    func removeParent() {
        parent = nil
    }
}
