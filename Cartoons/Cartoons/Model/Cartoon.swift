//
//  Cartoon.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/12/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//
import UIKit

enum FileState {
    case inStorage
    case inProgress
    case downloaded
}

class Cartoon: Hashable {
    var id = UUID()
    var title: String?
    var loadingState: FileState
    var thumbnailImageURL: URL?
    var globalCartoonLink: URL?
    var localCartoonLink: URL?
    var loadedBytesCount: Float
    
    init(title: String? = nil,
         loadingState: FileState = .inStorage,
         thumbnailImageURL: URL? = nil,
         globalCartoonLink: URL? = nil,
         localCartoonLink: URL? = nil,
         loadedBytesCount: Float = 0.0) {
        self.title = title
        self.loadingState = loadingState
        self.thumbnailImageURL = thumbnailImageURL
        self.globalCartoonLink = globalCartoonLink
        self.localCartoonLink = localCartoonLink
        self.loadedBytesCount = loadedBytesCount
    }
    
    func setState(_ loadingState: FileState) {
        self.loadingState = loadingState
    }
    
    func setProgress(_ loadedBytesCount: Float) {
        self.loadedBytesCount = loadedBytesCount
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Cartoon, rhs: Cartoon) -> Bool {
        lhs.id == rhs.id
    }
}
