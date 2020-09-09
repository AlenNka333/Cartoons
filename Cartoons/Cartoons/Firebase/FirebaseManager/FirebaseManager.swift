//
//  FirebaseManager.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/7/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseManager {
    let firebaseService: FirebaseService = FirebaseService()
    @UserDefault(Constants.verificationId, defaultValue: "")
    var verificationID: String
    static var shouldAuthorize: Bool { Auth.auth().currentUser == nil }
    
    func sendPhoneNumber(number: String, completion: @escaping (Result<String, Error>) -> Void) {
        let formattedNumber = String(number.filter { !" -".contains($0)})
        if !number.isEmpty {
            firebaseService.sendPhoneToFirebase(number: formattedNumber) { [weak self] (result) in
                switch result {
                case let .success(result):
                    self?.verificationID = result
                    completion(.success(result))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        } else {
            completion(.failure(AuthorizationError.emptyPhoneNumber))
        }
    }
    
    func authorizeUser(verificationId: String, verifyCode: String, completion: @escaping (Result<AuthDataResult?, Error>) -> Void) {
        firebaseService.authorizeUser(with: verificationId, verifyCode: verifyCode) { [weak self] (result) in
            switch result {
            case let .success(user):
                completion(.success(user))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
