//
//  UserDataService.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/9/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

class UserDataService: UserDataServiceProtocol {
    private let userDataManager = UserDataManager()
    
    var userId: String? {
        userDataManager.userId
    }
    var userPhoneNumber: String? {
        userDataManager.getUserPhoneNumber()
    }
    
    func getLoadedFiles() {
        
    }
}
