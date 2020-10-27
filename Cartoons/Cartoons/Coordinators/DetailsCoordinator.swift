//
//  DetailsCoordinator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/27/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

class DetailsCoordinator: Coordinator {
    var parent: Coordinator?
    
    private var window: UIWindow? {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    }
    var navigationController: UINavigationController
    var successSessionClosure: (() -> Void)?
    var cartoon: Cartoon
    
    init(parent: UINavigationController, movie: Cartoon) {
        self.cartoon = movie
        self.navigationController = UINavigationController()
    }
    
    func start() {
        guard let window = window else {
            return
        }
        let detailsController = DetailsAssembly.makeDetailsController(with: cartoon) { [weak self] url in
            self?.openVideoPlayer(with: url)
        }
        navigationController.pushViewController(detailsController, animated: true)
        window.rootViewController = navigationController
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}

extension DetailsCoordinator {
    func openVideoPlayer(with link: URL?) {
        let view = PlayerAssembly.makePlayerController(with: link)
        navigationController.pushViewController(view, animated: true)
    }
}
