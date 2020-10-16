//
//  CustomPlayerControl.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/14/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import AVFoundation
import AVKit
import Foundation
import UIKit

class CustomPlayerControls: UIView {
    @IBOutlet private weak var controlView: UIView!
    @IBOutlet private weak var slider: CustomSlider!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var goForwardButton: UIButton!
    @IBOutlet private weak var goBackwardButton: UIButton!
    @IBOutlet private weak var forwardButton: UIButton!
    @IBOutlet private weak var backwardButton: UIButton!
    @IBOutlet private weak var currentTime: UILabel!
    @IBOutlet private weak var wholeTime: UILabel!
    
    var videoStateChangedClosure: (() -> (PlayerState))?
    var jumpForwardClosure: () -> Void = {}
    var jumpBackwardClosure: () -> Void = {}
    var setVideoTime: (Double) -> Void = { _ in }
    var needVideoDurationClosure: (() -> (Double))?
    
    private var duration: Double = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("PlayerControlsView", owner: self, options: nil)
        addSubview(controlView)
        controlView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        slider.isContinuous = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction private func playPauseButtonClicked(_ sender: UIButton) {
        guard let closure = videoStateChangedClosure else {
            return
        }
        switch closure() {
        case .playing:
            playButton.setImage(R.image.stopButton(), for: .normal)
        case .stopped:
            playButton.setImage(R.image.playButton(), for: .normal)
        }
    }
    @IBAction private func goForwardButtonClicked(_ sender: UIButton) {
        jumpForwardClosure()
    }
    @IBAction private func goBackwardButtonClicked(_ sender: UIButton) {
        jumpBackwardClosure()
    }
    @IBAction private func updateProgress(_ sender: CustomSlider) {
        guard let closure = needVideoDurationClosure else {
            return
        }
        duration = closure()
        let value = Float64(slider.value) * duration
        setVideoTime(value)
    }
}

extension CustomPlayerControls: VideoPlayerControlsProtocol {
    func updateSlider(with value: Float) {
        slider.value = value
    }
    
    func updateCurrentTime(with time: String) {
        currentTime.text = time
    }
    
    func updateWholeTime(with time: String) {
        wholeTime.text = time
    }
}
