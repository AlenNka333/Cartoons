//
//  OnboardingCoordinator.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class OnboardingCoordinator: Coordinator {
    var parent: UINavigationController?
    var rootController: UIViewController
    var successSessionClosure: (() -> Void)?
    
    init() {
        self.rootController = UIViewController()
    }
    
    func start() {
        rootController = OnboardingAssembly.makeOnboardingController()
        guard let view = (rootController as? PageViewController) else {
            return
        }
        let presenter = PageControllerPresenter(view: view)
        presenter.successSessionClosure = { [weak self] in
            self?.successSessionClosure?()
        }
        (rootController as? PageViewController)?.presenter = presenter
    }
}
