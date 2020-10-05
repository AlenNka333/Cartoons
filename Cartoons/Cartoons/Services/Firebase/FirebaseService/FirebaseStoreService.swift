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
        }
    }
    
    func loadFromFirebase(userID: String, completion: @escaping (Result<URL?, Error>) -> Void) {
            storageRef.child("profile_images").listAll { [weak self] result, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                if result.items.isEmpty {
                    completion(.success(nil))
                    return
                }
                let image = result.items.filter {
                    return $0.name == userID
                }
                if image.isEmpty {
                    completion(.success(nil))
                    return
                }
                let reference = self?.storageRef.child("profile_images/\(userID)")
                reference?.downloadURL { url, error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    } else {
                        completion(.success(url))
                        return
                  }
                }
            }
    }
}
