//
//  StorageServiceProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/9/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol StorageDataManagerProtocol {
    func saveImage(imageData: Data, completion: @escaping (Result<Void, Error>) -> Void)
    func loadImage(folder: String, completion: @escaping (Result<URL?, Error>) -> Void)
    func getReferenceList(completion: @escaping (Result<[String], Error>) -> Void)
    func loadData(folder: String, completion: @escaping (Result<[URL?], Error>) -> Void)
}
