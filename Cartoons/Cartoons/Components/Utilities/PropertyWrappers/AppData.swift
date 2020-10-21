//
//  AppData.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/14/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
struct AppData {
    @UserDefault(Constants.verificationId, defaultValue: "")
    static var verificationID: String
    
    @UserDefault(Constants.firstComing, defaultValue: true)
    static var shouldShowOnBoarding: Bool
}
