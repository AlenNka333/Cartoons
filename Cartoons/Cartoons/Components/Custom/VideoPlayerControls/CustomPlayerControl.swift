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
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var slider: CustomSlider!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var goForwardButton: UIButton!
    @IBOutlet weak var goBackwardButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var backwardButton: UIButton!
    
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
}
