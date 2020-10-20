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
        controls.stateChangedClosure = { [weak self] in
            self?.playerState = self?.view.updateStatus()
            return (self?.playerState)!
        }
        controls.jumpForwardClosure = { [weak self] in
            self?.view.jumpForward()
        }
        controls.jumpBackwardClosure = { [weak self] in
            self?.view.jumpBackward()
        }
        controls.needVideoDurationClosure = { [weak self] in
            return (self?.view.getDuration()).unwrapped
        }
        controls.sendTimeClosure = { [weak self] time in
            self?.view.setVideoTime(value: time)
        }
    }
    
    func setDuration(value: String) {
        controls.updateWholeTime(with: value)
    }
    
    func updateProgress(value: Float) {
        controls.updateSlider(with: value)
    }
    
    func updateProgressValue(value: String) {
        controls.updateCurrentTime(with: value)
    }
    
    func showError(error: Error) {
        view.showError(error: error)
    }
}
