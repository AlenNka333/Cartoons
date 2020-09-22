//
//  FavouritesViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/21/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit
class FavouritesViewController: UIViewController {
    var presenter: FavouritesViewPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.main_background()
        title = R.string.localizable.favourites_screen()
        navigationController?.setSubTitle(title: R.string.localizable.favourites_screen_subtitle())
        navigationController?.setImageView(image: R.image.navigation_label())
    }
}

extension FavouritesViewController: FavouritesViewProtocol {
    func setSuccess(success: String) {
        CustomAlertView.instance.showAlert(title: success, message: "", alertType: .success)
    }
    func setError(error: Error) {
        CustomAlertView.instance.showAlert(title: R.string.localizable.error(), message: error.localizedDescription, alertType: .error)
    }
}
