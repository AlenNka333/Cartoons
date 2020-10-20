//
//  Cartoon.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/12/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//
//swiftlint:disable all
import UIKit

class Cartoon: Hashable {
    var id = UUID()
    var title: String
    var thumbnail: URL?
    var link: URL?
    
    init(title: String, thumbnail: URL? = nil, link: URL?) {
        self.title = title
        self.thumbnail = thumbnail
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
  static var allVideos = [
//    Cartoon(
//      title: "SwiftUI",
//        thumbnail: URL(string: "https://firebasestorage.googleapis.com/v0/b/cartoons-845b3.appspot.com/o/profile_images%2FDPeHuzP1vOTR9RVvohmV1vq25LF2?alt=media&token=6c249320-a356-4535-9a8e-c6100e9c8e61"),
//        link: URL(string: "https://www.raywenderlich.com/977854-data-structures-algorithms-in-swift")
//      ),
//    Cartoon(
//      title: "Data Structures & Algorithms in Swift",
//      thumbnail: URL(string: "https://firebasestorage.googleapis.com/v0/b/cartoons-845b3.appspot.com/o/profile_images%2FDPeHuzP1vOTR9RVvohmV1vq25LF2?alt=media&token=6c249320-a356-4535-9a8e-c6100e9c8e61"),
//      link: URL(string: "https://www.raywenderlich.com/977854-data-structures-algorithms-in-swift")
//    ),
//    Cartoon(
//      title: "Beginning ARKit",
//      thumbnail: URL(string: "https://firebasestorage.googleapis.com/v0/b/cartoons-845b3.appspot.com/o/profile_images%2FDPeHuzP1vOTR9RVvohmV1vq25LF2?alt=media&token=6c249320-a356-4535-9a8e-c6100e9c8e61"),
//      link: URL(string: "https://www.raywenderlich.com/737368-beginning-arkit")
//    ),
//    Cartoon(
//      title: "Fastlane for iOS",
//      thumbnail: URL(string: "https://firebasestorage.googleapis.com/v0/b/cartoons-845b3.appspot.com/o/profile_images%2FDPeHuzP1vOTR9RVvohmV1vq25LF2?alt=media&token=6c249320-a356-4535-9a8e-c6100e9c8e61"),
//      link: URL(string: "https://www.raywenderlich.com/1259223-fastlane-for-ios")
//    ),
//    Cartoon(
//      title: "Machine Learning in iOS",
//      thumbnail: URL(string: "https://firebasestorage.googleapis.com/v0/b/cartoons-845b3.appspot.com/o/profile_images%2FDPeHuzP1vOTR9RVvohmV1vq25LF2?alt=media&token=6c249320-a356-4535-9a8e-c6100e9c8e61"),
//      link: URL(string: "https://www.raywenderlich.com/1320561-machine-learning-in-ios")
//    ),
//    Cartoon(
//      title: "Beginning RxSwift",
//      thumbnail: URL(string: "https://firebasestorage.googleapis.com/v0/b/cartoons-845b3.appspot.com/o/profile_images%2FDPeHuzP1vOTR9RVvohmV1vq25LF2?alt=media&token=6c249320-a356-4535-9a8e-c6100e9c8e61"),
//      link: URL(string: "https://www.raywenderlich.com/4743-beginning-rxswift")
//    ),
//    Cartoon(
//      title: "Demystifying Views in iOS",
//      thumbnail: URL(string: "https://firebasestorage.googleapis.com/v0/b/cartoons-845b3.appspot.com/o/profile_images%2FDPeHuzP1vOTR9RVvohmV1vq25LF2?alt=media&token=6c249320-a356-4535-9a8e-c6100e9c8e61"),
//      link: URL(string: "https://www.raywenderlich.com/4518-demystifying-views-in-ios")
//    )
//  ]
    Cartoon
    ]()
}
