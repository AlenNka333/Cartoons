//
//  VideoPlayerViewPresenterProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/12/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol VideoPlayerViewProtocol: BaseViewControllerProtocol, PlayerTransitionDelegate {
    func setVideoPlayingStatus() -> PlayerState?
    func jumpForward()
    func jumpBackward()
    func getVideoDuration() -> Double
    func moveVideoToTime(value: Double)
    func setupObserver()
    func removeObserver()
    func rotateScreen() -> Bool
}
