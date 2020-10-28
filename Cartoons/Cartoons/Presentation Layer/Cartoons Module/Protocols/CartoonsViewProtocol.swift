//
//  CartoonsViewProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/10/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol CartoonsViewProtocol: BaseViewProtocol, AnyObject {
    func showSuccess(success: String)
    func setDataSource(with array: [Cartoon])
}
