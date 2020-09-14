//
//  CheckApplicationStateHelper.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/14/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

class CheckApplicationStateHelper {
    static func checkState() -> ApplicationState {
        if AppData.isFirstComing {
            return ApplicationState.firstTime
        } else {
            let firebaseManager = FirebaseManager()
            switch firebaseManager.shouldAuthorize {
            case true:
                return ApplicationState.notAuthorized
            case false:
                return ApplicationState.authorized
            }
        }
    }
}
