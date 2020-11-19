//
//  VideoPlayerPresenter.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/12/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

class VideoPlayerPresenter: VideoPlayerPresenterProtocol {
    let videoURL: URL?
    
    var view: VideoPlayerViewProtocol
    var controls: VideoPlayerControlsProtocol
    var playerState: PlayerState
    
    init(view: VideoPlayerViewProtocol, controls: VideoPlayerControlsProtocol, videoURL: URL?) {
        self.view = view
        self.controls = controls
        self.playerState = .playing
        self.videoURL = videoURL
        
        setupClosures()
    }
    
    func setupClosures() {
        controls.stateChangedClosure = { [weak self] in
            if let state = self?.view.setVideoPlayingStatus() {
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
            return (self?.view.getVideoDuration()).unwrapped
        }
        controls.sendTimeClosure = { [weak self] time in
            self?.view.moveVideoToTime(value: time)
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
    
    func transit() {
        view.transit()
    }
    
    func setVideoURL() -> URL? {
        return videoURL
    }
    
    func showVideoDuration(value: String) {
        controls.updateWholeTime(with: value)
    }
    
    func updateCurrentVideoTimeSlider(value: Float) {
        controls.updateSlider(with: value)
    }
    
    func updateCurrentVideoTimeLabel(value: String) {
        controls.updateCurrentTime(with: value)
    }
    
    func showError(error: Error) {
        view.showError(error: error)
    }
}
