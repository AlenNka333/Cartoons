//
//  DataFacade.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 11/4/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

class ServiceProviderFacade: Facade {
    weak var cartoonsDataSourceDelegate: ServiceProviderDelegate?
    weak var favouritesDataSourceDelegate: ServiceProviderDelegate?
    weak var errorDelegate: ErrorPresentable?
    
    private var storageService: StorageDataService
    private var loadingService: LoadingService
    private var fileManager: FilesManager
    
    private var localData: [Cartoon]?
    private var serverData: [Cartoon]? {
        didSet {
            cartoonsDataSourceDelegate?.updateDataSource(serverData)
        }
    }
    
    init(storageService: StorageDataService, loadingService: LoadingService, fileManager: FilesManager) {
        self.storageService = storageService
        self.loadingService = loadingService
        self.fileManager = fileManager
        
        loadingService.loadingServiceDelegate = self
    }
    
    func getServerData() {
        storageService.checkFoldersExists { [weak self] result in
            switch result {
            case .success(let cartoons):
                self?.serverData = cartoons
            case .failure(let error):
                self?.errorDelegate?.show(error: error)
            }
        }
    }
    
    func getLocalData() {
        fileManager.getLocalData { [weak self] result in
            switch result {
            case .success(let data):
                self?.localData = self?.makeDataSource(data)
                self?.checkBackgroundOperation()
                self?.favouritesDataSourceDelegate?.updateDataSource(self?.localData)
            case .failure(let error):
                self?.errorDelegate?.show(error: error)
            }
        }
    }
    
    func makeDataSource(_ data: [URL]) -> [Cartoon] {
        var result = [Cartoon]()
        data.forEach { item in
            result.append(Cartoon(title: item.deletingPathExtension().lastPathComponent, state: .loaded, localPath: item))
        }
        return result
    }
    
    func checkBackgroundOperation() {
        loadingService.checkOperationQueue { [weak self] operationCount in
            if operationCount != 0 {
                self?.localData?.append(Cartoon(state: .inProgress))
            }
        }
    }
}

extension ServiceProviderFacade: LoadingServiceDelegate {
    func setOperation() {
        localData?.append(Cartoon(state: .inProgress))
        favouritesDataSourceDelegate?.updateDataSource(localData)
    }
    
    func updateProgress(_ progress: String) {
        localData?.last?.progress = progress
        favouritesDataSourceDelegate?.updateDataSource(localData)
    }
    
    func updateDataSource(_ localPath: URL) {
        localData?.removeLast()
        localData?.append(Cartoon(title: localPath.deletingPathExtension().lastPathComponent,
                                  state: .loaded,
                                  localPath: localPath))
        checkBackgroundOperation()
        favouritesDataSourceDelegate?.updateDataSource(localData)
    }
}
