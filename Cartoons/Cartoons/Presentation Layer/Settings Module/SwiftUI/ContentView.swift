//
//  ContentView.swift
//  SwiftUIRefactoring
//
//  Created by Alena Nesterkina on 11/12/20.
//

import SwiftUI
import UIKit

class SettingsViewHostingController: UIHostingController<ContentView> {
    weak var transitionDelegate: SettingsTransitionDelegate?
    var presenter: SettingsViewPresenterProtocol?
    
    init() {
        super.init(rootView: ContentView())
        rootView.signOutClosure = signOut
        rootView.clearCacheClosure = clearCache
        title = R.string.localizable.settings_screen()
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingsViewHostingController {
    func signOut() {
        guard let presenter = self.presenter else {
            return
        }
        presenter.signOut()
    }
    
    func clearCache() {
        guard let presenter = self.presenter else {
            return
        }
        presenter.askPermission()
    }
}

extension SettingsViewHostingController: SettingsViewProtocol {
    func transit() {
        transitionDelegate?.transit()
    }
    
    func showError(error: Error) {
        let alertVC = AlertService.alert(title: R.string.localizable.error(), body: error.localizedDescription, alertType: .error) {_ in
            return
        }
        present(alertVC, animated: true)
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
        //        imagePicker?.present { [weak self] result in
        //            switch result {
        //            case .success(let image):
        //                self?.didSelect(image: image)
        //            case .failure(let error):
        //                self?.presenter?.showPermissionsAlert(error: error)
        //            }
        //        }
    }
    
    func showProfileImage(path: URL?) {
        //        userInfoHeader.stopActivityIndicator()
        //        userInfoHeader.setProfileImage(path: path)
    }
    
    func showDefaultImage() {
        //        userInfoHeader.stopActivityIndicator()
        //        userInfoHeader.setDefaultImage()
    }
    
    func showPhoneLabel(number: String) {
        //        userInfoHeader.setPhoneNumber(number: number)
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

struct ContentView: View {
    @State private var clearCache: Bool = false
    @State private var signOut: Bool = false
    
    var signOutClosure: (() -> Void)?
    var clearCacheClosure: (() -> Void)?
    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white,
                                                      .font: R.font.aliceRegular(size: 40)
        ]
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = .white
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            CustomHeader()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100, alignment: .center)
            Button(action: {
                guard let closure = signOutClosure else {
                    return
                }
                closure()
            }) {
                Text("Sign Out")
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50, alignment: .center)
                    .foregroundColor(Color.white)
                    .font(Font.custom("Alice-Regular", size: 15))
                    .background(Color(R.color.table_cell.name))
                    .cornerRadius(8)
            }
            Button(action: {
                guard let closure = clearCacheClosure else {
                    return
                }
                closure()
            }) {
                Text("Clear Cache")
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50, alignment: .center)
                    .foregroundColor(Color.white)
                    .font(Font.custom("Alice-Regular", size: 15))
                    .background(Color(R.color.table_cell.name))
                    .cornerRadius(8)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        .padding(.top, 5)
        .background(Color(R.color.picotee_blue.name))
    }
}

struct CustomHeader: View {
    @State var phoneNumber = "+375298939122"
    var body: some View {
        VStack(spacing: 5) {
            Image("profile_icon")
                .resizable()
                .frame(width: 70, height: 70)
                .onTapGesture {
                    print("Change image")
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
            Text("\(phoneNumber)")
                .foregroundColor(.white)
                .font(Font.custom("Alice-Regular", size: 15))
            Spacer()
        }
    }
}

struct NavigationBarModifier: ViewModifier {
    var backgroundColor: UIColor?
    
    init( backgroundColor: UIColor?) {
        self.backgroundColor = backgroundColor
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                        .shadow(color: .black, radius: 3, x: 3, y: 3)
                    Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }
}
