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
    
    func sendPhoneToFirebase(number: String, completion: @escaping (Error?) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { verificationID, error in
            if error != nil {
                completion(error)
            } else {
                print(verificationID)
                
                UserDefaults.standard.set(verificationID, forKey: "firebase_verification")
                UserDefaults.standard.synchronize()
            }
        }
    }
}
