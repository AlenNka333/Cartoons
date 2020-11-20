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
    let transitioningManager = PresentationManager()
    
    weak var transitionDelegate: SettingsTransitionDelegate?
    var presenter: SettingsViewPresenterProtocol? {
        didSet {
            presenter?.getUserProfileImage()
            presenter?.showUserPhoneNumber()
            cacheSizeChanged(presenter?.checkCacheIsEmpty() ?? true)
        }
    }
    
    init() {
        super.init(rootView: ContentView())
        setupUI()
        rootView.signOutClosure = { [weak self] in
            self?.presenter?.signOut()
        }
        rootView.clearCacheClosure = { [weak self] in
            guard let presenter = self?.presenter else {
                return
            }
            if presenter.checkCacheIsEmpty() {
                self?.presenter?.clearCache()
            } else {
                self?.presenter?.showMessage(message: R.string.localizable.empty_cache())
            }
        }
        rootView.saveImageClosure = { [weak self] data in
            self?.presenter?.saveUserProfileImage(imageData: data)
        }
    }
    
    func setupUI() {
        title = R.string.localizable.settings_screen()
        view.backgroundColor = .black
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingsViewHostingController: SettingsViewProtocol {
    func cacheSizeChanged(_ flag: Bool) {
        rootView.cacheIndicator.flag = !flag
    }
    
    func showUserPhoneNumber(phoneNumber: String) {
        rootView.number.number = phoneNumber
    }
    
    func transit() {
        transitionDelegate?.transit()
    }
    
    func showError(error: Error) {
        let alertVC = AlertService.alert(title: R.string.localizable.error(), body: error.localizedDescription, alertType: .error) {_ in
            return
        }
        alertVC.transitioningDelegate = transitioningManager
        alertVC.modalPresentationStyle = .custom
        present(alertVC, animated: true)
    }
    
    func showMessage(message: String) {
        let alertVC = AlertService.alert(title: R.string.localizable.choice_alert_title(), body: message, alertType: .success) { _ in
            return
        }
        alertVC.transitioningDelegate = transitioningManager
        alertVC.modalPresentationStyle = .custom
        present(alertVC, animated: true)
    }
    
    func showPermissionAlert(message: String, completion: @escaping ((Bool) -> Void)) {
        let alertVC = AlertService.alert(title: R.string.localizable.choice_alert_title(), body: message, alertType: .permission) {
            switch $0 {
            case .accept:
                completion(true)
            case .cancel:
                completion(false)
            }
        }
        alertVC.transitioningDelegate = transitioningManager
        alertVC.modalPresentationStyle = .custom
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
    @State private var fadeOut = false
    @State private var logoImage = ImageEnum.img1
    
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
                    .padding(.top, 10)
                    .clipShape(Circle())
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .aspectRatio(contentMode: .fill)
                    .shadow(radius: 10)
                    .onTapGesture {
                        self.shouldPresentActionSheet = true
                    }
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
                        ActionSheet(title: Text(R.string.localizable.choose_mode()),
                                    message: Text(R.string.localizable.choose_mode_message()),
                                    buttons: [ActionSheet.Button.default(Text(R.string.localizable.camera()), action: {
                                        self.shouldPresentImagePicker = true
                                        self.shouldPresentCamera = true
                                    }),
                                    ActionSheet.Button.default(Text(R.string.localizable.photo_library()), action: {
                                        self.shouldPresentImagePicker = true
                                        self.shouldPresentCamera = false
                                    }),
                                    ActionSheet.Button.cancel()])
                        
                    }
                Text(number.number)
                    .foregroundColor(.white)
                    .font(Font.custom(R.font.aliceRegular.fontName, size: 18))
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100, alignment: .center)
            Button(action: {
                guard let closure = signOutClosure else {
                    return
                }
                closure()
            }) {
                Text(R.string.localizable.sign_out_button())
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50, alignment: .center)
                    .foregroundColor(Color.white)
                    .font(Font.custom(R.font.aliceRegular.fontName, size: 15))
                    .background(Color(R.color.downriver.name))
                    .cornerRadius(8)
            }
            Button(action: {
                guard let closure = clearCacheClosure else {
                    return
                }
                closure()
            }) {
                Text(R.string.localizable.clear_cache())
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50, alignment: .center)
                    .foregroundColor(Color.white)
                    .font(Font.custom(R.font.aliceRegular.fontName, size: 15))
                    .background(Color(R.color.downriver.name))
                    .cornerRadius(8)
            }
            Image(logoImage.localizedText)
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.white)
                .frame(width: 150, height: 150, alignment: .center)
                .padding(.top, 60)
                .opacity(fadeOut ? 0 : 1)
                .animation(.easeInOut(duration: 0.25))
                .onTapGesture {
                    self.fadeOut.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        withAnimation {
                            self.logoImage = self.logoImage.next()
                            self.fadeOut.toggle()
                        }
                    }
                }
            
        }
        .padding(.top, 5)
        .edgesIgnoringSafeArea(.bottom)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        .background(Color( R.color.terracotta.name))
    }
}

enum ImageEnum: String {
    case img1
    case img2
    
    var localizedText: String {
        switch self {
        case .img1: return R.image.back_label.name
        case .img2: return R.image.back_color_label.name
        }
    }
    
    func next() -> ImageEnum {
        switch self {
        case .img1: return .img2
        case .img2: return .img1
        }
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
