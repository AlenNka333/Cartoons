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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAVPlayer()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
       super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (context) in
        }) { (context) in
            self.playerLayer?.frame.size = size
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
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(playerView)
        playerView.backgroundColor = .blue
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    override func showError(error: Error) {
        super.showError(error: error)
    }
}

extension VideoPlayerViewController {
    func setupAVPlayer() {
        playerView.frame.size = CGSize(width: view.frame.width, height: 200)
        let url = "https://firebasestorage.googleapis.com/v0/b/cartoons-845b3.appspot.com/o/movies%2Ffrozen%2FDisney's%20Frozen%20Official%20Trailer.mp4?alt=media&token=86dd7b16-8322-43a1-a7ed-c4689c8004d4"
        let player = AVPlayer(url: URL(string: url)!)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = playerView.bounds
        playerView.layer.addSublayer(playerLayer!)
        //playerLayer?.frame = CGRect(origin: .zero, size: view.bounds.size)
        //view.layer.addSublayer(playerLayer!)
        
        player.play()
    }
}
