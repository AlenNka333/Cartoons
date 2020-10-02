//
//  AuthorizationPresenterTests.swift
//  CartoonsTests
//
//  Created by Alena Nesterkina on 10/2/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//
//swiftlint:disable all

@testable import Cartoons
import XCTest

class MockView: AuthorizationViewProtocol {
    
    var phoneTest: String = "+375298939122"
    
    func setError(error: Error) {
        <#code#>
    }
    
    func showActivityIndicatorAction() {
        <#code#>
    }
    
    func stopActivityIndicatorAction() {
        <#code#>
    }
    
}

class MockRouter: RouterProtocol {
    func start() {
        <#code#>
    }
    
    func changeRootViewController(with rootViewController: UIViewController) {
        <#code#>
    }
    
    func showOnBoarding(firebaseManager: FirebaseManager) {
        <#code#>
    }
    
    func showAuthorizationController(firebaseManager: FirebaseManager) {
        <#code#>
    }
    
    func showOTPController(verificationId: String, firebaseManager: FirebaseManager, number: String, animated: Bool) {
        <#code#>
    }
    
    func showTabBarController(firebaseManager: FirebaseManager, number: String) {
        <#code#>
    }
    
    func popToRoot(animated: Bool) {
        <#code#>
    }
    
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    var navigationController: BaseNavigationController?
    
    var onBoarding: UIPageViewController?
    
    var tabBarController: UITabBarController?
    
    
}

class MockFirebaseManager: FirebaseManager {
    
}


class AuthorizationPresenterTests: XCTestCase {

    var view: MockView!
    var router: MockRouter!
    var manager: MockFirebaseManager!
    var firebaseManager: MockFirebaseManager!
    var presenter: AuthorizationPresenter!
    
    override func setUp() {
        view = MockView()
        router = MockRouter()
        firebaseManager = MockFirebaseManager()
        presenter = AuthorizationPresenter(view: view, router: router, firebaseManager: firebaseManager)
        
    }
    
    override func tearDown() {
        view = nil
        router = nil
        firebaseManager = nil
        presenter = nil
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testModuleIsNotNil() {
        XCTAssertNotNil(view, "View is not nil")
    }
    
    func testView() {
        
    }

}
