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
    
    var child: UIViewController?
    var parent: CoordinatorProtocol?
    var rootController: UIViewController
    var successSessionClosure: (() -> Void)?
    
    init(number: String) {
        self.number = number
        self.rootController = UINavigationController()
    }
    
    func setChild(_ controller: UIViewController?) {
        if child != nil {
            removeChild()
        }
        child = controller
    }
    
    func removeChild() {
        guard child != nil else {
            return
        }
        self.child = nil
    }
    
    func start() {
        rootController = MainScreenAssembly.makeTabBarController(number: number,
                                                                 storageService: storageService,
                                                                 authorizationService: authorizationService,
                                                                 completion: { [weak self] action, video in
                                                                    switch action {
                                                                    case .openDetails:
                                                                        self?.openDetailsScreen(with: video)
                                                                    case .successSession:
                                                                        guard let closure = self?.successSessionClosure else {
                                                                            return
                                                                        }
                                                                        closure()
                                                                    }
                                                                 })
    }
    
    func openDetailsScreen(with video: Cartoon?) {
        guard let cartoon = video else {
            return
        }
        let view = DetailsAssembly.makeDetailsController(with: cartoon) { [weak self] url in
            self?.openVideoPlayer(with: url)
        }
        setChild(view)
        ((rootController as? TabBarViewController)?.selectedViewController as? UINavigationController)?.pushViewController(view, animated: true)
    }
    
    func openVideoPlayer(with link: URL?) {
        let view = PlayerAssembly.makePlayerController(with: link)
        (child as? UINavigationController)?.pushViewController(view, animated: true)
    }
}
