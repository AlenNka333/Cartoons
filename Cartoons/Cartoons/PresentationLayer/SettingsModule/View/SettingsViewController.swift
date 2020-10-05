//
//  SettingsViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/21/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Kingfisher
import UIKit

enum BTAction {
    case cancel
    case accept
}

class SettingsViewController: UIViewController {
    let alertService = AlertService()
    var presenter: SettingsViewPresenterProtocol?
    var imagePicker: ImagePicker?
    
    private lazy var signOutButton: UIButton = CustomButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = ImagePicker(presentationController: self)
        setupNavigationController()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor(patternImage: R.image.main_background().unwrapped)
    }
    
    func setupNavigationController() {
        title = R.string.localizable.settings_screen()
        presenter?.showProfileImage()
        (navigationController as? BaseNavigationController)?.imageAction = { [weak self] in
            self?.presenter?.editProfileImage()
        }
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
    func setPermissionAlert(message: String) {
        let alertVC = alertService.alert(title: R.string.localizable.choice_alert_title(), body: message, alertType: .permission) {
            switch $0 {
                case .accept:
                    guard let url = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                case .cancel:
                    break
                }
        }
        present(alertVC, animated: true)
    }
    
    func editProfileImage() {
        imagePicker?.present { [weak self] result in
            switch result {
                case .failure(let error):
                    self?.presenter?.showPermissionsAlert(error: error)
            case .success(let image):
                self?.didSelect(image: image)
            }
        }
    }
    
    func setProfileImage(path: URL) {
        (navigationController as? BaseNavigationController)?.setProfileImage(path: path)
    }
    
    func setPhoneLabel(number: String) {
        title = number
    }
    
    func setSignOutAlert(message: String) {
        let alertVC = alertService.alert(title: R.string.localizable.choice_alert_title(), body: message, alertType: .question) { [weak self] action in
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
}

extension SettingsViewController {
    func didSelect(image: UIImage?) {
        guard let image = image else {
            return
        }
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            return
        }
        presenter?.saveProfileImage(imageData: imageData)
        (navigationController as? BaseNavigationController)?.setProfileImage(image: image)
    }
    
    @objc func buttonTappedToSignOutAction() {
        guard let presenter = self.presenter else {
            return
        }
        presenter.signOut()
    }
}
