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
    
    private var localData: [Cartoon]? {
        didSet {
            favouritesDataSourceDelegate?.updateDataSource(localData)
        }
    }
    private var serverData: [Cartoon]? {
        didSet {
            cartoonsDataSourceDelegate?.updateDataSource(serverData)
        }
    }
    
    init(storageService: StorageDataService, loadingService: LoadingService, fileManager: FilesManager) {
        self.storageService = storageService
        self.loadingService = loadingService
        self.fileManager = fileManager
    }
    
    func getServerData() {
        storageService.checkFoldersExists() { [weak self] result in
            switch result {
            case .success(let cartoons):
                self?.serverData = cartoons
            case .failure(let error):
                self?.errorDelegate?.show(error: error)
            }
        }
    }
    
    func getLocalData() {
        fileManager.getLocalData() { [weak self] result in
            switch result {
            case .success(let data):
                self?.localData = self?.makeDataSource(data)
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
}

extension ServiceProviderFacade: LoadingServiceDelegate {
    func updateProgress(_ progress: Float) {
    }
    
    func updateDataSource(_ localPath: URL) {
        localData?.append(Cartoon(title: localPath.deletingPathExtension().lastPathComponent,
                                  state: .loaded,
                                  localPath: localPath))
    }
}
