//
//  SettingsViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/21/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Kingfisher
import UIKit

class SettingsViewController: BaseViewController {
    var presenter: SettingsViewPresenterProtocol?
    var imagePicker: ImagePicker?
    
    private lazy var signOutButton: UIButton = CustomButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = ImagePicker(presentationController: self)
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = R.string.localizable.settings_screen()
        (navigationController as? BaseNavigationController)?.setProfileImage(image: UIImage())
        (navigationController as? BaseNavigationController)?.showActivityIndicator()
        presenter?.showProfileImage()
        (navigationController as? BaseNavigationController)?.imageAction = { [weak self] in
            self?.presenter?.editProfileImage()
        }
    }
    
    override func setupUI() {
        super.setupUI()
        view.backgroundColor = R.color.main_pink()
        view.addSubview(signOutButton)
        signOutButton.setTitle(R.string.localizable.sign_out_button(), for: .normal)
        signOutButton.addTarget(self, action: #selector(buttonTappedToSignOutAction), for: .touchUpInside)
        signOutButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func showError(error: Error) {
        super.showError(error: error)
    }
}

extension SettingsViewController: SettingsViewProtocol {
    func showPermissionAlert(message: String) {
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
            case .success(let image):
                self?.didSelect(image: image)
            case .failure(let error):
                self?.presenter?.showPermissionsAlert(error: error)
            }
        }
    }
    
    func showProfileImage(path: URL?) {
        (navigationController as? BaseNavigationController)?.stopActivityIndicator()
        (navigationController as? BaseNavigationController)?.setProfileImage(path: path)
    }
    
    func showDefaultImage() {
        (navigationController as? BaseNavigationController)?.stopActivityIndicator()
        (navigationController as? BaseNavigationController)?.setDefaultImage(image: R.image.profile_icon())
    }
    
    func showPhoneLabel(number: String) {
        title = number
    }
    
    func showSignOutAlert(message: String) {
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
    
    func showSuccess(success: String) {
        let alertVC = alertService.alert(title: R.string.localizable.success(), body: success, alertType: .success)
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
