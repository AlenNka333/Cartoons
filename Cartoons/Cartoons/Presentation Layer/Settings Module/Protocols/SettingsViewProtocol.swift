//
//  SettingsViewProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/21/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol SettingsViewProtocol: SettingsTransitionDelegate {
    func showUserPhoneNumber(phoneNumber: String)
    func showPermissionAlert(message: String, completion: @escaping((Bool) -> Void))
    func showProfileImage(path: URL?)
    func showDefaultImage()
    func showError(error: Error)
    func cacheSizeChanged(_ flag: Bool)
}
