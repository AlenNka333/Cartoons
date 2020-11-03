//
//  BaseViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/21/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, BaseViewProtocol {
    let alertView = CustomAlertViewController()
    let activityIndicator = UIActivityIndicatorView()
    let alertService = AlertService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    func setupUI() {
    }
    
    func setupNavigationBar() {
    }
    
    func showError(error: Error) {
        let alertVC = alertService.alert(title: R.string.localizable.error(), body: error.localizedDescription, alertType: .error) {_ in
            return
        }
        present(alertVC, animated: true)
    }
    
    func showActivityIndicator() {
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
}
