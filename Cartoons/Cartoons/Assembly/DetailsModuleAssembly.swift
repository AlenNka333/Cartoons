//
//  DetailsAssembly.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/23/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

class DetailsModuleAssembly: Assembly {
    static func makeDetailsController(with video: Cartoon, serviceLocator: Locator) -> DetailsViewController {
        let view = DetailsViewController()
        let presenter = DetailsPresenter(view: view, video: video, serviceLocator: serviceLocator)
        view.presenter = presenter
        return view
    }
}
