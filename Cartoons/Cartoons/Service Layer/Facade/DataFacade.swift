//
//  DataFacade.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 11/4/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

class DataFacade: Facade {
    private let serviceLocator: Locator
    
    weak var cartoonsDataSourceDelegate: DataSourceDelegate?
    weak var favouritesDataSourceDelegate: DataSourceDelegate?
    weak var errorDelegate: ErrorPresentable?
    
    private var storageService: StorageDataService?
    private var loadingService: LoadingService?
    private var fileManager: FilesManager?
    
    private var dataSource: [Cartoon]?
    private var favouritesDataSource: [Cartoon]? {
        didSet {
            favouritesDataSourceDelegate?.updateDataSource(favouritesDataSource)
        }
    }
    private var serverData: [Cartoon]? {
        didSet {
            cartoonsDataSourceDelegate?.updateDataSource(serverData)
        }
    }
    private var localData: [URL]?
    private var operationQueue: Queue<Cartoon>?
    
    init(serviceLocator: Locator) {
        self.serviceLocator = serviceLocator
        guard let storage: StorageDataService = serviceLocator.resolve(StorageDataService.self),
              let loading: LoadingService = serviceLocator.resolve(LoadingService.self),
              let files: FilesManager = serviceLocator.resolve(FilesManager.self) else {
            return
        }
        self.storageService = storage
        self.loadingService = loading
        self.fileManager = files
        
        operationQueue = loadingService?.getOperationQueue()
    }
    
    func getProgressData() -> [Cartoon]? { operationQueue?.getElements() }
    
    func getServerData() {
        storageService?.checkFoldersExists(completion: { [weak self] result in
            switch result {
            case .success(let cartoons):
                self?.serverData = cartoons
            case .failure(let error):
                self?.errorDelegate?.show(error: error)
            }
        })
    }
    
    func getLocalData() {
        fileManager?.getLocalData(completion: { [weak self] result in
            switch result {
            case .success(let data):
                self?.makeDataSource(data)
            case .failure(let error):
                self?.errorDelegate?.show(error: error)
            }
        })
    }
    
    func makeDataSource(_ data: [URL]) {
        
    }
}

extension DataFacade: LoadingServiceDelegate {
    func updateOperationQueue(_ operation: Cartoon) {
        operationQueue?.enqueue(operation)
    }
    
    func setProgress(_ progress: Float) {
    }
    
    func updateDataSource(_ data: Cartoon) {
        favouritesDataSource?.append(data)
    }
}
