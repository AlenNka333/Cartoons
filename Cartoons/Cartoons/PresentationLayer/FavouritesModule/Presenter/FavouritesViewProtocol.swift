//
//  FavouritesViewProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/21/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
protocol FavouritesViewProtocol: AnyObject {
    func setError (error: Error)
    func setSuccess(success: String)
}
