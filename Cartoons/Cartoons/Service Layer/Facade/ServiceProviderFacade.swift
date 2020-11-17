import Foundation

class ServiceProviderFacade: Facade {
    weak var cartoonsDataSourceDelegate: ServiceProviderDelegate?
    weak var favouritesDataSourceDelegate: FavouritesServiceProviderDelegate?
    weak var settingsDelegate: SettingsServiceProviderDelegate?
    weak var errorDelegate: ErrorPresentable?
    
    private var storageService: StorageDataService
    private var loadingService: LoadingService
    private var fileManager: FilesManager
    
    private var localData: [Cartoon]
    private var serverData: [Cartoon]
    
    init(storageService: StorageDataService, loadingService: LoadingService, fileManager: FilesManager) {
        self.storageService = storageService
        self.loadingService = loadingService
        self.fileManager = fileManager
        
        localData = []
        serverData = []
        loadingService.loadingServiceDelegate = self
    }
    
    func getServerData() {
        storageService.checkFoldersExists { [weak self] result in
            switch result {
            case .success(let cartoons):
                self?.serverData = cartoons
                self?.findInLocalFolder()
                self?.cartoonsDataSourceDelegate?.updateDataSource(self?.serverData)
            case .failure(let error):
                self?.errorDelegate?.show(error: error)
            }
        }
    }
    
    func findInLocalFolder() {
        serverData.forEach { item in
            guard let url = item.link else {
                return
            }
            if fileManager.checkExitingFile(with: url) {
                item.state = .loaded
            }
        }
    }
    
    func clearCache() {
        fileManager.clearCache()
        localData.removeAll { item -> Bool in
            item.state != .inProgress
        }
        favouritesDataSourceDelegate?.updateDataSource(localData)
        getServerData()
    }
    
    func getLocalData() {
        fileManager.getLocalData { [weak self] result in
            switch result {
            case .success(let data):
                self?.makeDataSource(data)
                self?.checkBackgroundOperation()
                self?.favouritesDataSourceDelegate?.updateDataSource(self?.localData)
            case .failure(let error):
                self?.errorDelegate?.show(error: error)
            }
        }
    }
    
    func makeDataSource(_ data: [URL]) {
        if localData.isEmpty {
            data.forEach { item in
                localData.append(Cartoon(title: item.deletingPathExtension().lastPathComponent, state: .loaded, localPath: item))
            }
        } else {
            data.forEach { item in
                let index = localData.firstIndex { cartoon -> Bool in
                    cartoon.title == item.deletingPathExtension().lastPathComponent
                }
                if index == nil {
                    localData.append(Cartoon(title: item.deletingPathExtension().lastPathComponent, state: .loaded, localPath: item))
                }
            }
        }
        localData.sort { lhs, rhs -> Bool in
            lhs.title.unwrapped > rhs.title.unwrapped
        }
    }
    
    func checkBackgroundOperation() {
        let index = localData.firstIndex { element -> Bool in
            element.state == .inProgress
        }
        if index == nil {
            loadingService.checkOperationQueue { [weak self] operationCount in
                if operationCount != 0 {
                    self?.localData.append(Cartoon(state: .inProgress))
                }
            }
        }
    }
}

extension ServiceProviderFacade: LoadingServiceDelegate {
    func setOperation(with link: URL) {
        localData.append(Cartoon(title: link.deletingPathExtension().lastPathComponent, state: .inProgress))
        favouritesDataSourceDelegate?.updateDataSource(localData)
    }
    
    func updateProgress(_ progress: Float) {
        favouritesDataSourceDelegate?.updateProgress(progress)
    }
    
    func updateDataSource(_ localPath: URL) {
        settingsDelegate?.cacheUpdated(true)
        getServerData()
        localData.removeAll { item -> Bool in
            item.state == .inProgress
        }
        fileManager.getLocalData { [weak self] result in
            switch result {
            case .success(let data):
                self?.makeDataSource(data)
                self?.favouritesDataSourceDelegate?.updateDataSource(self?.localData)
            case .failure(let error):
                self?.errorDelegate?.show(error: error)
            }
        }
    }
}
