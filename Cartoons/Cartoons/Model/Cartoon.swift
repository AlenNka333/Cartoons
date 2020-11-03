//
//  Cartoon.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/12/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//
import UIKit

enum FileState {
    case onServer
    case inProgress
    case loaded
}

class Cartoon: Hashable {
    var id = UUID()
    var title: String
    var thumbnail: URL?
    var link: URL?
    var state: FileState = .onServer
    
    init(title: String, thumbnail: URL? = nil, link: URL?) {
        self.title = title
        self.thumbnail = thumbnail
        self.link = link
    }
    
    func setState(_ state: FileState) {
        self.state = state
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Cartoon, rhs: Cartoon) -> Bool {
        lhs.id == rhs.id
    }
}
