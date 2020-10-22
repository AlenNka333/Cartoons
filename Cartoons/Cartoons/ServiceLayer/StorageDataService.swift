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
    
    func checkListAvailable(completion: @escaping (Result<[Cartoon], Error>) -> Void) {
        folders = [String]()
        cartoons = [Cartoon]()
        self.storageDataManager.getReferenceList { [weak self] result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let list):
                self?.folders = list
                self?.sendRequest(completion: completion)
            }
        }
    }

    func sendRequest(completion: @escaping (Result<[Cartoon], Error>) -> Void) {
        let dispatchQueue = DispatchQueue(label: "get-movies")
        let dispatchGroup = DispatchGroup()
        self.folders.forEach { body in
            dispatchGroup.enter()
            dispatchQueue.async {
                self.storageDataManager.loadData(folder: body) { [weak self] result in
                    switch result {
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(let response):
                        let title = response?.deletingPathExtension().lastPathComponent
                        self?.cartoons.append(Cartoon(title: title.unwrapped, link: response))
                        dispatchGroup.leave()
                    }
                }
            }
        }
        dispatchGroup.notify(queue: DispatchQueue.main) {
            completion(.success(self.cartoons))
        }
    }
}
