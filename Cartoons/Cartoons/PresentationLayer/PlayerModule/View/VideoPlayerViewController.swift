//
//  VideoPlayerViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/12/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//
//swiftlint:disable all
import AVFoundation
import AVKit
import Foundation
import UIKit

enum PlayerState {
    case playing
    case stopped
}

class VideoPlayerViewController: ViewController {
    
    private var playerView = PlayerView()
    private lazy var controlsView = CustomPlayerControl()
    private var player: AVPlayer? {
        playerView.player
    }
    var playerState: PlayerState?
    var timeObserver: Any?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAVPlayer()
    }
    
    override func loadView() {
        super.loadView()
        view = playerView
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
       super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (context) in
        }) { (context) in
            self.playerView.frame.size = size
        }
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func setupUI() {
        super.setupUI()
        tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .black
        playerView.addSubview(controlsView)
        controlsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        controlsView.videoStateChangedClosure = { [weak self] in
            self?.updateStatus()
            return (self?.playerState)!
        }
        controlsView.jumpForwardClosure = { [weak self] in
            self?.jumpForward()
        }
        controlsView.jumpBackwardClosure = { [weak self] in
            self?.jumpBackward()
        }
    }
    
    override func showError(error: Error) {
        super.showError(error: error)
    }
}

extension VideoPlayerViewController {
    func setupAVPlayer() {
        let url = "https://firebasestorage.googleapis.com/v0/b/cartoons-845b3.appspot.com/o/movies%2Ffrozen%2FDisney's%20Frozen%20Official%20Trailer.mp4?alt=media&token=86dd7b16-8322-43a1-a7ed-c4689c8004d4"
        playerView.player = AVPlayer(url: URL(string: url)!)
        player?.play()
        playerState = .playing
    }
    
    private func jumpForward() {
        guard let player = playerView.player else {
            return
        }
        let currentTimeInSecondsPlus10 =  CMTimeGetSeconds(player.currentTime()).advanced(by: 10)
        let seekTime = CMTime(value: CMTimeValue(currentTimeInSecondsPlus10), timescale: 1)
        player.seek(to: seekTime)
    }
    
    private func jumpBackward() {
        guard let player = playerView.player else {
            return
        }
        let currentTimeInSecondsMinus10 =  CMTimeGetSeconds(player.currentTime()).advanced(by: -10)
        let seekTime = CMTime(value: CMTimeValue(currentTimeInSecondsMinus10), timescale: 1)
        player.seek(to: seekTime)
    }
    
    private func updateStatus() {
        guard let player = playerView.player else {
            return
        }
        if player.isPlaying {
            player.pause()
            playerState = .stopped
        } else {
            player.play()
            playerState = .playing
        }
    }
}
