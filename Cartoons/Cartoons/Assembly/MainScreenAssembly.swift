//
//  MainScreenAssembly.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

enum Action {
    case openDetails
    case successSession
}

class MainScreenAssembly: Assembly {
    static func makeMainScreenCoordinator() -> MainScreenCoordinator {
        return MainScreenCoordinator()
    }
}
