//
//  AVPlayer + Extension.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/15/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import AVFoundation
import UIKit

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
