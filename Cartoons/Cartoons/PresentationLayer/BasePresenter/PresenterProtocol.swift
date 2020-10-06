//
//  PresenterProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/6/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol PresenterProtocol {
    init(view: ViewProtocol, coordinator: CoordinatorProtocol)
    
    func showError(error: Error)
}
