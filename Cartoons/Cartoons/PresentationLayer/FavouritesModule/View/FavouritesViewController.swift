//
//  FavouritesViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/21/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit
class FavouritesViewController: BaseViewController {
    var presenter: FavouritesViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = R.string.localizable.favourites_screen()
        (navigationController as? BaseNavigationController)?.setSubTitle(title: R.string.localizable.favourites_screen_subtitle())
        (navigationController as? BaseNavigationController)?.setImage(image: R.image.favourites(), isEnabled: false)
    }
    
    override func setupUI() {
        super.setupUI()
        view.backgroundColor = R.color.main_orange()
    }
    
    override func showError(error: Error) {
        super.showError(error: error)
    }
}

extension FavouritesViewController: FavouritesViewProtocol {
    func showSuccess(success: String) {
        let alertVC = alertService.alert(title: R.string.localizable.success(), body: success, alertType: .success) { _ in
            return
        }
        present(alertVC, animated: true)
    }
}
