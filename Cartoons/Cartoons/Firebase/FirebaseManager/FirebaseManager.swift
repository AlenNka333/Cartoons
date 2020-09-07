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
    
    let firebaseManager: FirebaseService
    
    init() {
        firebaseManager = FirebaseService()
    }
    
    func sendPhoneNumber(number: String, completion: @escaping (Error?) -> ()) {
        let formattedNumber = String(number.filter { !" -".contains($0)})
        if !number.isEmpty {
            firebaseManager.sendPhoneToFirebase(number: formattedNumber) { (error) in
                error == nil ? completion(nil) : completion(error)
            }
        } else {
            completion(AuthorizationError.emptyPhoneNumber)
        }
    }    
}
