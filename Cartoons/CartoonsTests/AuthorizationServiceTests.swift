//
//  CartoonsTests.swift
//  CartoonsTests
//
//  Created by Alena Nesterkina on 10/2/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//
@testable import Cartoons
import XCTest

class AuthorizationServiceTests: XCTestCase {
    let sut = AuthorizationService(authorizationManager: MockAuthorizationManager())
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testVerificationResponse() {
        let expectation = self.expectation(description: "Verifying user test response")
        let succeedPhoneNumber = "+375298939122"
        let failPhoneNumber = "254662"
        let emptyPhoneNumber = ""
        
        sut.verifyUser(number: succeedPhoneNumber) { result in
            switch result {
            case .success(let id):
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testLoginResponse() {
        let expectation = self.expectation(description: "Login test response")
        let verificationId = ""
        
        sut.signIn(verificationId: verificationId, verifyCode: "123456") { result in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testLogoutResponse() {
        let expectation = self.expectation(description: "Logout test response")
        
        sut.signOut { result in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    override func tearDownWithError() throws {
    }
}
