//
//  AuthorizationService.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/9/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import FirebaseAuth
import Foundation

class AuthorizationService: AuthorizationServiceProtocol {
    private let authorizationManager = AuthorizationManager()
    
    var phoneNumber: String? {
        let firebaseUser = Auth.auth().currentUser
        return firebaseUser?.phoneNumber
    }
    var shouldAuthorize: Bool {
        return Auth.auth().currentUser == nil
    }
    
    func verifyUser(number: String, completion: @escaping (Result<String, Error>) -> Void) {
        let formattedNumber = String(number.filter { !" -".contains($0) })
        if PhoneNumberValidationHelper.checkValidation(number: formattedNumber, type: NumberFormat.bel) {
            if !formattedNumber.isEmpty {
                authorizationManager.verifyUser(number: number, completion: completion)
            } else {
                completion(.failure(AuthorizationError.emptyPhoneNumber))
            }
        } else {
            completion(.failure(AuthorizationError.invalidPhoneNumber))
        }
    }
    
    func signIn(verificationId: String, verifyCode: String, completion: @escaping (Result<Void, Error>) -> Void) {
        authorizationManager.signIn(verificationId: verificationId, verifyCode: verifyCode, completion: completion)
    }
    
    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        authorizationManager.signOut(completion: completion)
    }
}
