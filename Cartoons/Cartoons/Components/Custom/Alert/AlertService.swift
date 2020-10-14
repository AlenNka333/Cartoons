//
//  AlertService.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/25/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class AlertService {    
    func alert(title: String, body: String, alertType: AlertType, completion: ((BTAction) -> Void)? = nil) -> CustomAlertView {
        let alertVC = CustomAlertView(nibName: Constants.alertClassName, bundle: .main)
        alertVC.alertTitle = title
        alertVC.alertBody = body
        alertVC.alertType = alertType
        alertVC.buttonAction = completion
        alertVC.modalPresentationStyle = .overFullScreen
        return alertVC
    }
}
