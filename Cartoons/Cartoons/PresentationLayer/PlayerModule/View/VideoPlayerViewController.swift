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

class VideoPlayerViewController: AVPlayerViewController {
    let alertView = CustomAlertView()
    let alertService = AlertService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
        setupAVPlayer()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setupUI() {
        tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .black
    }
    
    func showError(error: Error) {
        let alertVC = alertService.alert(title: R.string.localizable.error(), body: error.localizedDescription, alertType: .error) {_ in
            return
        }
        present(alertVC, animated: true)
    }
}

extension VideoPlayerViewController {
    func setupAVPlayer() {
        let url = "https://firebasestorage.googleapis.com/v0/b/cartoons-845b3.appspot.com/o/movies%2Ffrozen%2FDisney's%20Frozen%20Official%20Trailer.mp4?alt=media&token=86dd7b16-8322-43a1-a7ed-c4689c8004d4"
        let player = AVPlayer(url: URL(string: url)!)
        self.player = player
        self.showsPlaybackControls = false
        player.play()
    }
}
