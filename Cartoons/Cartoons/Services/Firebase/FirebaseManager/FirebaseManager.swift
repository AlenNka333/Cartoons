//
//  FirebaseManager.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/7/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import Foundation

class FirebaseManager {
    private let firebaseAuthService = FirebaseAuthorizationService()
    private let firebaseStoreService = FirebaseStoreService()
    private lazy var metadata = StorageMetadata()
    private lazy var userId: String? = {
        if let id = Auth.auth().currentUser?.uid {
            return id
        }
        return nil
    }()
    var shouldAuthorize: Bool { Auth.auth().currentUser == nil }
    
    func sendPhoneNumber(number: String, completion: @escaping (Result<String, Error>) -> Void) {
        let formattedNumber = String(number.filter { !" -".contains($0) })
        if PhoneNumberValidationHelper.checkValidation(number: formattedNumber, type: NumberFormat.bel) {
            if !formattedNumber.isEmpty {
                firebaseAuthService.sendPhoneToFirebase(number: formattedNumber) { result in
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
        firebaseAuthService.authorizeUser(with: verificationId, verifyCode: verifyCode) { result in
            switch result {
            case let .success(user):
                completion(.success(user))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func signOutUser(completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseAuthService.signOut { result in
            switch result {
            case .success:
                completion(.success(()))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func getUserInfo() -> String? {
        return firebaseAuthService.phoneNumber
    }
    
    func loadProfileImage(completion: @escaping (Result<URL?, Error>) -> Void) {
        guard let id = userId else {
            completion(.failure(AuthorizationError.emptyUser))
            return
        }
        firebaseStoreService.loadFromFirebase(userID: id) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let path):
                completion(.success(path))
            }
        }
    }
    
    func storeUserProfileImage(imageData: Data, completion: @escaping (Result<Void, Error>) -> Void) {
        metadata.contentType = "image/jpeg"
        guard let id = userId else {
            completion(.failure(AuthorizationError.emptyUser))
            return
        }
        firebaseStoreService.storeToFirebase(metadata: metadata, imageData: imageData, id: id) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success:
                completion(.success(()))
            }
        }
    }
}
