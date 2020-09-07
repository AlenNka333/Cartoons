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
    
    func sendPhoneToFirebase(number: String, completion: @escaping (Error?) -> ()) {
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { (verificationID, error) in
            if error == nil {
                //Save to KeyChain verificationID
                completion(nil)
            } else {
                completion(error)
            }
        }
    }
}
