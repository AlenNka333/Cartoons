//
//  FavouritesViewPresenterProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/21/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
protocol FavouritesViewPresenterProtocol: AnyObject {
    func showSuccess(success: String)
    func showError(error: Error)
    func getData()
}
