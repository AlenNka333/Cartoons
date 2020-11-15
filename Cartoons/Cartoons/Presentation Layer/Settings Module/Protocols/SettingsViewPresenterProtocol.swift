//
//  SettingsViewPresenterProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/21/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
protocol SettingsViewPresenterProtocol: PresenterProtocol, AnyObject {
    func signOut()
    func askPermission()
    func showError(error: Error)
    func showSuccess(success: String)
    func showPermissionsAlert(error: Error)
    func agreeButtonTapped()
    func editProfileImage()
    func showProfileImage()
    func saveProfileImage(imageData: Data)
    func showPhoneNumber()
    func checkCache() -> Bool
    func clearCache()
}
