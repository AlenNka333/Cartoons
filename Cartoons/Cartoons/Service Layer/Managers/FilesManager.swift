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
    var cartoonURL: URL?
    
    func saveData(by location: URL, with downloadTask: URLSessionDownloadTask) {
        guard let url = downloadTask.originalRequest?.url else {
            return
        }
        let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
        try? FileManager.default.removeItem(at: destinationURL)
        do {
            try FileManager.default.copyItem(at: location, to: destinationURL)
            self.cartoonURL = destinationURL
        } catch {
            print("Copy Error: \(error.localizedDescription)")
        }
    }
    
    func getLocalData() -> [URL]? {
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsPath, includingPropertiesForKeys: nil)
            let videoFiles = directoryContents.filter { $0.pathExtension == "mp4" }
            return videoFiles
        } catch {
            print(error)
        }
        return nil
    }
}
