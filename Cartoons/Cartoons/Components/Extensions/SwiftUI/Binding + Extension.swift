//
//  Binding + Extension.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 11/12/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import SwiftUI
import Foundation

extension Binding {
    func onUpdate(_ closure: @escaping () -> Void) -> Binding<Value> {
        Binding(get: {
            wrappedValue
        },
        set: { newValue in
            wrappedValue = newValue
            closure()
        })
    }
}
