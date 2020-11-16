//
//  AuthorizationServiceProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/9/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import FirebaseAuth
import Foundation

protocol AuthorizationManagerProtocol {
    func verifyUser(number: String, completion: @escaping (Result<String, Error>) -> Void)
    func signIn(verificationId: String, verifyCode: String, completion: @escaping (Result<Void, Error>) -> Void)
    func signOut(completion: @escaping (Result<Void, Error>) -> Void)
}
