//
//  LoadingService.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 11/2/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Firebase
import Foundation
import os

class LoadingService: NSObject {
    struct Log {
        static let table = OSLog(subsystem: "com.AlenaNesterkina.kids-cartoons", category: "table")
    }

    private let fileManager = FilesManager()
    
    weak var loadingServiceDelegate: LoadingServiceDelegate?
    
    private lazy var loadingQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "Cartoons")
        configuration.sessionSendsLaunchEvents = false
        configuration.isDiscretionary = true
        configuration.allowsCellularAccess = false
        configuration.shouldUseExtendedBackgroundIdleMode = true
        configuration.waitsForConnectivity = true
        
        return URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
    }()
    
    func downloadFile(_ file: Cartoon, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let link = file.link else {
            print("Invalid link")
            return
        }
        if loadingQueue.operationCount >= 1 {
            completion(.failure(ServiceErrors.operationQueueOverflow))
        }
        if !fileManager.checkExitingFile(with: link) {
            loadingQueue.addOperation { [weak self] in
                let task = self?.session.downloadTask(with: link)
                task?.resume()
            }
        } else {
            completion(.failure(ServiceErrors.fileExists))
        }
    }
}

extension LoadingService: URLSessionTaskDelegate, URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64,
                    totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64) {
        if totalBytesExpectedToWrite > 0 {
            let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
            //loadingServiceDelegate?.setProgress(progress)
            let result = String(format: "% .2f", progress * 100) + "%"
            os_log("Progress %@", log: Log.table, result)
        }
    }
    
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL) {
        fileManager.saveData(by: location, with: downloadTask) { [weak self] result in
            switch result {
            case .success(let localPath):
                self?.loadingServiceDelegate?.updateDataSource(localPath)
            case .failure(_):
                break
            }
        }
        os_log("Download finished: %d", log: Log.table, location.absoluteString)
    }
    
    func urlSession(_ session: URLSession,
                    task: URLSessionTask,
                    didCompleteWithError error: Error?) {
        if error != nil {
            os_log("Task completed: %@", log: Log.table, (error?.localizedDescription).unwrapped)
        }
    }
}
