//
//  FileManager.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 11/3/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

class FilesManager {
    private let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    func saveData(by location: URL, with downloadTask: URLSessionDownloadTask, completion: @escaping ((Result<URL, Error>) -> Void)) {
        guard let url = downloadTask.originalRequest?.url else {
            return
        }
        let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
        do {
            try FileManager.default.copyItem(at: location, to: destinationURL)
            completion(.success(destinationURL))
        } catch {
            completion(.failure(error))
        }
    }
    
    func checkExitingFile(with path: URL) -> Bool {
        let localPath = documentsPath.appendingPathComponent(path.lastPathComponent).path
        return FileManager.default.fileExists(atPath: localPath)
    }
    
    func getLocalData(completion: @escaping ((Result<[URL], Error>) -> Void)) {
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsPath, includingPropertiesForKeys: nil)
            let videoFiles = directoryContents.filter { $0.pathExtension == "mp4" }
            completion(.success(videoFiles))
        } catch {
            completion(.failure(error))
        }
    }
}
