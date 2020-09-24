//
//  SettingsViewProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/21/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
protocol SettingsViewProtocol: AnyObject {
    func setError (error: Error)
    func setSuccess(success: String)
    func setQuestion(question: String)
}
