//
//  VideoPlayerPresenterProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/12/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol VideoPlayerPresenterProtocol: PresenterProtocol, AnyObject {
    func setupVideoLink() -> URL?
    func setDuration(value: String)
    func updateProgress(value: Float)
    func updateProgressValue(value: String)
}
