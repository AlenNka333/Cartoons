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
    
    func downloadFile(from url: URL) {
        guard let loadingService: LoadingService = serviceLocator.resolve(LoadingService.self) else {
            return
        }
        loadingService.downloadFile(from: url)
    }
}
