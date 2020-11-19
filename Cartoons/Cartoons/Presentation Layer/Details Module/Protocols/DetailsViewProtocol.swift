//
//  DetailsViewProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/12/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol DetailsViewProtocol: BaseViewControllerProtocol, DetailsTransitionDelegate {
    func setVideo(video: Cartoon)
    func setMessage(_ message: String)
}
