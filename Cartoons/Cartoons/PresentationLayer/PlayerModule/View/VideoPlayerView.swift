//
//  VideoPlayerView.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/14/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//
//swiftlint:disable all
import AVFoundation
import Foundation
import UIKit

class VideoPlayerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        let url = "https://firebasestorage.googleapis.com/v0/b/cartoons-845b3.appspot.com/o/movies%2Ffrozen%2FDisney's%20Frozen%20Official%20Trailer.mp4?alt=media&token=86dd7b16-8322-43a1-a7ed-c4689c8004d4"
        let player = AVPlayer(url: URL(string: url)!)
        let playerLayer = AVPlayerLayer(player: player)
        self.layer.addSublayer(playerLayer)
        playerLayer.frame = CGRect(x: 10, y: 10, width: 200, height: 200)
        player.play()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
