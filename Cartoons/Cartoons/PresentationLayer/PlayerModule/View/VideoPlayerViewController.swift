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

class VideoPlayerViewController: ViewController {
    
    private var playerLayer: AVPlayerLayer?
    private var playerView = UIView()
    private lazy var controlsView = CustomPlayerControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if UIDevice.current.orientation.isLandscape {
            playerLayer?.frame = view.frame
        } else {
            playerLayer?.frame.size = CGSize(width: view.frame.width, height: view.frame.height / 3)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSize()
        setupAVPlayer()
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
        view.addSubview(controlsView)
        controlsView.backgroundColor = .clear
        controlsView.snp.makeConstraints {
            $0.trailing.leading.top.bottom.equalToSuperview()
        }
        view.addSubview(playerView)
        playerView.backgroundColor = .blue
        playerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        playerView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-200)
        }
    }
    
    override func showError(error: Error) {
        super.showError(error: error)
    }
}

extension VideoPlayerViewController {
    func setupSize() {
        playerView.frame.size = CGSize(width: view.frame.width, height: view.frame.height / 3)
    }
    
    func setupAVPlayer() {
        let url = "https://firebasestorage.googleapis.com/v0/b/cartoons-845b3.appspot.com/o/movies%2Ffrozen%2FDisney's%20Frozen%20Official%20Trailer.mp4?alt=media&token=86dd7b16-8322-43a1-a7ed-c4689c8004d4"
        let player = AVPlayer(url: URL(string: url)!)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = playerView.bounds
        playerView.layer.addSublayer(playerLayer!)
        view.sendSubviewToBack(playerView)
        player.play()
    }
}
