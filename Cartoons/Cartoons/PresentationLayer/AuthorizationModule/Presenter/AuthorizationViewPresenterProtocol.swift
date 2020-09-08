//
//  AuthorizationViewPresenterProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/7/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol AuthorizationViewPresenterProtocol: AnyObject {
    init(view: AuthorizationViewProtocol, router: RouterProtocol)
    func sendPhoneNumberAction(number: String)
    func showError(error: Error?)
}
