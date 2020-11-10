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
    var state: FileState
    var thumbnail: URL?
    var link: URL?
    var localPath: URL?
    var progress: Float
    
    init(title: String? = nil,
         state: FileState = .onServer,
         thumbnail: URL? = nil,
         link: URL? = nil,
         localPath: URL? = nil,
         progress: Float = 0.0) {
        self.title = title
        self.thumbnail = thumbnail
        self.link = link
        self.localPath = localPath
        self.state = state
        self.progress = progress
    }
    
    func setState(_ state: FileState) {
        self.state = state
    }
    
    func setProgress(_ progress: Float) {
        self.progress = progress
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Cartoon, rhs: Cartoon) -> Bool {
        lhs.id == rhs.id
    }
}
