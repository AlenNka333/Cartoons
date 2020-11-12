//
//  ImageLoader.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 11/12/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<UIImage, Never>()
    var data = UIImage() {
        didSet {
            didChange.send(data)
        }
    }
    
    func load(_ path: URL) {
        print("Start")
        let task = URLSession.shared.dataTask(with: path) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = UIImage(data: data) ?? UIImage()
            }
        }
        task.resume()
    }
}
