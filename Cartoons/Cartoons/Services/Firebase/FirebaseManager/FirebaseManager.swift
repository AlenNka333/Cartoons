//
//  FirebaseManager.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/7/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import FirebaseAuth
import Foundation

class FirebaseManager {
    let firebaseService = FirebaseService()

    var shouldAuthorize: Bool { Auth.auth().currentUser == nil }
    
    func sendPhoneNumber(number: String, completion: @escaping (Result<String, Error>) -> Void) {
        let formattedNumber = String(number.filter { !" -".contains($0) })
        if PhoneNumberValidationHelper.checkValidation(number: formattedNumber, type: NumberFormat.bel) {
            if !formattedNumber.isEmpty {
                firebaseService.sendPhoneToFirebase(number: formattedNumber) { result in
                    switch result {
                    case let .success(result):
                        AppData.verificationID = result
                        completion(.success(result))
                    case let .failure(error):
                        completion(.failure(error))
                    }
                }
            } else {
                completion(.failure(AuthorizationError.emptyPhoneNumber))
            }
        } else {
            completion(.failure(AuthorizationError.invalidPhoneNumber))
        }
    }
    
    func authorizeUser(verificationId: String, verifyCode: String, completion: @escaping (Result<AuthDataResult?, Error>) -> Void) {
        firebaseService.authorizeUser(with: verificationId, verifyCode: verifyCode) { result in
            switch result {
            case let .success(user):
                completion(.success(user))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func signOutUser(completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseService.signOut { result in
            switch result {
            case .success:
                completion(.success(()))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func getUserInfo() -> String? {
        return firebaseService.getPhoneNumber()
    }
}
