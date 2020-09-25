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

    let alertService = AlertService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.main_background()
        title = R.string.localizable.favourites_screen()
        navigationController?.setSubTitle(title: R.string.localizable.favourites_screen_subtitle())
        navigationController?.setImage(image: R.image.favourites())
    }
}

extension FavouritesViewController: FavouritesViewProtocol {
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

