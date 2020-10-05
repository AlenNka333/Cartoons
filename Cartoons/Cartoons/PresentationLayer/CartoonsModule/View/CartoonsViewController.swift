//
//  CartoonsViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/10/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class CartoonsViewController: UIViewController {
    var presenter: CartoonsViewPresenterProtocol?
    let alertService = AlertService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        //view.backgroundColor = R.color.main_background()
        title = R.string.localizable.cartoons_screen()
        (navigationController as? BaseNavigationController)?.setSubTitle(title: R.string.localizable.cartoons_screen_subtitle())
        (navigationController as? BaseNavigationController)?.setImage(image: R.image.navigation_label(), isEnabled: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = UIColor(patternImage: R.image.main_screen_background().unwrapped)
    }
}

extension CartoonsViewController: CartoonsViewProtocol {
    func setSuccess(success: String) {
        let alertVC = alertService.alert(title: R.string.localizable.success(), body: success, alertType: .success) {_ in
            return
        }
        present(alertVC, animated: true)
    }
    func setError(error: Error) {
        let alertVC = alertService.alert(title: R.string.localizable.error(), body: error.localizedDescription, alertType: .error) {_ in
            return
        }
        present(alertVC, animated: true)
    }
}
