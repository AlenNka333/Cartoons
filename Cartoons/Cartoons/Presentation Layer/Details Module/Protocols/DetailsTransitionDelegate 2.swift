//
//  DetailsTransitionDelegate.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/29/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol DetailsTransitionDelegate: AnyObject {
    func transit(with link: URL)
}
