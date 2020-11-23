//
//  AppData.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/14/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
struct AppData {
    @UserDefault(AppEnvironment.Firebase.verificationId, defaultValue: "")
    static var verificationID: String
    
    @UserDefault(AppEnvironment.Firebase.firstComing, defaultValue: true)
    static var shouldShowOnBoarding: Bool
}
