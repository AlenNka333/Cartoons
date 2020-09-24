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
    
    private lazy var signOutButton: UIButton = CustomButton()
    private lazy var ownView: UIView = {
        view = UIView()
        view.backgroundColor = R.color.main_orange()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupUi()
    }
    
    func setupUi() {
//        view.addSubview(signOutButton)
//        signOutButton.setTitle(R.string.localizable.sign_out_button(), for: .normal)
//        signOutButton.addTarget(self, action: #selector(buttonTappedToSignOutAction), for: .touchUpInside)
//        signOutButton.snp.makeConstraints {
//            $0.center.equalToSuperview()
//        }
        let profile = ProfileView()
        profile.delegate = self
        profile.setPhone(phone: "phone")
        view.addSubview(profile)
        profile.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
    override func loadView() {
        self.view = ownView
    }
}

extension SettingsViewController: SettingsViewProtocol {
    func setQuestion(question: String) {
        CustomAlertView.instance.showAlert(title: "Wait...", message: question, alertType: .question)
    }
    
    func setSuccess(success: String) {
        CustomAlertView.instance.showAlert(title: success, message: "", alertType: .success)
    }
    func setError(error: Error) {
        CustomAlertView.instance.showAlert(title: R.string.localizable.error(), message: error.localizedDescription, alertType: .error)
    }
    @objc func buttonTappedToSignOutAction() {
        guard let presenter = self.presenter else {
            return
        }
        presenter.signOut()
    }
}

extension SettingsViewController: ProfileViewDelegate {
    func changeProfileImageTapped() {
        CustomAlertView.instance.showAlert(title: "Success", message: "", alertType: .success)
    }
}

