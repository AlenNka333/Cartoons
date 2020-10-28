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
    
    func loadImage(folder: String, completion: @escaping (Result<URL?, Error>) -> Void) {
        storageDataManager.loadImage(folder: folder, completion: completion)
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
                        if response.count == 1 {
                            let title = response[0]?.deletingPathExtension().lastPathComponent
                            self?.cartoons.append(Cartoon(title: title.unwrapped, link: response[0]))
                        } else {
                            let title = response[0]?.deletingPathExtension().lastPathComponent
                            let item = response[0]?.absoluteString
                            if item.unwrapped.contains(".mp4") {
                                let thumbnail = response[1]?.absoluteURL
                                self?.cartoons.append(Cartoon(title: title.unwrapped, thumbnail: thumbnail, link: URL(string: item.unwrapped)))
                            } else {
                                let thumbnail = response[0]?.absoluteURL
                                self?.cartoons.append(Cartoon(title: title.unwrapped, thumbnail: thumbnail, link: response[1]?.absoluteURL))
                            }
                        }
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
