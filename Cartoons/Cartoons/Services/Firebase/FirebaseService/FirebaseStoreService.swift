//
//  FirebaseStoreService.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/1/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import FirebaseDatabase
import FirebaseStorage
import Foundation

class FirebaseStoreService {
    let storageRef = Storage.storage().reference(forURL: "gs://cartoons-845b3.appspot.com/")
    let databaseRef = Database.database().reference()
    
    func storeToFirebase(metadata: StorageMetadata, imageData: Data, id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let storageItem = storageRef.child("profile_images").child(id)
        storageItem.putData(imageData, metadata: metadata) { _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            storageItem.downloadURL { [weak self] url, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let imageURL = url?.absoluteString else {
                    return
                }
                self?.databaseRef.child("users")
                    .child(id).updateChildValues(["id": id, "imageURL": imageURL]) { error, _ in
                        if let error = error {
                            completion(.failure(error))
                            return
                        }
                    }
            }
        }
    }
    
    func loadFromFirebase(userID: String, completion: @escaping (Result<URL?, Error>) -> Void) {
        databaseRef.child("users").child(userID).observeSingleEvent(of: .value) { snapshot in
                let values = snapshot.value as? NSDictionary
                if let profileImageURL = values?[ "imageURL" ] as? String {
                    let url = URL(string: profileImageURL)
                    completion(.success(url))
                } else {
                    completion(.failure(GeneralError.noSuchPath))
                }
        }
    }
}
