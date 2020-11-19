//
//  VideoPlayerViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/31/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import AVFoundation
import AVKit
import Foundation
import UIKit

enum PlayerState {
    case playing
    case stopped
}

class VideoPlayerViewController: BaseViewController {
    weak var transitionDelegate: PlayerTransitionDelegate?
    var controlsView: CustomPlayerControls?
    var presenter: VideoPlayerPresenterProtocol?
    var videoPlayingState: PlayerState? {
        didSet {
            switch videoPlayingState {
            case .playing:
                player?.play()
            case .stopped:
                player?.pause()
            default:
                break
            }
        }
    }
    private var playerView = PlayerView()
    private var player: AVPlayer? { playerView.player }
    private var isRotated: Bool = false
    private var timeObserver: Any?
    private lazy var closeButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        button.setTitle(R.string.localizable.back(), for: .normal)
        return button
    }()
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation { .slide }
    override var prefersStatusBarHidden: Bool { true }
    override var prefersHomeIndicatorAutoHidden: Bool { true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        setupAVPlayer()
    }
    
    override func loadView() {
        view = playerView
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        playerView.player = nil
    }
    
    override func setupNavigationBar() {
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func setupUI() {
        super.setupUI()
        view.backgroundColor = .black
        view.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        view.addGestureRecognizer(tap)
        
        guard let controls = controlsView else {
            return
        }
        view.addSubview(controls)
        controls.isUserInteractionEnabled = true
        controls.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        view.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalToSuperview().offset(20)
        }
    }

    override func showError(error: Error) {
        super.showError(error: error)
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            videoPlayingState = .playing
            let seconds = player?.currentItem?.asset.duration.seconds
            let time = (seconds?.asString()).unwrapped
            presenter?.showVideoDuration(value: time)
        }
    }
}

extension VideoPlayerViewController {
    @objc func viewDidTap() {
        controlsView?.isHidden.toggle()
        closeButton.isHidden.toggle()
    }
    
    @objc func goBack() {
        presenter?.transit()
    }
    
    func setupAVPlayer() {
        let url = presenter?.setVideoURL()
        guard let link = url else {
            presenter?.showError(error: GeneralError.invalidUrl)
            return
        }
        playerView.player = AVPlayer(url: link)
        player?.play()
        player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        setupTimeObserver()
    }
    
    func setupTimeObserver() {
        let interval = CMTime(seconds: 1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserver = player?.addPeriodicTimeObserver(forInterval: interval,
                                                       queue: DispatchQueue.main) { elapsedTime in
            if self.player?.currentItem?.status == .readyToPlay {
                let currentTimeInSeconds = CMTimeGetSeconds(elapsedTime)
                let time = elapsedTime.seconds.asString()
                self.presenter?.updateCurrentVideoTimeLabel(value: time)
                if let currentItem = self.player?.currentItem {
                    let duration = currentItem.duration
                    if CMTIME_IS_INVALID(duration) {
                        return
                    }
                    self.presenter?.updateCurrentVideoTimeSlider(value: Float(currentTimeInSeconds / CMTimeGetSeconds(duration)))
                }
            }
        }
    }
}

extension VideoPlayerViewController: VideoPlayerViewProtocol {
    func transit() {
        transitionDelegate?.transit()
    }
    
    func getVideoDuration() -> Double {
        let seconds = player?.currentItem?.asset.duration.seconds
        return seconds.unwrapped
    }
    
    func moveVideoToTime(value: Double) {
        let seekTime = CMTime(value: CMTimeValue(value), timescale: 1)
        player?.seek(to: seekTime)
    }
    
    func jumpForward() {
        guard let player = playerView.player else {
            return
        }
        let currentTimeInSecondsPlus10 = CMTimeGetSeconds(player.currentTime()).advanced(by: 10)
        let seekTime = CMTime(value: CMTimeValue(currentTimeInSecondsPlus10), timescale: 1)
        player.seek(to: seekTime)
    }
    
    func jumpBackward() {
        guard let player = playerView.player else {
            return
        }
        let currentTimeInSecondsMinus10 = CMTimeGetSeconds(player.currentTime()).advanced(by: -10)
        let seekTime = CMTime(value: CMTimeValue(currentTimeInSecondsMinus10), timescale: 1)
        player.seek(to: seekTime)
    }
    
    func setVideoPlayingStatus() -> PlayerState? {
        guard let player = playerView.player else {
            return nil
        }
        videoPlayingState = player.isPlaying ? .stopped : .playing
        return videoPlayingState
    }
    
    func rotateScreen() -> Bool {
        UIView.animate(withDuration: 0.3) {
            let affineTransform = CGAffineTransform(rotationAngle: self.isRotated ? 0 : .pi / 2)
            self.playerView.layer.setAffineTransform(affineTransform)
            self.updateConstraints()
        }
        self.isRotated.toggle()
        return isRotated
    }
    
    func updateConstraints() {
        playerView.playerLayer.frame = CGRect(x: 0, y: 0, width: view.frame.height, height: view.frame.width)
    }
    
    func removeObserver() {
        guard let timeObserver = timeObserver else {
            return
        }
        player?.removeTimeObserver(timeObserver)
    }
    
    func setupObserver() {
        setupTimeObserver()
    }
}
