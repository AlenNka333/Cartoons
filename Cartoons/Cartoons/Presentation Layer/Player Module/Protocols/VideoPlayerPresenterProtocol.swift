//
//  VideoPlayerPresenterProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/12/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol VideoPlayerPresenterProtocol: AnyObject {
    func transit()
    func setVideoURL() -> URL?
    func showError(error: Error)
    func showVideoDuration(value: String)
    func updateCurrentVideoTimeSlider(value: Float)
    func updateCurrentVideoTimeLabel(value: String)
}
