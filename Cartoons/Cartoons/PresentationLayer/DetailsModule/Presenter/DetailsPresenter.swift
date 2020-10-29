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
    
    init(view: DetailsViewProtocol, video: Cartoon) {
        self.view = view
        view.setVideo(video: video)
    }
}
