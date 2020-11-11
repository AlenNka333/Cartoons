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
    @IBOutlet private weak var fullScreenButton: UIButton!
    @IBOutlet weak var controlsHeight: NSLayoutConstraint!
    
    var stateChangedClosure: (() -> (PlayerState))?
    var jumpForwardClosure: (() -> Void)?
    var jumpBackwardClosure: (() -> Void)?
    var sendTimeClosure: ((Double) -> Void)?
    var needVideoDurationClosure: (() -> (Double))?
    var removeObserverClosure: (() -> Void)?
    var setupObserverClosure: (() -> Void)?
    var orientationChangedClosure: (() -> (Bool))?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed(AppEnvironment.Classes.controlsClassName, owner: self, options: nil)
        addSubview(controlView)
        controlView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        slider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
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
        guard let closure = jumpForwardClosure else {
            return
        }
        closure()
    }
    
    @IBAction private func goBackwardButtonClicked(_ sender: UIButton) {
        guard let closure = jumpBackwardClosure else {
            return
        }
        closure()
    }
    
    @IBAction private func fullScreenAction(_ sender: UIButton) {
        guard let closure = orientationChangedClosure else {
            return
        }
        if closure() {
            controlsHeight.constant = 100
            UIApplication.shared.isStatusBarHidden = true
            fullScreenButton.setImage(R.image.small_screen(), for: .normal)
        } else {
            controlsHeight.constant = 200
            UIApplication.shared.isStatusBarHidden = false
            fullScreenButton.setImage(R.image.fullscreen(), for: .normal)
        }
    }
}

extension CustomPlayerControls {
    @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
        if let durationClosure = needVideoDurationClosure,
           let removeClosure = removeObserverClosure,
           let setupClosure = setupObserverClosure {
            guard let closure = sendTimeClosure else {
                return
            }
            closure(Float64(slider.value) * durationClosure())
            if let touchEvent = event.allTouches?.first {
                switch touchEvent.phase {
                case .began:
                    removeClosure()
                    updateState()
                case .moved:
                    break
                case .ended:
                    setupClosure()
                    updateState()
                    playButton.setImage(R.image.stop(), for: .normal)
                default:
                    break
                }
            }
        }
    }
    
    func updateState() {
        guard let stateChangedClosure = stateChangedClosure else {
            return
        }
        switch stateChangedClosure() {
        case .playing:
            playButton.setImage(R.image.stop(), for: .normal)
        case .stopped:
            playButton.setImage(R.image.play(), for: .normal)
        }
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
