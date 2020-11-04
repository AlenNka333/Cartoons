//
//  Queue.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 11/3/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

struct Queue<T> {
    private var elements: [T] = []
    
    mutating func enqueue(_ value: T) {
        elements.append(value)
    }
    
    mutating func dequeue() {
        guard !elements.isEmpty else {
            return
        }
        elements.removeFirst()
    }
    
    var head: T? {
        return elements.first
    }
    
    var tail: T? {
        return elements.last
    }
}

extension Queue {
    func getElements() -> [T] { elements }
}
