//
//  Number.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 11/13/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

class Number: ObservableObject {
    var didChange = PassthroughSubject<String, Never>()
    var number = "" {
        didSet {
            didChange.send(number)
        }
    }
    
    func setNumber(_ num: String) {
        number = num
    }
}
