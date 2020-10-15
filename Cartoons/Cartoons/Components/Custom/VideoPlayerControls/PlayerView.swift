//
//  PlayerView.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/15/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import AVFoundation
import UIKit
//swiftlint:disable all

final class PlayerView: UIView {
    override class var layerClass: AnyClass {
        AVPlayerLayer.self
    }
    
    var playerLayer: AVPlayerLayer {
        layer as! AVPlayerLayer
    }
    
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
}
