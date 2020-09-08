//
//  FirebaseService.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/7/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseService {
    let testPhoneNumber = "+15973342222"
    let testVerificationCode = "123456"
    func sendPhoneToFirebase(number: String, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        PhoneAuthProvider.provider().verifyPhoneNumber(testPhoneNumber, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let verificationID = verificationID else {
                return
            }
            print("ID: \(verificationID)")
            completion(.success(verificationID))
        }
    }
    
    func authorizeUser(with verifyId: String, verifyCode: String, completion: @escaping (Result<AuthDataResult?, Error>) -> Void) {
            let credential: PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: verifyId, verificationCode: testVerificationCode)
            Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(user))
            }
    }
}
