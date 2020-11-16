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
            cacheUpdated(presenter?.checkCache() ?? true)
        }
    }
    
    init() {
        super.init(rootView: ContentView())
        rootView.signOutClosure = { [weak self] in
            self?.presenter?.signOut()
        }
        rootView.clearCacheClosure = { [weak self] in
            guard let presenter = self?.presenter else {
                return
            }
            if presenter.checkCache() {
                self?.presenter?.askPermission()
            }
        }
        rootView.saveImageClosure = { [weak self] data in
            self?.presenter?.saveProfileImage(imageData: data)
        }
        setupUI()
    }
    
    func setupUI() {
        title = R.string.localizable.settings_screen()
        view.backgroundColor = R.color.picotee_blue()
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingsViewHostingController: SettingsViewProtocol {
    func cacheUpdated(_ flag: Bool) {
        rootView.cacheIndicator.flag = !flag
    }
    
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
    @ObservedObject var cacheIndicator: CacheIndicator
    
    @State private var clearCache: Bool = false
    @State private var signOut: Bool = false
    
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionSheet = false
    @State private var shouldPresentCamera = false
    
    @State var image: Image = Image(uiImage: R.image.profile_icon().unwrapped)
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
        self.cacheIndicator = CacheIndicator()
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            VStack(spacing: 5) {
                imageLoader.image
                    .resizable()
                    .clipShape(Circle())
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .aspectRatio(contentMode: .fill)
                    .shadow(radius: 10)
                    .onTapGesture { self.shouldPresentActionSheet = true }
                    .sheet(isPresented: $shouldPresentImagePicker) {
                        SwiftUIImagePicker(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary,
                                           image: self.$image,
                                           isPresented: self.$shouldPresentImagePicker,
                                           imageData: self.$imageData.onUpdate {
                                            imageLoader.image = image
                                            guard let closure = saveImageClosure,
                                                  let data = imageData else {
                                                return
                                            }
                                            closure(data)
                                           })
                            .edgesIgnoringSafeArea(.all)
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
            .disabled(cacheIndicator.flag)
        }
        .padding(.top, 5)
        .edgesIgnoringSafeArea(.bottom)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        .background(Color(R.color.picotee_blue.name))
    }
}

//MARK: - Preview
#if DEBUG
struct ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
