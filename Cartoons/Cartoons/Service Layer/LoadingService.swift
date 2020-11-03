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
      static let table = OSLog(subsystem: "com.razeware.Chirper", category: "table")
    }
    
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
        
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    private var loadedFiles: [Cartoon] = []
    
    override init() {
        super.init()
        print("Start")
    }
    
    func downloadFile(from url: URL) {
        loadingQueue.addOperation { [weak self] in
            let task = self?.session.downloadTask(with: url)
            task?.resume()
        }
    }
    
    func stopLoading() {
    }
    
    func continueLoading() {
    }
}

extension LoadingService: URLSessionTaskDelegate, URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        if totalBytesExpectedToWrite > 0 {
            let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
            os_log("Progress ", log: Log.table)
        }
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        os_log("Download finished:", log: Log.table)
        try? FileManager.default.removeItem(at: location)
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print(error?.localizedDescription)
        os_log("Task completed: %@", log: Log.table, (error?.localizedDescription).unwrapped)
    }
}
