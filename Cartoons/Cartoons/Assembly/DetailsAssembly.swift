//
//  DetailsAssembly.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/23/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

class DetailsAssembly: Assembly {
    static func makeDetailsCoordinator(parent: UINavigationController, movie: Cartoon) -> DetailsCoordinator {
        DetailsCoordinator(parent: parent, movie: movie)
    }
    
    static func makeDetailsController(with video: Cartoon, completion: @escaping((URL) -> Void)) -> UIViewController {
        let view = DetailsViewController()
        let presenter = DetailsPresenter(view: view, video: video)
        presenter.openPlayerClosure = completion
        view.presenter = presenter
        return view
    }
}
