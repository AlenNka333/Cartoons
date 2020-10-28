//
//  MainScreenCoordinator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class MainScreenCoordinator: CoordinatorProtocol {
    let locator: Locator
    
    var parent: CoordinatorProtocol?
    var rootController: UIViewController
    var successSessionClosure: (() -> Void)?
    
    init(locator: Locator) {
        self.locator = locator
        self.rootController = UINavigationController()
    }
    
    func start() {
        rootController = MainScreenAssembly.makeTabBarController(locator: locator,
                                                                 completion: { [weak self] action, link in
                                                                    switch action {
                                                                    case .openPlayer:
                                                                        self?.openVideoPlayer(with: link)
                                                                    case .successSession:
                                                                        guard let closure = self?.successSessionClosure else {
                                                                            return
                                                                        }
                                                                        closure()
                                                                    }
                                                                 })
    }
    
    func openVideoPlayer(with link: URL?) {
        let view = PlayerAssembly.makePlayerController(with: link)
        ((rootController as? TabBarViewController)?.selectedViewController as? UINavigationController)?.pushViewController(view, animated: true)
    }
}
