//
//  VideoPlayerViewPresenterProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/12/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol VideoPlayerViewProtocol: BaseViewProtocol, AnyObject {
    func updateStatus() -> PlayerState?
    func jumpForward()
    func jumpBackward()
    func getDuration() -> Double
    func setVideoTime(value: Double)
    func setupObserver()
    func removeObserver()
}
