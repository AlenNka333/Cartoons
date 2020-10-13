//
//  StorageServiceProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/9/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol StorageDataServiceProtocol {
    func saveImage(imageData: Data, completion: @escaping (Result<Void, Error>) -> Void)
    func loadImage(completion: @escaping (Result<URL?, Error>) -> Void)
}
