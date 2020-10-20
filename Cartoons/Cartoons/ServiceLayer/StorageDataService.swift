//
//  StorageService.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/9/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Firebase
import Foundation
// swiftlint:disable all

class StorageDataService: StorageDataServiceProtocol {
    private let storageDataManager = StorageDataManager()
    private var folders = [String]()
    private var cartoons = [Cartoon]()
    
    func saveImage(imageData: Data, completion: @escaping (Result<Void, Error>) -> Void) {
        storageDataManager.saveImage(imageData: imageData, completion: completion)
    }
    
    func loadImage(completion: @escaping (Result<URL?, Error>) -> Void) {
        storageDataManager.loadImage(completion: completion)
    }
    
    func checkListAvailable(completion: @escaping (Result<[String], Error>) -> Void) {
        storageDataManager.getReferenceList { [weak self] result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let list):
                self?.folders = list
                completion(.success(list))
            }
        }
    }
    
    func sendRequest(completion: @escaping (Result<[Cartoon], Error>) -> Void) {
        let dispatchQueue = DispatchQueue(label: "get-movies")
        let dispatchGroup = DispatchGroup()
        let semaphore = DispatchSemaphore(value: 0)
        dispatchQueue.async {
            self.folders.forEach { body in
                dispatchGroup.enter()
                self.storageDataManager.loadData(folder: body) { [weak self] result in
                    switch result {
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(let response):
                        let title = response?.lastPathComponent
                        self?.cartoons.append(Cartoon(title: title.unwrapped, link: response))
                        semaphore.signal()
                        dispatchGroup.leave()
                    }
                }
                semaphore.wait()
            }
        }
        dispatchGroup.notify(queue: dispatchQueue) {
            DispatchQueue.main.async {
                completion(.success(self.cartoons))
            }
        }
    }
}
