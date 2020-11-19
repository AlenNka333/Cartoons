//
//  AuthorizationManager.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/9/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import FirebaseAuth
import Foundation

class AuthorizationManager: AuthorizationManagerProtocol {
    func verifyUser(phoneNumber: String, completion: @escaping (Result<String, Error>) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
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
    
    func signIn(verificationId: String, verifyCode: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let credential: PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: verifyCode)
        Auth.auth().signIn(with: credential) { user, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if user == nil {
                completion(.failure(AuthorizationError.emptyVerificationID))
                return
            }
            completion(.success(()))
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
