//
//  CartoonsViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/10/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import FirebaseAuth
import UIKit

class CartoonsViewController: UIViewController {
    var presenter: CartoonsViewPresenterProtocol!
    
    private lazy var signOutButton: UIButton = {
        let button = UIButton()
        let string = NSAttributedString(string: R.string.localizable.sign_out_button(),
                                        attributes: [NSAttributedString.Key.font:
                                            UIFont.systemFont(ofSize: 18),
                                                     .foregroundColor: UIColor.white])
        let attributedString = NSMutableAttributedString(attributedString: string)
        button.setAttributedTitle(attributedString, for: .normal)
        button.isEnabled = true
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.layer.borderColor = R.color.enabled_button()?.cgColor
        button.addTarget(self, action: #selector(self.buttonTappedToSignOutAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(signOutButton)
        signOutButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(50)
            $0.center.equalToSuperview()
        }
    }
}

extension CartoonsViewController: CartoonsViewProtocol {
}

extension CartoonsViewController {
    @objc func buttonTappedToSignOutAction() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            CustomAlertView.instance.showAlert(title: R.string.localizable.sign_out_button(), message: R.string.localizable.success(), alertType: .success)
        } catch {
          CustomAlertView.instance.showAlert(title: R.string.localizable.sign_out_button(), message: error.localizedDescription, alertType: .error)
        }
    }
}