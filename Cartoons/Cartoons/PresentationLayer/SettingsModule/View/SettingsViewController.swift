//
//  SettingsViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/21/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

enum BTAction {
    case cancel
    case accept
}

class SettingsViewController: UIViewController {
    let alertService = AlertService()
    var presenter: SettingsViewPresenterProtocol?
    var imagePicker: ImagePicker!
    
    private lazy var signOutButton: UIButton = CustomButton()
    private lazy var customView: UIView = {
        view = UIView()
        view.backgroundColor = R.color.main_orange()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = R.string.localizable.settings_screen()
        (navigationController as? BaseNavigationController)?.setImage(image: R.image.profile_image(), isEnabled: true)
        (navigationController as? BaseNavigationController)?.imageAction = { [weak self] in
            self?.presenter?.editProfileImage()
        }
        imagePicker = ImagePicker(presentationController: self, delegate: self)
        setupUI()
    }
    
    override func loadView() {
        self.view = ownView
    }
    
    func setupUI() {
        view.addSubview(signOutButton)
        signOutButton.setTitle(R.string.localizable.sign_out_button(), for: .normal)
        signOutButton.addTarget(self, action: #selector(buttonTappedToSignOutAction), for: .touchUpInside)
        signOutButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension SettingsViewController: SettingsViewProtocol {
    func editProfileImage() {
        imagePicker.present()
    }
    
    func setPhoneLabel(number: String) {
        title = number
    }
    
    func setQuestion(question: String) {
        let alertVC = alertService.alert(title: "Wait...", body: question, alertType: .question) { [weak self] action in
            switch action {
                case .accept:
                    self?.presenter?.agreeButtonTapped()
                case .cancel:
                    break
                }
        }
        present(alertVC, animated: true)
    }
    
    func setSuccess(success: String) {
        let alertVC = alertService.alert(title: R.string.localizable.success(), body: success, alertType: .success)
        present(alertVC, animated: true)
    }
    
    func setError(error: Error) {
        let alertVC = alertService.alert(title: R.string.localizable.error(), body: error.localizedDescription, alertType: .error)
       present(alertVC, animated: true)
    }
    
    @objc func buttonTappedToSignOutAction() {
        guard let presenter = self.presenter else {
            return
        }
        presenter.signOut()
    }
}

extension SettingsViewController: ImagePickerDelegateProtocol {
    func didSelect(image: UIImage?) {
        (navigationController as? BaseNavigationController)?.setProfileImage(image: image)
        
    }
}
