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
        let successPhoneNumber = "+375298939122"
        let wrongPhoneNumber = "43988294"
        let emptyPhoneNumber = ""
        
        sut.verifyUser(number: successPhoneNumber) { result in
            switch result {
            case .success(_):
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
        
        sut.verifyUser(number: emptyPhoneNumber) { result in
            switch result {
            case .success(_):
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
        
        sut.verifyUser(number: wrongPhoneNumber) { result in
            switch result {
            case .success(_):
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
        let verificationId = "F8BB1C28-BAE8-11D6-9C31-00039315CD46"
        
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
