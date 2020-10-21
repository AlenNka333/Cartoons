//
//  ViewProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/6/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol BaseViewProtocol {
    func viewDidLoad()
    func viewWillAppear(_ animated: Bool)
    func setupUI()
    func setupNavigationBar()
    func showError(error: Error)
    func showActivityIndicator()
    func stopActivityIndicator()
}
