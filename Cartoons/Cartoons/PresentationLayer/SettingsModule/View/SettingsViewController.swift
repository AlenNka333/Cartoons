//
//  SettingsViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/21/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    var presenter: SettingsViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}

extension SettingsViewController: SettingsViewProtocol {
    func setSuccess(success: String) {
        CustomAlertView.instance.showAlert(title: success, message: "", alertType: .success)
    }
    func setError(error: Error) {
        CustomAlertView.instance.showAlert(title: R.string.localizable.error(), message: error.localizedDescription, alertType: .error)
    }
}
