//
//  CartoonsViewPresenterProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/10/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol CartoonsViewPresenterProtocol: PresenterProtocol, AnyObject {
    func getData()
    func sendRequest()
    func showSuccess(success: String)
    func openPlayer()
}
