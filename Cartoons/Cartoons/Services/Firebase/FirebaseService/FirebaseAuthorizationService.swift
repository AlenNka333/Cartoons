//
//  FirebaseService.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/7/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import FirebaseAuth
import Foundation

class FirebaseAuthorizationService {
    var phoneNumber: String? {
        let firebaseUser = Auth.auth().currentUser
        return firebaseUser?.phoneNumber
    }

    func sendPhoneToFirebase(number: String, completion: @escaping (Result<String, Error>) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { verificationID, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let verificationID = verificationID else {
                completion(.failure(AuthorizationError.emptyVerificationID))
                return
            }
            completion(.success(verificationID))
        }
    }
    
    func authorizeUser(with verifyId: String, verifyCode: String, completion: @escaping (Result<AuthDataResult?, Error>) -> Void) {
            let credential: PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: verifyId, verificationCode: verifyCode)
            Auth.auth().signIn(with: credential) { user, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let user = user else {
                    completion(.failure(AuthorizationError.emptyVerificationID))
                    return
                }
                completion(.success(user))
            }
    }
    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}
