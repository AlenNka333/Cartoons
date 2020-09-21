//
//  SettingsViewPresenterProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/21/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
protocol SettingsViewPresenterProtocol: AnyObject {
   init(view: SettingsViewProtocol)
    func showError(error: Error)
    func showSuccess(success: String)
}
