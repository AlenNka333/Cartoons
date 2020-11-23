//
//  BaseViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/6/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, ViewProtocol {
    let alertView = CustomAlertView()
    let activityIndicator = UIActivityIndicatorView()
    let alertService = AlertService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        activityIndicator.removeFromSuperview()
    }    
}
