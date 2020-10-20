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
    @IBOutlet private weak var currentTimeLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    
    var stateChangedClosure: (() -> (PlayerState))?
    var jumpForwardClosure: () -> Void = {}
    var jumpBackwardClosure: () -> Void = {}
    var sendTimeClosure: (Double) -> Void = { _ in }
    var needVideoDurationClosure: (() -> (Double))?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed(Constants.controlsClassName, owner: self, options: nil)
        addSubview(controlView)
        controlView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction private func playPauseButtonClicked(_ sender: UIButton) {
        guard let closure = stateChangedClosure else {
            return
        }
        switch closure() {
        case .playing:
            playButton.setImage(R.image.stop(), for: .normal)
        case .stopped:
            playButton.setImage(R.image.play(), for: .normal)
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
        sendTimeClosure(Float64(slider.value) * closure())
    }
}

extension CustomPlayerControls: VideoPlayerControlsProtocol {
    func updateSlider(with value: Float) {
        slider.value = value
    }
    
    func updateCurrentTime(with time: String) {
        currentTimeLabel.text = time
    }
    
    func updateWholeTime(with time: String) {
        durationLabel.text = time
    }
}
