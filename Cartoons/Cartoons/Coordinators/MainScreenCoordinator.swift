//
//  MainScreenCoordinator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class MainScreenCoordinator: CoordinatorProtocol {
    let number: String
    let storageService = StorageDataService()
    let authorizationService = AuthorizationService()
    
    var parent: CoordinatorProtocol?
    var root: UIViewController
    var successSessionClosure: () -> Void = {}
    
    init(number: String) {
        self.number = number
        self.root = UINavigationController()
    }
    
    func start() {
        root = MainScreenAssembly.makeTabBarController(number: number,
                                                       storageService: storageService,
                                                       authorizationService: authorizationService,
                                                       completion: { [weak self] action in
                                                        switch action {
                                                        case .openPlayer:
                                                            self?.openVideoPlayer()
                                                        case .successSession:
                                                            self?.successSessionClosure()
                                                        }
        })
    }
    
    func openVideoPlayer() {
        let view = PlayerAssembly.makePlayerController()
        ((root as? TabBarViewController)?.selectedViewController as? UINavigationController)?.pushViewController(view, animated: true)
    }
}
