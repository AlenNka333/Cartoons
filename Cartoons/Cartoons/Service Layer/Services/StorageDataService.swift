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

class StorageDataService {
    private let storageDataManager: StorageDataManagerProtocol
    private var folders = [String]()
    var cartoons = [Cartoon]()
    
    init(storageDataManager: StorageDataManagerProtocol = StorageDataManager()) {
        self.storageDataManager = storageDataManager
    }
    
    func saveImage(imageData: Data, completion: @escaping (Result<Void, Error>) -> Void) {
        storageDataManager.saveImage(imageData: imageData, completion: completion)
    }
    
    func loadImage(folder: String, completion: @escaping (Result<URL?, Error>) -> Void) {
        storageDataManager.loadImage(folder: folder, completion: completion)
    }
    
    func checkFoldersExists(completion: @escaping (Result<[Cartoon], Error>) -> Void) {
        folders = [String]()
        cartoons = [Cartoon]()
        self.storageDataManager.getReferenceList { [weak self] result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let list):
                self?.folders = list
                self?.getData(completion: completion)
            }
        }
    }
    
    func getData(completion: @escaping (Result<[Cartoon], Error>) -> Void) {
        let dispatchQueue = DispatchQueue(label: "get-movies")
        let dispatchGroup = DispatchGroup()
        self.folders.forEach { folderName in
            dispatchGroup.enter()
            dispatchQueue.async {
                self.storageDataManager.loadData(folder: folderName) { [weak self] result in
                    switch result {
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(let response):
                        let cartoon = findItemByType(response: response, ".mp4")
                        let thumbnail = findItemByType(response: response, ".png")
                        if let image = thumbnail {
                            self?.cartoons.append(Cartoon(title: getTitleFromUrl(url: cartoon).unwrapped, state: .onServer, thumbnail: image.absoluteURL, link: cartoon))
                        } else {
                            self?.cartoons.append(Cartoon(title: getTitleFromUrl(url: cartoon).unwrapped, state: .onServer, link: cartoon))
                        }
                        dispatchGroup.leave()
                    }
                }
            }
        }
        dispatchGroup.notify(queue: DispatchQueue.main) {
            completion(.success(self.cartoons))
        }
        
        func findItemByType(response: [URL?], _ type: String) -> URL? {
            response.first { $0?.absoluteString.contains("\(type)") ?? false } ?? nil
        }
        func getTitleFromUrl(url: URL?) -> String? { url?.deletingPathExtension().lastPathComponent }
    }
}
