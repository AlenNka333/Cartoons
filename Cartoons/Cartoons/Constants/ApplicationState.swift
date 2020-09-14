//
//  AppState.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/14/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

enum ApplicationState {
    case firstTime
    // onBoarding -> auth -> mainScreen
    case authorized
    //mainScreen
    case notAuthorized
    // auth -> mainScreen
}
