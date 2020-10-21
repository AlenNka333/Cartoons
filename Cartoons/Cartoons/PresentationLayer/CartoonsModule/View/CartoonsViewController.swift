//
//  CartoonsViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/10/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class CartoonsViewController: BaseViewController {
    var presenter: CartoonsViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = R.string.localizable.cartoons_screen()
        (navigationController as? BaseNavigationController)?.setSubTitle(title: R.string.localizable.cartoons_screen_subtitle())
        (navigationController as? BaseNavigationController)?.setImage(image: R.image.navigation_label(), isEnabled: false)
    }
    
    override func setupUI() {
        super.setupUI()
        view.backgroundColor = R.color.main_orange()
    }
    
    override func showError(error: Error) {
        super.showError(error: error)
    }
}

extension CartoonsViewController: CartoonsViewProtocol {
    func showSuccess(success: String) {
        let alertVC = alertService.alert(title: R.string.localizable.success(), body: success, alertType: .success) {_ in
            return
        }
        present(alertVC, animated: true)
    }
}
