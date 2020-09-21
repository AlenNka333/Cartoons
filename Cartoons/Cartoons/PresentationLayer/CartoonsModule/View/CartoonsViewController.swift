//
//  CartoonsViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/10/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class CartoonsViewController: UIViewController {
    private struct Const {
        static let ImageSizeForLargeState: CGFloat = 80
        static let ImageRightMargin: CGFloat = 16
        static let ImageBottomMarginForLargeState: CGFloat = 12
        static let ImageBottomMarginForSmallState: CGFloat = 6
        static let ImageSizeForSmallState: CGFloat = 32
        static let NavBarHeightSmallState: CGFloat = 44
        static let NavBarHeightLargeState: CGFloat = 96.5
    }
    var presenter: CartoonsViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = R.color.main_background()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = R.string.localizable.cartoons_screen()
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = R.color.navigation_bar_color()
        appearance.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.topItem?.standardAppearance = appearance
        navigationController?.navigationBar.topItem?.compactAppearance = appearance
        navigationController?.navigationBar.topItem?.scrollEdgeAppearance = appearance
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        let imageView = UIImageView(image: R.image.navigation_label())
        navigationBar.addSubview(imageView)
        imageView.layer.cornerRadius = Const.ImageSizeForLargeState / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -Const.ImageRightMargin),
            imageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Const.ImageBottomMarginForLargeState),
            imageView.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
            ])
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
