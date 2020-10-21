//
//  StorageDataManager.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/9/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import FirebaseAuth
import FirebaseStorage
import Foundation

class StorageDataManager {
    private let storageRef = Storage.storage().reference(forURL: "gs://cartoons-845b3.appspot.com/")
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
    
    func getReferenceList(completion: @escaping (Result<[String], Error>) -> Void) {
        var references = [String]()
        storageRef.child("movies").listAll { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            for prefix in result.prefixes {
                references.append(prefix.fullPath)
            }
            completion(.success(references))
        }
    }
    
    func loadData(folder: String, completion: @escaping (Result<URL?, Error>) -> Void) {
        let reference = self.storageRef.child("\(folder)")
        reference.listAll { response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            response.items[0].downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(url?.absoluteURL))
                return
            }
        }
    }
}
