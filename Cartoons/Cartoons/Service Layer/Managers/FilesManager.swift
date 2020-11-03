//
//  FileManager.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 11/3/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

class FilesManager {
    var cartoonURL: URL?
    
    func saveData(by location: URL, with downloadTask: URLSessionDownloadTask) {
        guard let url = downloadTask.originalRequest?.url else {
            return
        }
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
        try? FileManager.default.removeItem(at: destinationURL)
        do {
            try FileManager.default.copyItem(at: location, to: destinationURL)
            self.cartoonURL = destinationURL
        } catch let error {
            print("Copy Error: \(error.localizedDescription)")
        }
    }
}
