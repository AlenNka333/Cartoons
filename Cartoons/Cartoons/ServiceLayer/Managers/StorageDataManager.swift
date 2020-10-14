//
//  StorageDataManager.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/9/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import Foundation

class StorageDataManager {
    private let storageRef = Storage.storage().reference(forURL: "gs://cartoons-845b3.appspot.com/")
    private let databaseRef = Database.database().reference()
    private let metadata = StorageMetadata()
    
    func saveImage(imageData: Data, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let id = Auth.auth().currentUser?.uid else {
            completion(.failure(AuthorizationError.emptyUser))
            return
        }
        metadata.contentType = "image/png"
        let storageItem = storageRef.child("profile_images").child(id)
        storageItem.putData(imageData, metadata: metadata) { _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
        }
    }
    
    func loadImage(completion: @escaping (Result<URL?, Error>) -> Void) {
        guard let id = Auth.auth().currentUser?.uid else {
            completion(.failure(AuthorizationError.emptyUser))
            return
        }
        let reference = self.storageRef.child("profile_images/\(id)")
        reference.downloadURL { url, error in
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
