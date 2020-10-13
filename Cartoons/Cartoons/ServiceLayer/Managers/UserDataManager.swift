//
//  UserDataManager.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/9/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Firebase
import Foundation

class UserDataManager {
    var userId: String? {
        Auth.auth().currentUser?.uid
    }
    
    func getUserPhoneNumber() -> String? {
        let firebaseUser = Auth.auth().currentUser
        return firebaseUser?.phoneNumber
    }
}
