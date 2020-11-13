//
//  ContentView.swift
//  SwiftUIRefactoring
//
//  Created by Alena Nesterkina on 11/12/20.
//
//swiftlint:disable all

import SwiftUI
import UIKit

class SettingsViewHostingController: UIHostingController<ContentView> {
    weak var transitionDelegate: SettingsTransitionDelegate?
    var presenter: SettingsViewPresenterProtocol? {
        didSet {
            presenter?.showProfileImage()
            presenter?.showPhoneNumber()
        }
    }
    
    init() {
        super.init(rootView: ContentView())
        rootView.signOutClosure = { [weak self] in
            self?.presenter?.signOut()
        }
        rootView.clearCacheClosure = { [weak self] in
            self?.presenter?.askPermission()
        }
        rootView.saveImageClosure = { [weak self] data in
            print("Save")
            self?.presenter?.saveProfileImage(imageData: data)
        }
        title = R.string.localizable.settings_screen()
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingsViewHostingController: SettingsViewProtocol {
    func showPhoneLabel(number: String) {
        rootView.number.number = number
    }
    
    func editProfileImage() {
    }
    
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
    
    func showProfileImage(path: URL?) {
        guard let path = path else {
            return
        }
        rootView.imageLoader.load(path)
    }
    
    func showDefaultImage() {
        rootView.image = Image(R.image.profile_icon.name)
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
    @ObservedObject var imageLoader: ImageLoader
    @ObservedObject var number: Number
    
    @State private var clearCache: Bool = false
    @State private var signOut: Bool = false
    
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionSheet = false
    @State private var shouldPresentCamera = false
    
    @State var image: Image? = Image(R.image.profile_icon.name)
    @State var imageData: Data?
    
    var signOutClosure: (() -> Void)?
    var clearCacheClosure: (() -> Void)?
    var saveImageClosure: ((Data) -> Void)?
    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white,
                                                      .font: R.font.aliceRegular(size: 40).unwrapped
        ]
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = .white
        
        self.imageLoader = ImageLoader()
        self.number = Number()
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            VStack(spacing: 5) {
                image?
                    .resizable()
                    .frame(width: 70, height: 70)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .onTapGesture { self.shouldPresentActionSheet = true }
                    .onReceive(imageLoader.didChange) { image in
                        self.image = Image(uiImage: image)
                    }
                    .sheet(isPresented: $shouldPresentImagePicker) {
                        SwiftUIImagePicker(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary,
                                           image: self.$image,
                                           isPresented: self.$shouldPresentImagePicker,
                                           imageData: self.$imageData.onUpdate {
                                            guard let closure = saveImageClosure,
                                                  let data = imageData else {
                                                return
                                            }
                                            closure(data)
                                           })
                    }
                    .actionSheet(isPresented: $shouldPresentActionSheet) { () -> ActionSheet in
                        ActionSheet(title: Text("Choose mode"),
                                    message: Text("Please choose your preferred mode to set your profile image"),
                                    buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                                        self.shouldPresentImagePicker = true
                                        self.shouldPresentCamera = true
                                    }),
                                    ActionSheet.Button.default(Text("Photo Library"), action: {
                                        self.shouldPresentImagePicker = true
                                        self.shouldPresentCamera = false
                                    }),
                                    ActionSheet.Button.cancel()])
                }
                Text(number.number)
                    .foregroundColor(.white)
                    .font(Font.custom("Alice-Regular", size: 18))
            }
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

//MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
