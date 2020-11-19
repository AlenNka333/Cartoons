//
//  AuthorizationViewPresenterProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/7/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol AuthorizationViewPresenterProtocol: AnyObject {
    func sendRequest(with phoneNumber: String)
    func showError(error: Error)
}
