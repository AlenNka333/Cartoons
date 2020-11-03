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
    func loadImage(folder: String, completion: @escaping (Result<URL?, Error>) -> Void)
    func checkFoldersExists(completion: @escaping (Result<[Cartoon], Error>) -> Void)
    func getData(completion: @escaping (Result<[Cartoon], Error>) -> Void)
}
