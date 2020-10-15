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

class CustomPlayerControl: UIView {
    @IBOutlet private weak var controlView: UIView!
    @IBOutlet private weak var slider: CustomSlider!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var goForwardButton: UIButton!
    @IBOutlet private weak var goBackwardButton: UIButton!
    @IBOutlet private weak var forwardButton: UIButton!
    @IBOutlet private weak var backwardButton: UIButton!
    @IBOutlet private weak var sound: UIButton!
    @IBOutlet private weak var currentTime: UILabel!
    @IBOutlet private weak var wholeTime: UILabel!
    
    var videoStateChangedClosure: (() -> (PlayerState))?

    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("PlayerControlsView", owner: self, options: nil)
        addSubview(controlView)
        controlView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
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
    }
    @IBAction private func goBackwardButtonClicked(_ sender: UIButton) {
    }
    @IBAction private func soundButtonClicked(_ sender: UIButton) {
    }
}
