//
//  UserDataManager.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/9/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol UserDataServiceProtocol {
    var userId: String? { get }
    var userPhoneNumber: String? { get }
}
