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
    typealias DataSource = UITableViewDiffableDataSource<Section, Setting>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, Setting>
    
    private lazy var dataSource = makeDataSource()
    
    weak var transitionDelegate: SettingsTransitionDelegate?
    var presenter: SettingsViewPresenterProtocol?
    var imagePicker: ImagePicker?
    var tableView: UITableView?
    var userInfoHeader = UserInfoHeader()
    
    var snapshot = SnapShot()
    var settings = Setting.allSettings
    
    private lazy var appearance: UINavigationBarAppearance = {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = R.color.navigation_bar_color()
        appearance.largeTitleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.white,
                                                NSAttributedString.Key.font: R.font.aliceRegular(size: 40).unwrapped]
        appearance.shadowColor = .black
        return appearance
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = ImagePicker(presentationController: self)
        setupTableView()
        applySnapshot()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = R.string.localizable.settings_screen()
    }
    
    override func setupUI() {
        super.setupUI()
        view.backgroundColor = R.color.main_pink()
    }
    
    override func showError(error: Error) {
        super.showError(error: error)
    }
}

// MARK: - Protocol realisation

extension SettingsViewController: SettingsViewProtocol {
    func cacheUpdated(_ flag: Bool) {
        let cell = tableView?.cellForRow(at: IndexPath(item: 1, section: 0)) as? SettingsTableViewCell
        cell?.button.isEnabled = flag
        tableView?.reloadData()
    }
    
    func transit() {
        transitionDelegate?.transit()
    }
    
    func showPermissionAlert(message: String) {
        let alertVC = AlertService.alert(title: R.string.localizable.choice_alert_title(), body: message, alertType: .permission) {
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
        userInfoHeader.stopActivityIndicator()
        userInfoHeader.setProfileImage(path: path)
    }
    
    func showDefaultImage() {
        userInfoHeader.stopActivityIndicator()
        userInfoHeader.setDefaultImage()
    }
    
    func showPhoneLabel(number: String) {
        userInfoHeader.setPhoneNumber(number: number)
    }
    
    func showSignOutAlert(message: String) {
        let alertVC = AlertService.alert(title: R.string.localizable.choice_alert_title(), body: message, alertType: .question) { [weak self] action in
            switch action {
            case .accept:
                self?.presenter?.agreeButtonTapped()
            case .cancel:
                break
            }
        }
        present(alertVC, animated: true)
    }
    
    func showClearCachePermissionAlert(message: String) {
        let alertVC = AlertService.alert(title: R.string.localizable.choice_alert_title(), body: message, alertType: .question) { [weak self] action in
            switch action {
            case .accept:
                let cell = self?.tableView?.cellForRow(at: IndexPath(item: 1, section: 0)) as? SettingsTableViewCell
                cell?.button.isEnabled = false
                self?.tableView?.reloadData()
                self?.presenter?.clearCache()
            case .cancel:
                break
            }
        }
        present(alertVC, animated: true)
    }
    
    func showSuccess(success: String) {
        let alertVC = AlertService.alert(title: R.string.localizable.success(), body: success, alertType: .success)
        present(alertVC, animated: true)
    }
}

// MARK: - TableViewDiffableDataSource

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension SettingsViewController {
    func setupTableView() {
        tableView = UITableView(frame: self.view.frame)
        view.addSubview(tableView ?? UITableView())
        tableView?.register(SettingsTableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView?.delegate = self
        tableView?.backgroundColor = R.color.main_blue()
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
        userInfoHeader.frame = frame
        tableView?.tableHeaderView = userInfoHeader
        
        userInfoHeader.showActivityIndicator()
        presenter?.showProfileImage()
        userInfoHeader.imageAction = { [weak self] in
            self?.presenter?.editProfileImage()
        }
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        snapshot = SnapShot()
        snapshot.appendSections([.main])
        snapshot.appendItems(settings)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(tableView: tableView ?? UITableView()) { tableView, indexPath, _ -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SettingsTableViewCell
            cell?.setButtonText(string: self.settings[indexPath.row].title)
            if indexPath.row == 0 {
                cell?.button.addTarget(self, action: #selector(self.buttonTappedToSignOutAction), for: .touchUpInside)
            } else if indexPath.row == 1 {
                cell?.button.addTarget(self, action: #selector(self.clearCache), for: .touchUpInside)
            }
            return cell
        }
        return dataSource
    }
    
    @objc func buttonTappedToSignOutAction() {
        guard let presenter = self.presenter else {
            return
        }
        presenter.signOut()
    }
    
    @objc func clearCache() {
        guard let presenter = self.presenter else {
            return
        }
        if presenter.checkCache() {
            presenter.askPermission()
        }
    }
    
    func didSelect(image: UIImage?) {
        guard let image = image else {
            return
        }
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            return
        }
        presenter?.saveProfileImage(imageData: imageData)
        userInfoHeader.setProfileImage(image: image)
    }
}
