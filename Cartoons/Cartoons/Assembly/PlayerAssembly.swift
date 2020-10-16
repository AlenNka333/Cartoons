//
//  PlayerAssembly.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/16/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class PlayerAssembly: Assembly {
    static func makePlayerController() -> UIViewController {
        let view = VideoPlayerViewController()
        let controls = CustomPlayerControls()
        let presenter = VideoPlayerPresenter(view: view, controls: controls)
        view.presenter = presenter
        view.controlsView = controls
        return view
    }
}
