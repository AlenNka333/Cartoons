//
//  UIViewControllerExtension.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/4/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(with error: Error, title: [String] = ["Ok", "Cancel"], header: String) {
        let alert = UIAlertController(title: header, message: error.localizedDescription, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: title[0], style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: title[1], style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
    func setupToHideKeyboardOnTapOnView()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
