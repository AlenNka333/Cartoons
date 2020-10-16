//
//  VideoPlayerPresenter.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/12/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

class VideoPlayerPresenter: VideoPlayerPresenterProtocol {
    var view: VideoPlayerViewProtocol
    var controls: VideoPlayerControlsProtocol
    var playerState: PlayerState?
    
    init(view: VideoPlayerViewProtocol, controls: VideoPlayerControlsProtocol) {
        self.view = view
        self.controls = controls
        self.playerState = .playing
        controls.videoStateChangedClosure = { [weak self] in
            self?.playerState = self?.view.updateStatus()
            return (self?.playerState)!
        }
        controls.jumpForwardClosure = { [weak self] in
            self?.view.jumpForward()
        }
        controls.jumpBackwardClosure = { [weak self] in
            self?.view.jumpBackward()
        }
    }
    
    func updateProgress(value: Float) {
    }
    
    func showError(error: Error) {
    }
}
