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
    var controlsView: CustomPlayerControls?
    private var player: AVPlayer? {
        playerView.player
    }
    var presenter: VideoPlayerPresenterProtocol?
    var playerState: PlayerState?
    var timeObserver: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAVPlayer()
        setTimeObserver()
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation { .slide }
    override var prefersStatusBarHidden: Bool { controlsView?.isHidden == true }
    override var prefersHomeIndicatorAutoHidden: Bool { true }
    
    override func loadView() {
        super.loadView()
        view = playerView
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        playerView.player = nil
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
        guard let controls = controlsView else {
            return
        }
        view.addSubview(controls)
        controls.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        view.isUserInteractionEnabled = true
        controls.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        view.addGestureRecognizer(tap)
    }
    
    override func showError(error: Error) {
        super.showError(error: error)
    }
    
    @objc func viewDidTap() {
        controlsView?.isHidden.toggle()
        navigationController?.navigationBar.isHidden.toggle()
    }
}

extension VideoPlayerViewController {
    func setupAVPlayer() {
        let url = "https://firebasestorage.googleapis.com/v0/b/cartoons-845b3.appspot.com/o/movies%2Ffrozen%2FDisney's%20Frozen%20Official%20Trailer.mp4?alt=media&token=86dd7b16-8322-43a1-a7ed-c4689c8004d4"
        playerView.player = AVPlayer(url: URL(string: url)!)
        player?.play()
        let seconds = player?.currentItem?.asset.duration.seconds
        let time = (seconds?.asString()).unwrapped
        presenter?.setDuration(value: time)
        playerState = .playing
    }
    
    func setTimeObserver() {
        let interval = CMTime(seconds: 1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserver = player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { elapsedTime in
            self.updateVideoPlayerState()
        })
    }
    
    func updateVideoPlayerState() {
        guard let currentTime = player?.currentTime() else { return }
        let currentTimeInSeconds = CMTimeGetSeconds(currentTime)
        var time = currentTime.seconds.asString()
        presenter?.updateProgress(value: Float(currentTimeInSeconds))
        presenter?.updateProgressValue(value: time)
        if let currentItem = player?.currentItem {
            let duration = currentItem.duration
            if (CMTIME_IS_INVALID(duration)) {
                return;
            }
            let currentTime = currentItem.currentTime()
            time = currentTime.seconds.asString()
            presenter?.updateProgress(value: Float(CMTimeGetSeconds(currentTime) / CMTimeGetSeconds(duration)))
            presenter?.updateProgressValue(value: time)
        }
    }
}

extension VideoPlayerViewController: VideoPlayerViewProtocol {
    func getDuration() -> Double {
        let seconds = player?.currentItem?.asset.duration.seconds
        return seconds.unwrapped
    }
    
    func setVideoTime(value: Double) {
        let seekTime = CMTime(value: CMTimeValue(value), timescale: 1)
        player?.seek(to: seekTime)
    }
    
    func jumpForward() {
        guard let player = playerView.player else {
            return
        }
        let currentTimeInSecondsPlus10 =  CMTimeGetSeconds(player.currentTime()).advanced(by: 10)
        let seekTime = CMTime(value: CMTimeValue(currentTimeInSecondsPlus10), timescale: 1)
        player.seek(to: seekTime)
    }
    
    func jumpBackward() {
        guard let player = playerView.player else {
            return
        }
        let currentTimeInSecondsMinus10 =  CMTimeGetSeconds(player.currentTime()).advanced(by: -10)
        let seekTime = CMTime(value: CMTimeValue(currentTimeInSecondsMinus10), timescale: 1)
        player.seek(to: seekTime)
    }
    
    func updateStatus() -> PlayerState? {
        guard let player = playerView.player else {
            return nil
        }
        if player.isPlaying {
            player.pause()
            playerState = .stopped
        } else {
            player.play()
            playerState = .playing
        }
        return playerState
    }
}

extension VideoPlayerViewController: UIGestureRecognizerDelegate { }
