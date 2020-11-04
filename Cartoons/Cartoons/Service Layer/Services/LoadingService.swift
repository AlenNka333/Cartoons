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
        configuration.sessionSendsLaunchEvents = true
        configuration.isDiscretionary = true
        configuration.allowsCellularAccess = false
        configuration.shouldUseExtendedBackgroundIdleMode = true
        configuration.waitsForConnectivity = true
        
        return URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
    }()
    private var operationQueue = Queue<Cartoon>() {
        didSet {
            guard let tail = operationQueue.tail else {
                return
            }
            tail.state = .inProgress
            loadingServiceDelegate?.updateOperationQueue(tail)
        }
    }
    
    func downloadFile(_ file: Cartoon) {
        guard let link = file.link else {
            print("Invalid link")
            return
        }
        operationQueue.enqueue(file)
        loadingQueue.addOperation { [weak self] in
            let task = self?.session.downloadTask(with: link)
            task?.resume()
        }
    }
    
    func getOperationQueue() -> Queue<Cartoon> { operationQueue }
}

extension LoadingService: URLSessionTaskDelegate, URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64,
                    totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64) {
        if totalBytesExpectedToWrite > 0 {
            let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
            loadingServiceDelegate?.setProgress(progress)
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
                guard let currentTask = self?.operationQueue.head else {
                    return
                }
                self?.operationQueue.dequeue()
                currentTask.localPath = localPath
                self?.loadingServiceDelegate?.updateDataSource(currentTask)
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
