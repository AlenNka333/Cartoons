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



class MockFirebaseManager: FirebaseService {
    
}


class AuthorizationPresenterTests: XCTestCase {

//    var view: MockView!
//    var router: MockRouter!
    var manager: MockFirebaseManager!
    var firebaseManager: MockFirebaseManager!
    var presenter: AuthorizationPresenter!
    
    override func setUp() {
//        view = MockView()
//        router = MockRouter()
        firebaseManager = MockFirebaseManager()
//        presenter = AuthorizationPresenter(view: view, router: router, firebaseManager: firebaseManager)
        
    }
    
    override func tearDown() {
//        view = nil
//        router = nil
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
