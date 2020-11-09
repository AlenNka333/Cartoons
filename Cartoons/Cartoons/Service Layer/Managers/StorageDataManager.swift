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
    
    func loadImage(folder: String, completion: @escaping (Result<URL?, Error>) -> Void) {
        guard let id = Auth.auth().currentUser?.uid else {
            completion(.failure(AuthorizationError.emptyUser))
            return
        }
        let reference = self.storageRef.child("\(folder)/\(id)")
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
        storageRef.child(AppEnvironment.Firebase.moviesParam).listAll { result, error in
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
    
    func loadData(folder: String, completion: @escaping (Result<[URL?], Error>) -> Void) {
        let reference = self.storageRef.child("\(folder)")
        var folderItems = [URL?]()
        let dispatchGroup = DispatchGroup()
        reference.listAll { response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            for item in response.items {
                dispatchGroup.enter()
                item.downloadURL { url, error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    folderItems.append(url)
                    dispatchGroup.leave()
                }
            }
            dispatchGroup.notify(queue: DispatchQueue.main) {
                completion(.success(folderItems))
                return
            }
        }
    }
}
