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
    
    private var playerView = PlayerView()
    private lazy var controlsView = CustomPlayerControl()
    private var player: AVPlayer? {
        playerView.player
    }
    
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
    }
}
