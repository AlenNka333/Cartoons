//
//  MockAuthorizationService.swift
//  CartoonsTests
//
//  Created by Alena Nesterkina on 11/11/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

@testable import Cartoons
import FirebaseAuth
import Foundation

class MockAuthorizationManager {
    var verifyUserMethodWasCalled = false
    var signInMethodWasCalled = false
    var signOutMethodWasCalled = false
    var shouldReturnError = false
    
    enum MockManagerError: Error {
        case verifying
        case login
        case logout
    }
    
    func reset() {
        shouldReturnError = false
        signInMethodWasCalled = false
        signOutMethodWasCalled = false
        shouldReturnError = false
    }
    
    convenience init() {
        self.init(false)
    }
    
    init(_ shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    let mockVerifyingRequest: String = {
        "F8BB1C28-BAE8-11D6-9C31-00039315CD46"
    }()
}

extension MockAuthorizationManager: AuthorizationManagerProtocol {
    func verifyUser(number: String, completion: @escaping (Result<String, Error>) -> Void) {
        verifyUserMethodWasCalled = true
        if shouldReturnError {
            completion(.failure(MockManagerError.verifying))
        } else {
            completion(.success(mockVerifyingRequest))
        }
    }
    
    func signIn(verificationId: String, verifyCode: String, completion: @escaping (Result<Void, Error>) -> Void) {
        signInMethodWasCalled = true
        if shouldReturnError {
            completion(.failure(MockManagerError.login))
        } else {
            completion(.success(()))
        }
    }
    
    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        signOutMethodWasCalled = true
        if shouldReturnError {
            completion(.failure(MockManagerError.logout))
        } else {
            completion(.success(()))
        }
    }
}
