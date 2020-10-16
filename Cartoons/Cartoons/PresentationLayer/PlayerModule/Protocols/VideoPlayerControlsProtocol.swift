//
//  VideoPlayerControlsProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/16/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol VideoPlayerControlsProtocol: AnyObject {
    var videoStateChangedClosure: (() -> (PlayerState))? { get set }
    var jumpForwardClosure: () -> Void { get set }
    var jumpBackwardClosure: () -> Void { get set }
    
    func updatePlayerButton(state: PlayerState)
    func updateSlider(with value: Float)
    func updateCurrentTime(with time: String)
    func updateWholeTime(with time: String)
}
