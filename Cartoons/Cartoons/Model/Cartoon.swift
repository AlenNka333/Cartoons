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
    var title: String?
    var state: FileState = .onServer
    var thumbnail: URL?
    var link: URL?
    var localPath: URL?
    
    init(title: String? = nil, state: FileState, thumbnail: URL? = nil, link: URL? = nil, localPath: URL? = nil) {
        self.title = title
        self.thumbnail = thumbnail
        self.link = link
        self.localPath = localPath
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
