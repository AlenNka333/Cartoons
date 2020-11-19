//
//  FavouritesViewProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/21/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
protocol FavouritesViewProtocol: BaseViewControllerProtocol, AnyObject {
    func showSuccess(success: String)
    func setData(data: [Cartoon])
    func updateProgress(_ progress: Float)
}
