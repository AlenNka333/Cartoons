//
//  Queue.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 11/2/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

struct Queue<T> {
    private var elements: [T] = []
    
    mutating func enqueue(_ value: T) {
        elements.append(value)
    }
    
    mutating func dequeue() -> T? {
        guard !elements.isEmpty else {
            return nil
        }
        return elements.removeFirst()
    }
    
    var head: T? { elements.first }
    var tail: T? { elements.last }
}
