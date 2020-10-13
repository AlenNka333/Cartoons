//
//  Cartoon.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/12/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class Cartoon: Hashable {
//    var id = UUID()
//    var name: String
//    var description: String
//    var previewImage: URL?
//    var size: String?
//    var duration: String?
//    var link: URL?
//
//    init(name: String, description: String, previewImage: URL?, size: String? = nil, duration: String? = nil, link: URL? = nil) {
//        self.name = name
//        self.description = description
//        self.previewImage = previewImage
//        self.size = size
//        self.duration = duration
//        self.link = link
//    }
    var id = UUID()
    var title: String
    var thumbnail: UIImage?
    var lessonCount: Int
    var link: URL?
    
    init(title: String, thumbnail: UIImage? = nil, lessonCount: Int, link: URL?) {
      self.title = title
      self.thumbnail = thumbnail
      self.lessonCount = lessonCount
      self.link = link
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Cartoon, rhs: Cartoon) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Video Sample Data
extension Cartoon {
  static let allVideos = [
    Cartoon(
      title: "SwiftUI",
        thumbnail: R.image.main_background(),
      lessonCount: 37,
      link: URL(string: "https://www.raywenderlich.com/4001741-swiftui")
    ),
    Cartoon(
      title: "Data Structures & Algorithms in Swift",
      thumbnail:  R.image.main_background(),
      lessonCount: 29,
      link: URL(string: "https://www.raywenderlich.com/977854-data-structures-algorithms-in-swift")
    ),
    Cartoon(
      title: "Beginning ARKit",
      thumbnail:  R.image.main_background(),
      lessonCount: 46,
      link: URL(string: "https://www.raywenderlich.com/737368-beginning-arkit")
    ),
    Cartoon(
      title: "Fastlane for iOS",
      thumbnail:  R.image.main_background(),
      lessonCount: 44,
      link: URL(string: "https://www.raywenderlich.com/1259223-fastlane-for-ios")
    ),
    Cartoon(
      title: "Machine Learning in iOS",
      thumbnail:  R.image.main_background(),
      lessonCount: 15,
      link: URL(string: "https://www.raywenderlich.com/1320561-machine-learning-in-ios")
    ),
    Cartoon(
      title: "Beginning RxSwift",
      thumbnail: R.image.main_background(),
      lessonCount: 39,
      link: URL(string: "https://www.raywenderlich.com/4743-beginning-rxswift")
    ),
    Cartoon(
      title: "Demystifying Views in iOS",
      thumbnail: R.image.main_background(),
      lessonCount: 26,
      link: URL(string: "https://www.raywenderlich.com/4518-demystifying-views-in-ios")
    )
  ]
}
