//
//  FavouritesViewPresenterProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/21/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
protocol FavouritesViewPresenterProtocol: AnyObject {
    func showError(error: Error)
    func showSuccess(success: String)
}
