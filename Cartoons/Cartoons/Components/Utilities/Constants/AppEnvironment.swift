//
//  Constants.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/7/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

enum AppEnvironment {
    enum Firebase {
        static let verificationId: String = "firebase_verification"
        static let moviesParam: String = "movies"
        static let firstComing: String = "first_coming"
    }
    enum Classes {
        static let alertClassName: String = "AlertView"
        static let labelClassName: String = "LabelView"
        static let profileClassName: String = "ProfileView"
        static let controlsClassName: String = "PlayerControlsView"
    }
}
