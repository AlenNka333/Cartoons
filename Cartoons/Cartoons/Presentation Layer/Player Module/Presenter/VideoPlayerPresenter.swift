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
    var playerState: PlayerState
    let link: URL?
    
    init(view: VideoPlayerViewProtocol, controls: VideoPlayerControlsProtocol, link: URL?) {
        self.view = view
        self.controls = controls
        self.playerState = .playing
        self.link = link
        
        setupClosures()
    }
    
    func setupClosures() {
        controls.stateChangedClosure = { [weak self] in
            if let state = self?.view.updateStatus() {
                self?.playerState = state
                return state
            }
            return .stopped
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
        controls.removeObserverClosure = { [weak self] in
            self?.view.removeObserver()
        }
        controls.setupObserverClosure = { [weak self] in
            self?.view.setupObserver()
        }
        controls.orientationChangedClosure = { [weak self] in
            (self?.view.rotateScreen() ?? false)
        }
    }
    
    func setupVideoLink() -> URL? {
        return link
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
