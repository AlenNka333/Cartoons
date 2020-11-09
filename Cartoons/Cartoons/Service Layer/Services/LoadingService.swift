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
    var backgroundCompletionHandler: (() -> Void)?
    
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
    
    override init() {
        super.init()
        session.getAllTasks { tasks in
            tasks.forEach { task in
                task.resume()
            }
        }
    }
    
    func downloadFile(_ file: Cartoon, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let link = file.link else {
            print("Invalid link")
            return
        }
        if !fileManager.checkExitingFile(with: link) {
            checkOperationQueue { [weak self] operationsCount in
                if operationsCount != 0 {
                    completion(.failure(ServiceErrors.operationQueueOverflow))
                    return
                }
                self?.loadingServiceDelegate?.setOperation(with: link)
                self?.loadingQueue.addOperation { [weak self] in
                    let task = self?.session.downloadTask(with: link)
                    task?.resume()
                }
            }
        } else {
            completion(.failure(ServiceErrors.fileExists))
        }
    }
    
    func checkOperationQueue(completion: @escaping ((Int) -> Void)) {
        session.getAllTasks { task in
            completion(task.count)
        }
    }
}

extension LoadingService: URLSessionDelegate {
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        DispatchQueue.main.async {
            guard
                let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                let completionHandler = appDelegate.backgroundSessionCompletionHandler
            else {
                return
            }
            appDelegate.backgroundSessionCompletionHandler = nil
            completionHandler()
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
            let result = String(format: "% .1f", Float(progress) * 100) + "%"
            loadingServiceDelegate?.updateProgress(progress)
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
            case .failure:
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
