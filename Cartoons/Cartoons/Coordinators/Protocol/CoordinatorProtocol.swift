//
//  CoordinatorProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/6/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

protocol CoordinatorProtocol {
    var root: UIViewController { get set }
    
    func start()
}
