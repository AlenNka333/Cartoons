//
//  SettingsViewProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/21/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol SettingsViewProtocol: BaseViewProtocol, AnyObject {
    func showPhoneLabel(number: String)
    func showSuccess(success: String)
    func showSignOutAlert(message: String)
    func showPermissionAlert(message: String)
    func showProfileImage(path: URL?)
    func showDefaultImage()
    func editProfileImage()
}
