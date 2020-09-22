//
//  CartoonsViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/10/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class CartoonsViewController: UIViewController {
    var presenter: CartoonsViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = R.color.main_background()
        title = R.string.localizable.cartoons_screen()
        navigationController?.setSubTitle(title: R.string.localizable.cartoons_screen_subtitle())
        navigationController?.setImageView(image: R.image.navigation_label())
    }
}

extension CartoonsViewController: CartoonsViewProtocol {
    func setSuccess(success: String) {
        CustomAlertView.instance.showAlert(title: success, message: "", alertType: .success)
    }
    func setError(error: Error) {
        CustomAlertView.instance.showAlert(title: R.string.localizable.error(), message: error.localizedDescription, alertType: .error)
    }
}
