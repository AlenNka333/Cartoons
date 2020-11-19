//
//  SettingsViewPresenterProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/21/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
protocol SettingsViewPresenterProtocol: AnyObject {
    func signOut()
    func clearCache()
    func getUserProfileImage()
    func showUserPhoneNumber()
    func checkCacheIsEmpty() -> Bool
    func showError(error: Error)
    func saveUserProfileImage(imageData: Data)
}
