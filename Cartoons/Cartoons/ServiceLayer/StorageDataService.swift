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
    
    func saveImage(imageData: Data, completion: @escaping (Result<Void, Error>) -> Void) {
        storageDataManager.saveImage(imageData: imageData, completion: completion)
    }
    
    func loadImage(completion: @escaping (Result<URL?, Error>) -> Void) {
        storageDataManager.loadImage(completion: completion)
    }
}
