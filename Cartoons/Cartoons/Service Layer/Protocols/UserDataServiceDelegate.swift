//
//  UserDatdServiceDelegate.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 11/3/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol UserDataServiceDelegate: AnyObject {
    func filesUpdated(_ cartoon: Cartoon)
}
