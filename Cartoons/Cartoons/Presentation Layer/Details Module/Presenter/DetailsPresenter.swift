//
//  DetailsViewPresenter.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/12/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

class DetailsPresenter: DetailsViewPresenterProtocol {
    let view: DetailsViewProtocol
    let serviceLocator: Locator
    
    init(view: DetailsViewProtocol, video: Cartoon, serviceLocator: Locator) {
        self.view = view
        view.setVideo(video: video)
        self.serviceLocator = serviceLocator
    }
    
    func downloadFile(_ file: Cartoon) {
        guard let loadingService: LoadingService = serviceLocator.resolve(LoadingService.self),
              let filesManager: FilesManager = serviceLocator.resolve(FilesManager.self),
              let link = file.link else {
            return
        }
        if !filesManager.checkExitingFile(with: link) {
            loadingService.downloadFile(file) { [weak self] result in
                switch result {
                case .success:
                    break
                case .failure(_):
                    self?.view.setMessage(R.string.localizable.existing_file())
                }
            }
        } else {
            view.setMessage(R.string.localizable.existing_file())
        }
    }
}
